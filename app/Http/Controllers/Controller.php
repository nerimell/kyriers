<?php

namespace App\Http\Controllers;

use Illuminate\Foundation\Bus\DispatchesJobs;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Auth\Access\AuthorizesResources;
use Auth;

class Controller extends BaseController
{
    use AuthorizesRequests, AuthorizesResources, DispatchesJobs, ValidatesRequests;

    public function __construct()
    {
        //$this->middleware('auth');
    }

    public static function getConfigs()
    {
        $doc = simplexml_load_file("data/config.xml");
        return $doc;
    }

    public static function setGlobalConfigs()
    {
        $SiteConfigs = Controller::getConfigs();
        \View::share(compact('SiteConfigs'));

    }
}
