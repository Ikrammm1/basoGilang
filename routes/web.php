<?php
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;

Route::get('{any?}', function() {
    return view('application');
})->where('any', '.*');


