<?php

namespace App\Http\Controllers;

use App\Http\Resources\SectionResource;
use App\Traits\SectionContentTrait;

use App\Section;

use Illuminate\Http\Request;

class SectionController extends Controller
{
    use SectionContentTrait;
    /**
     * store the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'title' => 'required',
            'nb_labels' => 'required',
            'content_type' => 'required',
            'content' => 'required|min:3',
            'page_id' => 'required'
        ]);
        Section::create(
            [
                'title' => $request->title,
                'endpoint' => $request->endpoint,
                'page_id' => $request->page_id,
                'nb_labels' => $request->nb_labels,
                'content' => $request->content,
                'content_type' => $request->content_type,
            ]
        );
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Update the specified resource.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Section  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'title' => 'required',
            'nb_labels' => 'required',
            'content_type' => 'required',
            'content' => 'required|min:3',
            'page_id' => 'required'
        ]);
        $section = Section::find($id);
        $section->title =  $request->title;
        $section->endpoint =  $request->endpoint;
        $section->nb_labels =  $request->nb_labels;
        $section->page_id =  $request->page_id;
        $section->content =  $request->content;
        $section->content_type =  $request->content_type;
        $section->save();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
    /**
     * Get the most liked songs.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function MostLikedSongs($nb_rows)
    {
        return $this->sectionMostLikedSongs($nb_rows);
    }
    /**
     * Get the new released songs.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function NewReleases($nb_rows)
    {
        return  $this->sectionNewReleases($nb_rows);
    }
    /**
     * Get the most popular songs ( most played ).
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function PopularSongs($nb_rows)
    {
        return $this->sectionPopularSongs($nb_rows);
    }
    /**
     * Get the most popular albums ( most played ).
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function PopularAlbums($nb_rows)
    {
        return $this->sectionPopularAlbums($nb_rows);
    }
    /**
     * Get the latest released albums.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function LatestAlbums($nb_rows)
    {
        return $this->sectionLatestAlbums($nb_rows);
    }
    /**
     * Get the latest released podcasts.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function LatestPodcasts($nb_rows)
    {
        return $this->sectionLatestPodcasts($nb_rows);
    }
    /**
     * Get the most popular podcasts.
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function PopularPodcasts($nb_rows)
    {
        return $this->sectionPopularPodcasts($nb_rows);
    }
    /**
     * Get the charts page data ( the populars, most liked, latest...etc ).
     *
     * @param int $nb_rows
     * @return \Illuminate\Database\Eloquent\Collection
     */
    public function charts()
    {
        return SectionResource::collection(\App\Page::where('id', 1)->first()->sections);
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Section  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        Section::find($id)->delete();
        return response()->json(['message' => 'SUCCESS'], 200);
    }
}
