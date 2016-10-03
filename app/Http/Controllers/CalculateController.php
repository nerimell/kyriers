<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Redirect;
use App\CustomAuthModel;
use Auth;
use Illuminate\Http\Request;
use Hash;
use DB;

class CalculateController extends Controller {


        public function calculatorPage() {
            $rates =  '';
            return view('calculations.page', compact('rates'));
        }










}