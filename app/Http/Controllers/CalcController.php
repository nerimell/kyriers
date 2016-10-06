<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Redirect;
use App\CustomAuthModel;
use Auth;
use Illuminate\Http\Request;
use Hash;
use DB;

class CalcController extends Controller {


        public function calculatorPage() {

            return view('calculations.page', compact('rates'));
        }










}