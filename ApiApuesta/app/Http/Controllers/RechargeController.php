<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\SocialNetwork;
use App\Models\Bank;
use App\Models\Recharge;
use Illuminate\Support\Str;
use App\Models\NumberClient;
use App\Models\HistoryWallet;
use App\Models\Wallet;




class RechargeController extends Controller
{
    //
    public function tables()
    {
        $banks = Bank::all();  
        $socialNetwork = SocialNetwork::all();         
        
        return response()->json(['status' => 200,'socialNetwork' => $socialNetwork,'banks' => $banks]);
    }
    public function ListAll()
    {
        $result = Recharge::ListAll();          
        return response()->json(['status' => 200,'result' => $result]);
    }
    public function ListChargeSocial()
    {
        $result = Recharge::ListChargeSocial();          
        return response()->json(['status' => 200,'result' => $result]);
    }
    public function ListChargeBank()
    {
        $result = Recharge::ListChargeBank();          
        return response()->json(['status' => 200,'result' => $result]);
    }
    public function ListChargeMonth()
    {
        $result = Recharge::ListChargeMonth();          
        return response()->json(['status' => 200,'result' => $result]);
    }

    public function store(Request $request)
    {
        try
        {     
            $name_file = "uploads/Cpu/img-default.jpg";       
            $number=  Str::random(5);
            if ($request->hasFile('photo')){
                $name_file = $this->Upload($request->file('photo'),$number."-".time(),'uploads/vouchers/');          
            }
            $obj = new Recharge();
            $obj->cliente_id = $request->cliente_id;
            $obj->amount = $request->amount;   
            $obj->state = 0;     
            $obj->date = $request->date;  
            $obj->photo = $name_file;          
            $obj->number = $request->number; 
            $obj->bank_id = $request->bank_id;   
            $obj->user_id = $request->user_id;
            $obj->social_id = $request->social_id;     
            $obj->save();  

            $clien= NumberClient::where('cliente_id',$request->cliente_id)->where('number',$request->number)->get(); 
            $count=$clien->count();
            if ($count==0) {         
                NumberClient::where('cliente_id', $request->cliente_id)->update(['state' => null]);
                $number = new NumberClient();
                $number->cliente_id = $request->cliente_id;
                $number->number = $request->number;      
                $number->state = "default";      
                $number->save();   
            }

            // $wallets=Wallet::where('cliente_id',$request->cliente_id)->get();
            // $countwo=$wallets->count();
            // if ($countwo==0) {

            //     $wallet=new Wallet();
            //     $wallet->total=$request->amount;
            //     $wallet->type_currency="S/";
            //     $wallet->last_recharge=$request->date;
            //     $wallet->cliente_id=$request->cliente_id;
            //     $wallet->state = "0";   
            //     $wallet->save();
            // }
            // else{
            //     $wallet = Wallet::where('cliente_id', '=', $request->cliente_id)->firstOrFail();  
            //     $wallet->total =  $wallet->total+$request->amount;   
            //     $wallet->state = "0";              
            //     $wallet->update();
            // }
                       
            // $histo = new HistoryWallet();
            // $histo->amount = $request->amount;  
            // $histo->fecha =$request->date;  
            // $histo->state ="0";      
            // $histo->cliente_id = $request->cliente_id;
            // $histo->recharge_id=$obj->id;
            // $histo->save();   
        
            return response()->json(['status' => 200,'result' => $obj]);
        } catch (\Exception $e){   
            return response()->json(['status' => 404,'message'=>$e->getMessage()]);
        } 
    }


    public function prueba(Request $request)
    {
        $clien= NumberClient::where('cliente_id',$request->id)->where('number',$request->number)->get(); 
        $count=$clien->count();
        if ($count==0) {
         
            NumberClient::where('cliente_id', $request->id)->update(['state' => null]);
            $obj = new NumberClient();
            $obj->cliente_id = $request->id;
            $obj->number = $request->number;      
            $obj->state = "default";      
            $obj->save();   

        }
        else{

        }
        return response()->json(['status' => 200,'result' => $clien,'count' => $count]);
    }


     public function Update(Request $request)
    {

      if($request->isJson()){
        $this->validate($request, [
            'id' => 'required',
            'amount' => 'required'      
        ]);    
        try
        {      
            $obj = Recharge::find($request->id);            
            $obj->amount = $request->amount;   
            $obj->state = 0;  
            $obj->number = $request->number; 
            $obj->bank_id = $request->bank_id;   
            $obj->social_id = $request->social_id;   
            $obj->update();

            return response()->json(['status' => 200,'result' => $obj]);
          
        } catch (\Exception $e){   
            
            return response()->json(['status' => 404,'message'=>$e->getMessage()]);
        } 
      } 
      return response()->json(['status' => 404]);

    }

    public function Updatetwo(Request $request)
    {

      if($request->isJson()){

        $this->validate($request, [
            'id' => 'required',
            'amount' => 'required'      
        ]);
    
        try
        {       
            $obj = Recharge::find($request->id);  
            $obj->state = $request->state;        
            $obj->comment = $request->comment;   
            $obj->update();
            if ($request->state=="1") {

                $wallets=Wallet::where('cliente_id',$obj->cliente_id)->get();
                $countwo=$wallets->count();
                if ($countwo==0) {

                    $wallet=new Wallet();
                    $wallet->total=$obj->amount;
                    $wallet->type_currency="S/";
                    $wallet->last_recharge=$obj->date;
                    $wallet->cliente_id=$obj->cliente_id;
                    $wallet->state = "1";   
                    $wallet->save();
                }
                else{
                    $wallet = Wallet::where('cliente_id', '=', $obj->cliente_id)->firstOrFail();  
                    $wallet->total =  $wallet->total+$obj->amount;   
                    $wallet->state = "1";              
                    $wallet->update();
                }
                        
                $histo = new HistoryWallet();
                $histo->amount = $obj->amount;  
                $histo->fecha =$obj->date;  
                $histo->state ="1";      
                $histo->cliente_id = $obj->cliente_id;
                $histo->recharge_id=$request->id;
                $histo->save();  

            }
            return response()->json(['status' => 200,'result' => $obj]);
          
        } catch (\Exception $e){   
            
            return response()->json(['status' => 404,'message'=>$e->getMessage()]);
        } 
      } 
      return response()->json(['status' => 404]);

    }

    public function Upload($file,$name,$path)
    {
        $extension = $file->getClientOriginalExtension();
        $filenamestore = $name."-".time().".".$extension;
        $file->move($path, $filenamestore);
        return $path.$filenamestore;
    }
}
