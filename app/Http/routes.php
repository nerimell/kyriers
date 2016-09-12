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

Route::post('/auth/AppAuth', 'AuthController@appAuth');
Route::get('/auth/AppAuth', 'AuthController@appAuth');
Route::get('/auth/checker', 'AuthController@appChecker');

// Users

Route::get('app/submitNewPost', 'AppControllers\PostController@submitNewPost');
Route::post('app/submitNewPost', 'AppControllers\PostController@submitNewPost');

Route::Auth();
