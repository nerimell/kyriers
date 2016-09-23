<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Redirect;
use App\CustomAuthModel;
use Auth;
use Illuminate\Http\Request;
use Hash;
use DB;

class AdminController extends Controller
{



    public function __construct() {
        parent::__construct();
        $this->middleware('auth');
        $this->middleware('group.perm:23');
    }

    public function dashboard() {
        $component = 'dashboard';
        $componentTitle = 'Аналитика';
        $componentDesc = 'инструмент просмотра статистики приложения';
        return view('admin.pages.dashboard', compact('component', 'componentTitle', 'componentDesc'));
    }

    public function globalConfigs() {
        $component = 'configs';
        $componentTitle = 'Настройки';
        $componentDesc = 'конфигурация сайта';
        $CurMenu = 'global';
        return view('admin.configs.global', compact('component', 'componentTitle', 'componentDesc', 'CurMenu'));
    }

    public function globalConfigsSave(Request $request) {
        $configs = Controller::getConfigs();

            $configs->SiteMeta->metaTitle = $request->input('metaTitle');
            $configs->SiteMeta->metaKeys = $request->input('metaKeys');

            $configs->SiteMeta->metaDesc = $request->input('metaDesc');
            $configs->SmsConfigs->smsRuId = $request->input('smsRuId');

        $configs->asXml('data/config.xml');
        Controller::setGlobalConfigs();
        return $this->globalConfigs();
    }

    public function sliderConfigs() {
        $component = 'configs';
        $componentTitle = 'Настройки';
        $componentDesc = 'конфигурация сайта';
        $CurMenu = 'slider';
        return view('admin.configs.slider', compact('component', 'componentTitle', 'componentDesc', 'CurMenu'));
    }



}
