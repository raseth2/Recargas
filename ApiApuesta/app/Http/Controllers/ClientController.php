<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cliente;
use App\Models\NumberClient;
use Illuminate\Support\Facades\Hash;
use App\Models\Wallet;
use App\Models\HistoryWallet;



class ClientController extends Controller
{
   
    public function SearchClient($search)
    {        
        $obj = Cliente::SearchClient($search);
        $providers = array();
        foreach ($obj as $be) {
            array_push($providers,
                array(
                    'id' => $be->id,
                    'name' => $be->name.' - '.$be->last_name,
                    'player_id' => $be->player_id,
                )
            );
        }
        return response()->json(['status' => 200,'result' => $providers]);      
    }


    public function SearchNumber($cliente_id)
    {        
      
        $obj= NumberClient::where('cliente_id',$cliente_id)->where('state','default')->first(); 
      
        return response()->json(['status' => 200,'result' => $obj]);      
    }

    public function records()
    {        
        $records = Cliente::select('id', 'email', 'name' ,'last_name' ,'player_id')->get();
        //$obj= Cliente::all(); 
      
        return response()->json(['status' => 200,'result' => $records]);      
    }

    public function Login(Request $request)
    {
        if ($request->isJson()) {

            try {
                $user = Cliente::where('email', $request->email)->first();                
             
                if ($user && Hash::check($request->password, $user->password)) {                    
                 
                    return response()->json(['status' => 200, 'result' => ['user' => $user]]);
                } else {
                    return response()->json(['status' => 404, 'result' => 'datos incorrectos']);
                }
            } catch (\Exception $e) {
                return response()->json(['status' => 404, 'result' => 'error'.$e]);
            }
        }

        return response()->json(['status' => 405, 'error' => 'unauthtorized']);
    }


    public function table($cliente_id)
    {        
      
        $wallet= Wallet::where('cliente_id',$cliente_id)->first(); 
        $hisotorywallet= HistoryWallet::where('cliente_id',$cliente_id)->orderBy('created_at','DESC')->get(); 
        return response()->json(['status' => 200,'wallet' => $wallet,'hisotorywallet' => $hisotorywallet]);      
    }


    public function Info($cliente_id)
    {        
      
        $wallet= Wallet::where('cliente_id',$cliente_id)->first(); 
        $numberClient= NumberClient::where('cliente_id',$cliente_id)->get(); 
        return response()->json(['status' => 200,'wallet' => $wallet,'numberClient' => $numberClient]);      
    }



}
