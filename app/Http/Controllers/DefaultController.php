<?php

namespace App\Http\Controllers;


use Auth;
use Illuminate\Http\Request;
use Hash;
use DB;


class DefaultController extends Controller {




    public function index() {
        return view('pages.mainPage');
    }

    public function FOFError() {
        return view('pages.404');
    }



}

?>