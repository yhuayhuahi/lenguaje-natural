<?php

require __DIR__. '/../vendor/autoload.php';
require __DIR__. '/../src/ln.php';

use MyApp\App;

// CORS
Flight::before('start', function(&$params, &$output) {
    header('Access-Control-Allow-Origin: *');
    header('Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS');
    header('Access-Control-Allow-Headers: Content-Type, Authorization');
});

// Manejar solicitudes OPTIONS
Flight::route('OPTIONS /*', function() {
    Flight::halt(200, 'OK');
});

$router = Flight::router();

// solicitud GET
$router->post('/consulta', function() {
    $my_request = Flight::request();

    $consulta = $my_request -> data['consulta'];

    if (empty(trim($consulta))) {
        Flight::json(['error' => 'Debe introducir una consulta'], 400);
        return;
    }

    $app = new App();
    $sql = '';
    $respuesta = [];
    $status = 200;

    if ($app -> procesaConsulta($consulta, $sql)) {
        $resultados = $app -> ejecutarConsulta($sql);

        if (!empty($resultados)) {
            $respuesta = $resultados;
        } else {
            $respuesta = ['mensaje' => 'No hay viviendas disponibles.'];
            $status = 404;
        }
    } else {
        $respuesta = ['error' => 'La consulta no es correcta.'];
        $status = 400;
    }

    Flight::json($respuesta, $status);
});

Flight::start();
// $router->post();
// $router->put();
// $router->delete();
// $router->patch();

#$app = new App();
#$app->run();

?>