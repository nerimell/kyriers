<?php

namespace App\Http\Middleware;

use Closure;
use App\Http\Controllers\Controller;

class siteData
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle($request, Closure $next)
    {
        Controller::setGlobalConfigs();
        return $next($request);
    }
}
