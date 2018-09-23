<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/


// Frontend routes
Route::get('/', 'FrontendController@index')->name('index');

// Middleware routes
Auth::routes();

// Link sidebar
View::share('sidebar', [
    'home' => ['name' => 'Dashboard', 'icon' => 'dashboard'],
    //'admin.codecommit' => ['name' => 'Codecommit', 'icon' => 'th-large'],
    //'admin.settings' => ['name' => 'Settings', 'icon' => 'cog'],

]);

// Backend routes
Route::get('/home', 'HomeController@index')->name('home');
