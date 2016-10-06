<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use DB;
use Auth;
use Hash;
use Illuminate\Http\Request;

class CustomAuthModel extends Model
{



        public static function validateRegistration($params) {
            $result = ['result' => false, 'errorCode' => false];
            if (!$params['phone'] || !is_numeric($params['phone'])) {
                $result['errorCode'] = 1002;
                return $result;
            }
            if (!$params['email']) {
                $result['errorCode'] = 1003;
                return $result;
            }
            if (!$params['password_one']) {
                $result['errorCode'] = 1004;
                return $result;
            }
            if (!$params['password_two']) {
                $result['errorCode'] = 1005;
                return $result;
            }
            if (!$params['city']) {
                $result['errorCode'] = 1006;
                return $result;
            }
            if(strlen($params['city']) < 3) {
                $result['errorCode'] = 1011;
                return $result;
            }
            if ($params['password_one'] != $params['password_two']) {
                $result['errorCode'] = 1007;
                return $result;
            }
            if(strlen($params['password_one']) < 5) {
                $result['errorCode'] = 1010;
                return $result;
            }
            if (!$params['name'] || strlen($params['name']) < 2) {
                $result['errorCode'] = 1008;
                return $result;
            }
            $result['result'] = true;

            return $result;
        }


        public static function sendRegistration(Request $request, $type) {


            $result = ['result' => false, 'errorCode' => false];
            $params = [];
            $params['phone'] = $request->input('phone');
            $params['email'] = $request->input('email');
            $params['name'] = $request->input('name');
            $params['password_one'] = $request->input('password_one');
            $params['password_two'] = $request->input('password_two');
            $params['city'] = $request->input('city');
            $validate = CustomAuthModel::validateRegistration($params);
            if($validate['result'] == false) {
                return $validate;
            }
            if($type == 'courier') {
                $params['user_group'] = 2;
            } else {
                $params['user_group'] = 1;
            }
            $userParams = [
                'username' => $params['phone'],
                'name' => $params['name'],
                'password' => Hash::make($params['password_one']),
                'email' => $params['email'],
                'city' => $params['city'],
                'user_group' => $params['user_group']
            ];
            $user = false;
            try {
                $user = User::create($userParams);
            } catch(\Exception $e) {
                $result['errorCode'] = 'Пользователь с таким номером телефона уже существует';
                return $result;
            }
            $result['debug'] = $user;
            if($user) {
                $result['result'] = true;

                return \json_encode($result);
            }

            $result['errorCode'] = 1009;
            return \json_encode($result);

        }




}