<?php

namespace App\Http\Middleware;


use Illuminate\Foundation\Http\Middleware\VerifyCsrfToken as Middleware;
use Illuminate\Session\TokenMismatchException;
use Closure;
use Illuminate\Http\Request;

class VerifyCsrfToken extends Middleware
{
    public function handle($request, Closure $next)
    {
        try {
            return parent::handle($request, $next);
        } catch (TokenMismatchException $e) {
            return redirect()->route('login')->with('message', 'Session expired, silakan login ulang.');
        }
    }
}
