<?php

namespace App\Http\Controllers;

use App\Events\HearingEvent;
use App\Helpers\Functions;
use App\Play;
use App\Setting;
use Illuminate\Http\Request;

class PlayController extends Controller
{
        /**
     * When a user play a song his status is gonna be updated ( is_playing ).
     * When it's ended or the user quit the page this function resets the recent status to 'null'.
     * @return \Illuminate\Http\Response
     */
    public function endPlay()
    {
        if (auth()->user()) {
            auth()->user()->is_playing = null;
            auth()->user()->save();
            if (Setting::get('enableRealtime')) {
                broadcast(new HearingEvent(auth()->user()->id, null));
            }
        }
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * When a user play a song his status is gonna be updated ( is_playing ),
     * this function updates the recent status and increase the played 
     * song count.
     *
     * @return \Illuminate\Http\Response
     */
    public function userPlay(Request $request)
    {
        $user_id =  auth()->user()->id;
        if (Setting::get('enableRealtime') && ($request->type === 'episode' || $request->type == 'song' || $request->type == 'radio-station')) {
            $played_content = Functions::whatIsBeingPlayed($request->type, $request->id);
            if (!auth()->user()->hide_activity) {
                auth()->user()->is_playing = json_encode($played_content);
                auth()->user()->save();
                broadcast(new HearingEvent(auth()->user()->id, $played_content));
            }
        }
        Play::create([
            'user_id' => $user_id,
            'content_type' => $request->type,
            'content_id' => $request->id,
            // 'title' => $played_content->title,
            // 'artists' => $played_content->artists,
            // 'parent_title' => $played_content->parent_title,
        ]);
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Increase the played song count.
     *
     * @return \Illuminate\Http\Response
     */
    public function anonymousPlay(Request $request)
    {
        Play::create([
            'content_id' => $request->id,
            'content_type' => $request->type
        ]);
        return response()->json(['message' => 'SUCCESS'], 200);
    }
}
