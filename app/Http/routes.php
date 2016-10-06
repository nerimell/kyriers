<?php

/*
|--------------------------------------------------------------------------
| Application Routes
|--------------------------------------------------------------------------
|
| Here is where you can register all of the routes for an application.
| It's a breeze. Simply tell Laravel the URIs it should respond to
| and give it the controller to call when that URI is requested.
|
*/


// Main
Route::get('/', 'DefaultController@index');
Route::get('/calculate', 'CalcController@calculatorPage');












Route::get('/my/settings', 'UserActionsController@settings');





// Auth
Route::Auth();
// AppAuth
Route::post('/auth/AppAuth', 'AppControllers\AppAuthController@appAuth');
Route::get('/auth/checker', 'AppControllers\AppAuthController@appChecker');
Route::post('/auth/appRegistration', 'AppControllers\AppAuthController@appRegistration');
Route::get('/auth/appLogout', 'AppControllers\AppAuthController@appLogout');
// WebAuth
Route::post('/auth/sendRegistration', 'AuthController@sendRegistration');
Route::post('/auth/sendAuthorization', 'AuthController@sendAuthorization');










// Admin
Route::get('/control-panel', 'AdminController@dashboard');

Route::get('/control-panel/globalConfigs', 'AdminController@globalConfigs');
Route::post('/control-panel/globalConfigs', 'AdminController@globalConfigsSave');

Route::get('/control-panel/sliderConfigs', 'AdminController@sliderConfigs');
Route::get('/control-panel/analytics', 'AdminController@dashboard');











Route::get('/404', 'DefaultController@FOFError');