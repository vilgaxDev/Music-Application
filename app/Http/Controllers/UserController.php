<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use Illuminate\Support\Facades\Hash;
use App\User;
use App\Notifications\ArtistRequest;
use App\Artist;
use App\Exceptions\FEException;
use App\Plan;
use App\Permission;
use Carbon\Carbon;

use FileManager;

use App\Http\Resources\UserResource;

use App\Http\Resources\SongResource;
use App\Http\Resources\ArtistResource;
use App\Http\Resources\AlbumResource;
use App\Http\Resources\PodcastResource;
use App\Http\Resources\PlaylistResource;
use App\Http\Resources\profiles\UserResource as UserProfileResource;
use App\Subscription;
use Illuminate\Support\Facades\Notification;
use App\Helpers\Billing\StripeAPI;
use App\Helpers\Billing\PayPalAPI;
use App\PodcastFollow;

class UserController extends Controller 
{
    /**
     * Get the account informations of the current logged user.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function account(Request $request)
    {
        return new UserResource($request->user());
    }

    /**
     * Sub the user for a plan.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function subscribe(Request $request)
    {
        $user = auth()->user();
        $plan = Plan::find($request->plan['id']);
        
        if( $subscription = $user->active_subscription()->first() ) {
            $this->cancelCurrentSubscription($subscription->id);
        } 
        // creating the subscription on Stripe if the plan is not free and the connection is set
        $this->createSubscription($user, $plan, $request->all());

        return response()->json(['message' => 'SUCCESS'], 200);
    }

    /**
     * Sub the user for a plan.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function createSubscription(User $user, Plan $plan, $request)
    {
        // creating the subscription on Gatways
        $gateway = $request['gateway'];
        if( !$plan->free ) {
            if($gateway === 'stripe') {
                $paymentMethod = isSet($request['paymentMethod']) ? $request['paymentMethod'] : null;
                try {
                    $stripe = new StripeAPI();
                    $stripe_subscription = $stripe->createSubscription($user, $plan, $paymentMethod);
                    $gateway_id =  $stripe_subscription->id;
                } catch (\Exception $e) {
                    throw $e;
                }
            }
            if($gateway === 'paypal') {
                // subscription is created on the client after the approval of the client
                $gateway_id = $request['paypal_subscription_id'];
            }
        }
        // creating the subscription on the local database
        Subscription::create([
            'plan_id' => $plan->id,
            'user_id' => $user->id,
            'status' => 'active',
            'gateway' => $gateway,
            'gateway_id' => isSet($gateway_id) ? $gateway_id : null,
            // 'renews_at' => isSet($stripe_subscription) ? Carbon::createFromTimestamp($stripe_subscription->current_period_end)->toDateTimeString() : null
        ]);

        return response()->json(['message' => 'SUCCESS'], 200);
    }

    /**
     * Cancel a subscription.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function cancelSubscriptionRequest(Request $request)
    {
        if( !Hash::check($request->password, auth()->user()->password)) {
            return response()->json(['message' => 'Incorrect password'], 400);
        }

        return $this->cancelCurrentSubscription($request->subscription_id);
    }

    /**
     * Cancel a subscription.
     * @param  \Illuminate\Http\Subscription  $subscription
     * @return \Illuminate\Http\Response
     */
    public function cancelCurrentSubscription($subscription_id)
    {
        $subscription = Subscription::find($subscription_id);
        if( $subscription->gateway_id ) {
            if( $subscription->gateway === 'stripe' ) {
                $stripe = new StripeAPI();
                try {
                    $stripe->cancelSubscription($subscription);
                } catch (\Exception $e) {
                    throw new FEException('Failed to delete subscription from Stripe', $e->getMessage(), 400);
                }
            }
            if( $subscription->gateway === 'paypal' ) {
                $paypal = new PayPalAPI();
                try {
                    $paypal->cancelSubscription($subscription);
                } catch (\Exception $e) {
                    throw new FEException('Failed to delete subscription from PayPal', $e->getMessage(), 400);
                }
            }
        }
        $subscription->status = 'canceled';
        return $subscription->save();
    }

    /**
     * Get all the users.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return UserResource::collection(User::where('is_admin', 0)->orderBy('created_at', 'desc')->get());
    }
    /**
     * Get the user data to display the profile.
     *
     * @param  \App\User  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $user = User::find($id);
        if ($user) {
            return new UserProfileResource($user);
        } else {
            return response()->json(['message' => 'NOT_FOUND'], 404);
        }
    }
    /**
     * store the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'email' => 'required|email|unique:users',
            'name' => 'required|unique:users',
            'password' => 'required|min:8',
        ]);
        $avatar = FileManager::store($request, '/avatars/users/', 'avatar');
        $user = User::create([
            'email' =>  $request->email,
            'name' =>  $request->name,
            'available_disk_space' => $request->available_disk_space,
            'password' =>  Hash::make($request->password),
            'avatar' => $avatar
        ]);
        // attaching the roles
        if (isset($request->roles)) {
            foreach (json_decode($request->roles) as $role) {
                if( $role->id != '3') { 
                    // the user role id is 3 will be attached after
                    // the creation of the user automatically
                    $user->roles()->attach($role->id);
                }
            }
        }
        if (isset($request->permissions)) {
            $this->updatePermissions($user, json_decode($request->permissions, true));
        }
        return response()->json(null, 201);
    }
    /**
     * Get the current user notifications.
     *
     * @return \Illuminate\Http\Response
     */
    public function notifications()
    {
        $user = auth()->user();
        return $user->notifications()->where('type', 'App\\Notifications\\FriendRequest')->get();
    }
    /**
     * Update the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\user  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'email' => 'required|email|unique:users,email,' . $id,
            'name' => 'required|unique:users,name,' . $id,
            'password' => 'min:8'
        ]);
        $user = User::find($id);
        if ($request->file('avatar')) {
            $avatar = FileManager::update($request->file('avatar'), $user->avatar, '/avatars/users/');
            $user->avatar = $avatar;
        }
        if (isset($request->roles)) {
            $this->updateRoles($user, json_decode($request->roles, true));
        }
        if (isset($request->permissions)) {
            $this->updatePermissions($user, json_decode($request->permissions, true));
        }
        // logout the user
        $user->tokens->each(function ($token) {
            $token->delete();
        });
        $user->email = $request->email;
        $user->available_disk_space = $request->available_disk_space;
        $user->name = $request->name;
        if (isset($request->password)) {
            $user->password = Hash::make($request->password);
        }
        $user->save();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Update the roles of the user.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  $roles
     * @return \Illuminate\Http\Response
     */
    public static function updateRoles(User $user, $roles)
    {
        // detach all roles
        \DB::table('role_user')->where('user_id', $user->id)->delete();
        foreach ($roles as $role) {
            $user->roles()->attach($role['id']);
        }
    }
    /**
     * Update the permissions of the user.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  $permissions
     * @return \Illuminate\Http\Response
     */
    public function updatePermissions(User $user, $permissions)
    {
        // detach all permissions
        \DB::table('user_permission')->where('user_id', $user->id)->delete();
        // attach the given permissions
        foreach ($permissions as $permission) {
            Permission::find($permission['id']);
            $user->permissions()->attach($permission['id']);
        }
    }
    /**
     * Save the account settings.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function saveAccountSettings(Request $request)
    {
        $request->validate([
            'name' => 'required'
        ]);
        $user = User::find($request->id);
        if ($request->currentPassword || $request->newPassword) {
            $request->validate([
                'newPassword' => 'required|min:8'
            ]);
            $request->validate([
                'currentPassword' => 'required|min:8'
            ]);
            if (!Hash::check($request->currentPassword, $user->password)) {
                throw new FEException('Current password does not match', '', 422);
            }
            $user->password = Hash::make($request->newPassword);
        }
        if ($request->file('avatar')) {
            $user->avatar = FileManager::update($request->file('avatar'), $user->avatar, '/avatars/users/');
        }
        $user->name = $request->name;
        $user->lang = $request->lang;
        $user->hide_activity = $request->hide_activity ? 1 : 0;
        $user->save();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Send notifcation to the admins: artist account request.
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function requestArtistAccount(Request $request)
    {
        $request->validate([
            'firstname' => 'required|min:3',
            'lastname' => 'required|min:3',
            'displayname' => 'required|min:3|unique:artists',
        ]);

        $avatar = FileManager::store($request, '/avatars/artists/', 'avatar');

        $artist = Artist::create([
            'firstname' => $request->firstname,
            'lastname' => $request->lastname,
            'displayname' => $request->displayname,
            'avatar' => $avatar
        ]);
        $admins = User::whereHas('roles', function ($query) {
            $query->where('name', 'admin');
        })->orWhere('is_admin', 1)->get();
        $user = \Auth::user();

        Notification::send($admins, new ArtistRequest($user, new ArtistResource($artist)));
        $user->requested_artist_account = 1;
        $user->save();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Get the current user playlists.
     *
     * @return \Illuminate\Http\Response
     */
    public function playlists()
    {
        $user = \Auth::user();
        $playlists = new \stdClass();
        $playlists->followed = PlaylistResource::collection(\App\PlaylistFollow::where('user_id', auth()->id())->with('playlist')->get()->pluck('playlist'));
        $playlists->own = PlaylistResource::collection($user->playlists()->where('created_by', '!=', 'admin')->get());
        return response()->json($playlists, 200);
    }
    /**
     * Get the current user followed playlists.
     *
     * @return \Illuminate\Http\Response
     */
    public function followedPlaylists()
    {
        return PlaylistResource::collection(\App\PlaylistFollow::where('user_id', auth()->id())->with('playlist')->get()->pluck('playlist'));
    }
    /**
     * Get the current user recent plays.
     *
     * @return \Illuminate\Http\Response
     */
    public function recentPlays()
    {
        $user = \Auth::user();
        return SongResource::collection(\App\Song::whereIn('id',$user->plays()->selectRaw('content_id, COUNT(*)')->groupBy('content_id')->get()->pluck('content_id'))->orderBy('created_at','desc')->take(10)->get());
    }
    /**
     * Get the current user liked albums.
     *
     * @return \Illuminate\Http\Response
     */
    public function likedAlbums()
    {
        $user = auth()->user();
        return AlbumResource::collection(\App\AlbumLike::where('user_id', $user->id)->with('album')->get()->pluck('album'));
    }
    /**
     * Get the current user liked songs.
     *
     * @return \Illuminate\Http\Response
     */
    public function likedSongs()
    {
        return SongResource::collection(\App\SongLike::where('user_id', auth()->user()->id)->with('song')->get()->pluck('song')->filter(function ($value, $key) {
            return $value != null;
        }));
    }
    /**
     * Get the current user followed podcasts.
     *
     * @return \Illuminate\Http\Response
     */
    public function followedPodcasts()
    {
        return PodcastResource::collection(\App\PodcastFollow::where('user_id', auth()->user()->id)->with('podcast')->get()->pluck('podcast'));
    }
    /**
     * Follow a playlist.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function followPlaylist(Request $request)
    {
        if (!\App\PlaylistFollow::where('user_id', auth()->id())->where('playlist_id', $request->playlist_id)->first()) {
            \App\PlaylistFollow::create([
                'user_id' => auth()->id(),
                'playlist_id' => $request->playlist_id
            ]);
            return response()->json(['message' => 'SUCCESS'], 200);
        }
    }
    /**
     * Unfollow a playlist.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function unFollowPlaylist(Request $request)
    {
        if ($follow = \App\PlaylistFollow::where('user_id', auth()->id())->where('playlist_id', $request->playlist_id)->first()) {
            $follow->delete();
            return response()->json(['message' => 'SUCCESS'], 200);
        }
        return response()->json(['message' => 'NOT_FOUND'], 404);
    }
    /**
     * Follow an artist.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function followArtist(Request $request)
    {
        $user_id = $request->user_id;
        $artist_id = $request->artist_id;
        \App\ArtistFollow::create([
            'user_id' => $user_id,
            'artist_id' => $artist_id
        ]);
        return true;
    }
    /**
     * Unfollow an artist.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function unfollowArtist(Request $request)
    {
        $user_id = $request->user_id;
        $artist_id = $request->artist_id;
        $follow = \App\ArtistFollow::where([
            'user_id' => $user_id,
            'artist_id' => $artist_id
        ]);
        $follow->delete();
        return true;
    }
    /**
     * Get the current user followed artists.
     *
     * @return \Illuminate\Http\Response
     */
    public static function followedArtists($id = null)
    {
        if (isset($id)) {
            $follows = ArtistResource::collection(\App\ArtistFollow::where('user_id', User::find($id))->with('artist')->get()->pluck('artist'));
        } else {
            $follows = ArtistResource::collection(\App\ArtistFollow::where('user_id', \Auth::user()->id)->with('artist')->get()->pluck('artist'));
        }

        return $follows;
    }
    /**
     * Like a song.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function likeSong(Request $request)
    {
        if (!\App\SongLike::where('song_id', $request->id)->where('user_id', auth()->user()->id)->first()) {
            \App\SongLike::create([
                'song_id' => $request->id,
                'user_id' => auth()->user()->id
            ]);
        }
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Unlike a song.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function unlikeSong(Request $request)
    {
        $like = \App\SongLike::where('song_id', $request->id)->where('user_id', auth()->user()->id)->first();
        $like->delete();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Follow a podcast.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */

    public function followPodcast(Request $request)
    {
        $user = \Auth::user();
        return PodcastFollow::create([
            'user_id' => $user->id,
            'podcast_id' => $request->podcast_id
        ]);
    }
    /**
     * Unfollow a podcast.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function unfollowPodcast(Request $request)
    {
        $user = \Auth::user();
        $podcast_follow = PodcastFollow::where([
            'user_id' => $user->id,
            'podcast_id' => $request->podcast_id
        ])->first();
        return $podcast_follow->delete();
    }
    /**
     * Like an album.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function likeAlbum(Request $request)
    {
        $user = auth()->user();
        return \App\AlbumLike::create([
            'user_id' => $user->id,
            'album_id' => $request->album_id
        ]);
    }
    /**
     * Unlike an album.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function unlikeAlbum(Request $request)
    {
        $user = auth()->user();
        $album_like = \App\AlbumLike::where([
            'user_id' => $user->id,
            'album_id' => $request->album_id
        ])->first();
        return $album_like->delete();
    }
        /**
     * Match the users based for the gives keyword ( search ).
     * @param $keyword
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function matchUsers($keyword)
    {
        return UserResource::collection(User::where('email', 'like', '%' . $keyword . '%')->where('is_admin', 0)->get());
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\User  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $user = User::find($id);
        $user->delete();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
}
