<?php

namespace App\Helpers;

use App\Exceptions\FEException;
use App\File;
use Illuminate\Support\Facades\Storage;
use App\Setting;
use Exception;

class FileManager
{
    /**
     * generates the URL for the front-end to fetch the file (asset).
     * Assets are stored on the database under a single column for optimization reasons.
     * This column content is a string and it has the following format:
     * <Disk in which the asset is stored>/<asset path>/<asset file name (sluged)>
     */
    static function asset_path($source)
    {
        if ($source) {
            $decoded_source = json_decode($source);
            if ($url = $decoded_source->url) {
                // if $url then the file is stored on the cloud 
                return $url;
            } else {
                // else it is on the local storage ( generating the URL dynamically in this case so if the
                // the admin changes his Domain or base URL the assets will still work)
                $replace = preg_replace('/.*\/storage/', '', $decoded_source->path);
                $url = asset('/storage' . $replace);
                return $url;
            }
        }
    }
    /**
     *  general s3 storage link for the file.
     */
    static function s3_url($disk_driver, $final_path)
    {
        $disk = config('filesystems.disks.' . $disk_driver);
        // bucket.s3.region.backblazeb2.com
        // s3.us-west-000.backblazeb2.com
        // bucket.s3.region.wasabisys.com
        // muzzie.s3.region.amazonaws.com
        // muzzie.s3.region.provider.com
        if ($disk['driver'] === 's3') {
            $url = self::withoutHttp(self::pushBucketAndRegionInEndpoint($disk['endpoint'], $disk['bucket'], $disk['region']));
            return 'https://' . $url . $final_path;
        } else if ($disk['driver'] === 'b2') {
            return 'https://' . self::withoutHttp($disk['bucketName']) . '.' . self::withoutHttp($disk['endpoint']) . $final_path;
        }
    }
    static function pushBucketAndRegionInEndpoint($endpoint, $bucket, $region)
    {
        return preg_replace('/s3\./', $bucket . '.s3.' . $region  . '.', $endpoint);
    }
    static function withoutHttp($endpoint)
    {
        return preg_replace('/http:\/\/|https:\/\//', '', $endpoint);
    }

    // checks if the file can be deleted through his composed path
    static function isDeletable($file_path)
    {
        if ($file_path) {
            if (str_starts_with($file_path, '/storage/defaults')) {
                return false;
            }
            return true;
        }
        return false;
    }

    // upload file
    static function upload($file, $path, $file_name_slug, $disk_name)
    {
        $final_path = $path . $file_name_slug;
        try {
            Storage::disk($disk_name)->put($final_path, file_get_contents($file));
        } catch (Exception $exception) {
            throw new FEException('Some server error occurred. Please try again.', $exception->getMessage(), 500);
        }
        $url = null;
        if ($disk_name !== 'public') {
            // cloud file
            $url = self::s3_url(
                $disk_name,
                $final_path
            );
        }
        return self::generateFileData($final_path, $disk_name, $url);
    }

    // update the file  
    static function update($new_file, $old_file, $path)
    {
        $disk_name = json_decode(Setting::get('storageDisk'))->disk;
        $file_name_slug = self::generateFileName($new_file);
        try {
            self::delete($old_file);
        } catch (Exception $exception) {
        }
        return Self::upload($new_file, $path, $file_name_slug, $disk_name);
    }

    // store file on the corresponding storage disk
    static function store($request,  $path, $file_type)
    {
        $disk_name = json_decode(Setting::get('storageDisk'))->disk;
        if ($request->file($file_type)) {
            $file_name_slug = self::generateFileName($request->file($file_type));
            return Self::upload($request->file($file_type), $path, $file_name_slug, $disk_name);
        } else {
            // local default file no need to upload to disk
            $url = self::isUrl($request[$file_type]) ? $request[$file_type] : null;
            $disk = !self::isUrl($request[$file_type]) ? 'public' : null;
            return self::generateFileData($request[$file_type], $disk, $url);
        }
    }
    static function isUrl($string)
    {
        return preg_match('/http/', $string);
    }
    // delete file
    static function delete($file_data)
    {
        $fd = json_decode($file_data);
        if (self::isDeletable($fd->path)) {
            try {
                Storage::disk($fd->disk)->delete($fd->path);
            } catch (\Exception $exception) {
                throw new FEException(__('Failed to delete the file'), $exception->getMessage(), 500);
            }
        }
    }

    // downlaod file
    static public function download($song)
    {
        $fd = json_decode($song->source);
        return Storage::disk($fd->disk)->download($fd->path, $song->file_name);
    }

    // generate a sluged file name
    static function generateFileName($file)
    {
        $file_name = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        return \Str::slug(rand() . $file_name) .  '.' .  $file->getClientOriginalExtension();
    }
    static function generateFileData($path, $disk_name = null, $url = null)
    {
        // takes the disk driver as parameter
        $disk_name =  $disk_name ? $disk_name : json_decode(Setting::get('storageDisk'))->disk;

        return json_encode([
            'path' => $path,
            'disk' => $disk_name,
            'url' => $url
        ]);
    }
}
