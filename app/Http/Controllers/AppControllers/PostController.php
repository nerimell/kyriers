<?php

namespace App\Http\Controllers\AppControllers;


use Auth;
use Illuminate\Http\Request;
use Hash;
use DB;
use App\AppModels\postModel;
use App\Http\Controllers\Controller;

class PostController extends Controller
{

    public function submitNewPost(Request $request) {
       $userData = Auth::user();
       if(!$userData) {
        $result = [
            'result' => false,
            'code' => 1001,
        ];
        return \json_encode($result);
       }
       $model = new postModel;
       $result = $model->postSave($request);
       return json_encode($result);
    }

    public function getPosts(Request $request) {
        $userData = Auth::user();
        if (!$userData) {
            $result = [
                'result' => false,
                'code' => 1001,
            ];
            return \json_encode($result);
        }
       $model = new postModel;

       $result = $model->getPosts();

    }


}
