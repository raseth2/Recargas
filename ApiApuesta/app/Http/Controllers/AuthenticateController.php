<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use Illuminate\Support\Facades\Hash;

use App\Models\TipeUser;

class AuthenticateController extends Controller
{
    //
    public function Login(Request $request)
    {
        if ($request->isJson()) {

            try {
                $user = User::where('email', $request->email)->first();                
             
                if ($user && Hash::check($request->password, $user->password)) {                    
                    $type_user= TipeUser::where('id', $user->type_user_id)->first(); 
                    return response()->json(['status' => 200, 'result' => ['user' => $user],'type_user'=>$type_user]);
                } else {
                    return response()->json(['status' => 404, 'result' => 'datos incorrectos']);
                }
            } catch (\Exception $e) {
                return response()->json(['status' => 404, 'result' => 'error'.$e]);
            }
        }

        return response()->json(['status' => 405, 'error' => 'unauthtorized']);
    }
}
