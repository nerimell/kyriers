<?php

namespace App\Http\Controllers\AppControllers;


use App\Http\Controllers\Controller;
use Auth;
use Illuminate\Http\Request;
use Hash;
use DB;
use App\CustomAuthModel;


class AppAuthController extends Controller
{

    public function appAuth(Request $request) {
        $phone = $request->input('phone');
        $password = $request->input('password');
        $result = ['result' => false];
        if (Auth::attempt(array('username' => $phone, 'password' => $password, 'user_group' => 2))) {
            $userData = Auth::user();
            $result['result'] = true;
            $result['userId'] = $userData->id;
            $result['city'] = $userData->city;
            $result['phone'] = $userData->username;
        }

        $response = \json_encode($result);
        return view('auth.appAuth', compact('response'));
    }

    public  function appRegistration(Request $request) {
        $type = 'courier';
        $registration = CustomAuthModel::sendRegistration($request, $type);
        return $registration;

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

    public function appLogout() {
        Auth::logout();
        return '';
    }



}
