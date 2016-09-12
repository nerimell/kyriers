<?php

namespace App\Http\Controllers;


use Illuminate\Routing\Controller as BaseController;
use Auth;
use Illuminate\Http\Request;
use Hash;
use DB;

class AuthController extends Controller
{

    public function appAuth(Request $request) {
        $login = $request->input('username');
        $password = $request->input('password');
        $result = ['result' => false];
        if (Auth::attempt(array('username' => $login, 'password' => $password))) {
        $userData = Auth::user();
            $result['result'] = true;
            $result['userId'] = $userData->id;
            $result['userName'] = $userData->username;
        }

        $response = \json_encode($result);
        return view('auth.appAuth', compact('response'));
    }


    function appChecker() {
        $userData = Auth::user();
        if($userData) {
            return $userData->id;
        } else {
            return 'false';
        }
    }

    public function appAuthGet()
    {
        return view('pages.404', compact('response'));
    }



}
