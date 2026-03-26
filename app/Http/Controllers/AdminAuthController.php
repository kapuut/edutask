<?php

namespace App\Http\Controllers;

use App\Models\Admin;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class AdminAuthController extends Controller
{
    public function showLogin()
    {
        return response()->json([
            'message' => 'Please login with username and password.',
            'endpoint' => '/login',
        ]);
    }

    public function login(Request $request)
    {
        $validated = $request->validate([
            'username' => ['required', 'string'],
            'password' => ['required', 'string'],
        ]);

        $admin = Admin::query()->where('username', $validated['username'])->first();

        if (!$admin || !Hash::check($validated['password'], $admin->password)) {
            return response()->json(['message' => 'Invalid credentials'], 422);
        }

        session([
            'admin_id' => $admin->id,
            'admin_username' => $admin->username,
        ]);

        return response()->json([
            'message' => 'Login successful',
            'admin' => ['id' => $admin->id, 'username' => $admin->username],
        ]);
    }

    public function dashboard()
    {
        return response()->json([
            'message' => 'Welcome to EduTrack admin dashboard',
            'admin' => [
                'id' => session('admin_id'),
                'username' => session('admin_username'),
            ],
        ]);
    }

    public function logout(Request $request)
    {
        $request->session()->forget(['admin_id', 'admin_username']);

        return response()->json(['message' => 'Logout successful']);
    }
}
