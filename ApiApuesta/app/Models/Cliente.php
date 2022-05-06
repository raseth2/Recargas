<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;


use Illuminate\Support\Facades\DB;

class Cliente extends Model
{
    //
    protected $table = 'clients';


    public static function SearchClient($search){        
       
        return DB::table('clients')
        ->select('clients.id','clients.name','clients.last_name','clients.player_id')      
        ->where(function ($query) use ($search) {
            $query = $query->orWhere('clients.player_id','like',"%$search%");           
        })
        ->orderBy('clients.id','DESC')
        ->limit(15)
        ->get();        
    }
}
