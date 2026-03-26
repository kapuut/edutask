<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class AdminAuthMiddleware
{
    public function handle(Request $request, Closure $next)
    {
        if (!session()->has('admin_id')) {
            return response()->json(['message' => 'Unauthorized. Please login first.'], 401);
        }

        return $next($request);
    }
}
