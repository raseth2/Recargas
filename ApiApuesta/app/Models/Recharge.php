<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Recharge extends Model
{
    public static function ListAll(){
        
        return DB::table('recharges')
            ->join('clients', 'clients.id', '=', 'recharges.cliente_id')
            ->join('social_networks', 'social_networks.id', '=', 'recharges.social_id')
            ->join('users', 'users.id', '=', 'recharges.user_id')
            ->select('recharges.id','recharges.amount','recharges.state','recharges.photo','recharges.comment','recharges.number','clients.name','clients.last_name','recharges.bank_id','recharges.social_id','recharges.created_at','users.name as name_user')           
            ->orderBy('recharges.created_at','DESC')
            ->get();
    }

    public static function ListChargeSocial(){        
      
        return DB::table('recharges')
                ->select('social_id','social_networks.name', DB::raw('count(*) as total'),DB::raw('SUM(recharges.amount) as Suma'))
                ->join('social_networks', 'social_networks.id', '=', 'recharges.social_id')
                ->groupBy('social_id','social_networks.name')
                ->get();
   
    }
    public static function ListChargeBank(){        
      
        return DB::table('recharges')
                ->select('bank_id','banks.description', DB::raw('count(*) as total'))
                ->join('banks', 'banks.id', '=', 'recharges.bank_id')
                ->groupBy('bank_id','banks.description')
                ->get();
   
    }
    public static function ListChargeMonth(){        
      
        // return DB::table('recharges')
        //         ->select('bank_id','banks.description', DB::raw('count(*) as total'))
        //         ->join('banks', 'banks.id', '=', 'recharges.bank_id')
        //         ->groupBy('bank_id','banks.description')
        //         ->get();


        return  DB::table('recharges')->select(
                    DB::raw('sum(amount) as amount'),
                    DB::raw("DATE_FORMAT(date,'%M') as months")
                )
                    ->groupBy('months')
                    ->get();
   
    }

    

 }
