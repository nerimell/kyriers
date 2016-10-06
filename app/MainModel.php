<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use DB;
use Auth;

class MainModel extends Model
{

    public static function getCities() {
        $cities = DB::table('cities')->get();
        return $cities;
    }

    public static function getErrorByCode($code) {
        $lines = file('data/errorCodes.txt');
        $errorText = 'Неизвестная ошибка';
        foreach($lines as $line) {
            if(substr($line, 0, 4) != $code) {
                continue;
            }
            $errorText = substr($line, 6);
            break;
        }
        return $errorText;
    }





}
