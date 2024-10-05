<?php 
namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class CheckSession
{
    public function handle($request, Closure $next)
    {
        if (Auth::check() && Auth::user()->sessionExpired()) {
            Auth::logout();
            return redirect('/')->withErrors('Your session has expired. Please log in again.');
        }

        return $next($request);
    }
}


?>