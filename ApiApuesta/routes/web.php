<?php

/** @var \Laravel\Lumen\Routing\Router $router */

$router->get('/', function () use ($router) {
    return $router->app->version();
});


//clients
$router->get('/search-clients/{search}', 'ClientController@SearchClient');
$router->get('/number/default/{cliente_id}', 'ClientController@SearchNumber');
$router->get('/clients/records', 'ClientController@records');
$router->post('/loginclient', 'ClientController@Login');
$router->get('/client/info/{cliente_id}', 'ClientController@Info');
//tables
$router->get('/recharge/tables', 'RechargeController@tables');
$router->post('/recharge', 'RechargeController@store');
$router->get('/recharge', 'RechargeController@ListAll');
$router->put('/recharge', 'RechargeController@Update');
$router->put('/recharge/apro', 'RechargeController@Updatetwo');
$router->get('/recharge/social', 'RechargeController@ListChargeSocial');
$router->get('/recharge/bank', 'RechargeController@ListChargeBank');
$router->get('/recharge/month', 'RechargeController@ListChargeMonth');



$router->post('/prueba', 'RechargeController@prueba');




$router->post('/loginuser', 'AuthenticateController@Login');


$router->get('/table/{cliente_id}', 'ClientController@table');
