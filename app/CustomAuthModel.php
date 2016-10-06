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
            if (!$params['city']) {
                $result['errorCode'] = 1006;
                return $result;
            }
            if(strlen($params['city']) < 2) {
                $result['errorCode'] = 1011;
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
            $params['phone'] = CustomAuthModel::reformatPhone($request->input('phone'));
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
                'user_group' => $params['user_group'],
            ];
            $user = false;
            try {
                $user = User::create($userParams);
            } catch(\Exception $e) {
                $result['errorCode'] = 1012;
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



        public static function validatePin($params) {
            $result = ['result' => false, 'errorCode' => false];
            if (!$params['pin_code_one']) {
                $result['errorCode'] = 1016;
                return $result;
            }
            if (!$params['pin_code_two']) {
                $result['errorCode'] = 1016;
                return $result;
            }
            if (strlen($params['pin_code_one']) != 4) {
                $result['errorCode'] = 1017;
                return $result;
            }
            if (strlen($params['pin_code_two']) != 4) {
                $result['errorCode'] = 1017;
                return $result;
            }
            if($params['pin_code_one'] != $params['pin_code_two']) {
                $result['errorCode'] = 1018;
                return $result;
            }
            $result['pin_code'] = $params['pin_code_one'];
            $result['result'] = true;
            return $result;
        }


        public static function reformatPhone($phone) {
            if(!$phone) {
                return false;
            }
            if(substr($phone, 0, 2) == '+7') {
                $phone = 7 . substr($phone, 2);
                return $phone;
            }
            if(substr($phone, 0, 1) == 8) {
                $phone = 7 . substr($phone, 1);
                return $phone;
            }
            return $phone;
        }




}