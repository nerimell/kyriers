<?php

namespace App\AppModels;

use Illuminate\Database\Eloquent\Model;
use DB;
use Auth;

class postModel extends Model
{

    public function postSave($request, $userData) {
        $source = $request->input('source');
        $point = $request->input('point');
        $title = $request->input('title');
        $description = $request->input('description');
        $dateToGet = $request->input('dateToGet');
        $dateToDeliver = $request->input('dateToDeliver');
        $userId = $userData->id;
        $newPost = DB::table('posts')->insertGetId(
                ['source' => $source,
                 'point' => $point,
                 'title' => $title,
                 'description' => $description,
                 'user_id' => $userId,
                 'date_to_get' => $dateToGet,
                 'date_to_deliver' => $dateToDeliver
                 ]);
        $result = [];
        $result['result'] = false;
        $result['display'] = 'Не удалось сохранить ваше объявление';
        if($newPost) {
            $result['display'] = 'Ваше объявление успешно сохранено';
            $result['postId'] = $newPost;
            $result['result'] = true;
        }
        return $result;
    }


}
