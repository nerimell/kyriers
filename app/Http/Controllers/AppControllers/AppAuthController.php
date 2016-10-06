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
        $phone = CustomAuthModel::reformatPhone($request->input('phone'));
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



    public function appRegPin(Request $request) {
        $phone = CustomAuthModel::reformatPhone($request->input('phone'));
        $password = $request->input('password');
        $result = ['result' => false, 'errorCode' => false];
        $params = [
            'pin_code_one' => $request->input('pin_code_one'),
            'pin_code_two' => $request->input('pin_code_two')
        ];
        $pin_code = CustomAuthModel::validatePin($params);
        if(!$pin_code['result']) {
            $result['errorCode'] = $pin_code['errorCode'];
            return $result;
        }
        $user = DB::table('users')
            ->where('username', $phone)
            ->first();
        if(!$user) {
            $result['errorCode'] = 1021;
            return \json_encode($result);
        }
        $check = Hash::check($password, $user->password);
        if(!$check) {
            $result['errorCode'] = 1022;
            return \json_encode($result);
        }

        try {
        DB::table('users')
            ->where('username', $phone)
            ->update(['pin_code' => $pin_code['pin_code']]);
        } catch(\Exception $e) {
            $result['errorCode'] = 1019;
            return $result;
        }
        $result['result'] = true;
        unset($result['errorCode']);
        $result['pin_code'] = $pin_code['pin_code'];
        return \json_encode($result);

    }

    public function appGetPin(Request $request) {
        $result = ['result' => false, 'errorCode' => false];
        $phone = CustomAuthModel::reformatPhone($request->input('phone'));
        $password = $request->input('password');

        $user = DB::table('users')
                    ->where('username', $phone)
                    ->first();
        if(!$user) {
            $result['errorCode'] = 1021;
            return \json_encode($result);
        }
        $check = Hash::check($password, $user->password);
        if(!$check) {
            $result['errorCode'] = 'Неправильный логин или пароль';
            return \json_encode($result);
        }

        $result['pin_code'] = $user->pin_code;
        $result['errorCode'] = false;
        return \json_encode($result);

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
