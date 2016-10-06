<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Redirect;
use App\CustomAuthModel;
use Auth;
use Illuminate\Http\Request;
use Hash;
use DB;
use App\MainModel;

class AuthController extends Controller
{



    public function sendRegistration(Request $request) {
        $type = 'user';
        $registration = CustomAuthModel::sendRegistration($request, $type);
        if($registration['result']) {
            Auth::attempt(['username' => $request->input('phone'), 'password' => $request->input('password')]);
            return Redirect::back()->with('regMessage', 'Регистрация прошла успешно');
        }
        $encodedError = MainModel::getErrorByCode($registration['errorCode']);
        return Redirect::back()->with('regMessage', $encodedError);
    }

    public function sendAuthorization(Request $request) {
        Auth::attempt(['username' => $request->input('phone'), 'password' => $request->input('password')]);
        return Redirect::back();
    }



}
