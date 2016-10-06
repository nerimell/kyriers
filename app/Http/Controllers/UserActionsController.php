<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Redirect;
use App\CustomAuthModel;
use Auth;
use Illuminate\Http\Request;
use Hash;
use DB;
use Closure;

class UserActionsController extends Controller
{



    public function __construct() {
        parent::__construct();
        $this->middleware('auth');
    }

    public function settings() {
        return view('users.settings');
    }



}
