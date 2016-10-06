<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use DB;
use Auth;
use Hash;
use Illuminate\Http\Request;

class CustomUserModel extends Model
{


    public function getUserSettings() {
        $userData = Auth::user();
        return $userData;
    }





}