<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Auth;
use \App\Logs;

class DashboardController extends Controller
{
    public function index(Request $request)
    {
        $logs = Logs::where('created_by',Auth::id())->orderBy('id','desc')->paginate(15);

        return view('admin.dashboard.index',compact('logs'));
    }
}
