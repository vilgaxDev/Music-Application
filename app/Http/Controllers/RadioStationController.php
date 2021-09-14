<?php

namespace App\Http\Controllers;

use App\Helpers\FileManager;
use App\Http\Resources\RadioStationResource;
use App\RadioStation;
use Illuminate\Http\Request;

class RadioStationController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        return RadioStationResource::collection(RadioStation::all());
    }
    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|min:1|string',
            'endpoint' => 'required'
        ]);

        $cover = FileManager::store($request, '/covers/radio-stations/', 'cover');

        RadioStation::create([
            'name' => $request->name,
            'cover' => $cover,
            'endpoint' => $request->endpoint,
            'highlight' => $request->highlight,
            'metadata_types' => $request->metadata_types,
            'retry_timeout' => $request->retry_timeout,
            'icy_detection_timeout' => $request->icy_detection_timeout,
        ]);

        return response()->json(['message' => 'SUCCESS'], 200);
    }

    /**
     * Retrieve the highlighted streams
     */
    public function highlights()
    {
        return RadioStationResource::collection(RadioStation::where('highlight', 1)->get());
    }
    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\RadioStation  $radioStation
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|min:1|string',
            'endpoint' => 'required'
        ]);

        $radioStation = RadioStation::find($id);


        if (isset($request->cover) && $request->file('cover')) {
            $radioStation->cover = FileManager::update($request->file('cover'), $radioStation->cover, '/covers/radio-stations/');
        }

        $radioStation->name = $request->name;
        $radioStation->endpoint =  $request->endpoint;
        $radioStation->highlight =  $request->highlight;
        $radioStation->metadata_types =  $request->metadata_types;
        $radioStation->retry_timeout =  $request->retry_timeout;
        $radioStation->icy_detection_timeout =  intval($request->icy_detection_timeout);

        $radioStation->save();
        return response()->json(['message' => 'SUCCESS'], 200);
    }

    public function matchRadioStations($keyword)
    {
        return RadioStationResource::collection(RadioStation::where('name', 'like', '%' . $keyword . '%')->get());
    }
    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\RadioStation  $radioStation
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $radioStation = RadioStation::find($id);
        $radioStation->delete();

        return response()->json(['message' => 'SUCCESS'], 200);
    }
}
