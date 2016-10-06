<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class CustomAuthMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @param  string|null  $guard
     * @return mixed
     */
    public function handle($request, Closure $next, $group)
    {
        // Check User Group Permissions
        if( $request->user()->user_group == $group ){
            // Continue the request
            return $next($request);
        }

        // Redirect
        return redirect('404');
    }
}
