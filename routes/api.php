<?php
use App\Http\Controllers\API\AuthController;
use App\Http\Controllers\API\UsersController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
Route::post('login',  [AuthController::class, 'login'])->name('login');

Route::group([
  'middleware' => ['auth:sanctum']
],
  function() {
    // all resource routes
    Route::apiResources([
      'users' => UsersController::class
    ]); 
  }
);

