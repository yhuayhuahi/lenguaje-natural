<?php

namespace MyApp;

use mysqli;
use Dotenv\Dotenv;

class App {
    private $conexion;

    public function __construct() {
        $this->cargarEntorno();
        $this->conexion = $this->conectarDB();
    }

    // Cargar variables del archivo .env
    private function cargarEntorno() {
        $dotenv = Dotenv::createImmutable(__DIR__ . '/../'); 
        $dotenv -> load();
    }

    // Conectar a la base de datos
    private function conectarDB() {
        $host = $_ENV['DB_HOST'];
        $usuario = $_ENV['DB_USER'];
        $password = $_ENV['DB_PASSWORD'];
        $baseDeDatos = $_ENV['DB_NAME'];

        $conexion = new mysqli($host, $usuario, $password, $baseDeDatos);

        if ($conexion -> connect_error) {
            die("Error de conexión: " . $conexion -> connect_error);
        }

        return $conexion;
    }

    // Procesar consulta en lenguaje natural
    public function procesaConsulta($consulta, &$sql) {
        $consulta = trim(strtolower($consulta));
        $sql = '';

        // Buscar patrones en la base de datos
        $query = "SELECT consultasql FROM ln_patrones WHERE patron = ?";
        $stmt = $this->conexion -> prepare($query);
        $stmt -> bind_param("s", $consulta);
        $stmt -> execute();
        $resultado = $stmt -> get_result();

        if ($resultado -> num_rows > 0) {
            $fila = $resultado -> fetch_assoc();
            $sql = $fila['consultasql'];

            // Sustituir placeholders (%1, %2, ...) por datos de ejemplo (mock)
            $this->reemplazarPlaceholders($sql);
            return true;
        }

        return false;
    }

    // Reemplazar los placeholders con valores de ejemplo
    private function reemplazarPlaceholders(&$sql) {
        $parametros = ['tipo' => 'Piso', 'zona' => 'Nervión', 'ndormitorios' => 3];

        foreach ($parametros as $placeholder => $valor) {
            $sql = preg_replace("/%1/", $parametros['tipo'], $sql);
            $sql = preg_replace("/%2/", $parametros['zona'], $sql);
            $sql = preg_replace("/%3/", $parametros['ndormitorios'], $sql);
        }
    }

    // Ejecutar la consulta SQL y devolver los resultados
    public function ejecutarConsulta($sql) {
        $resultado = $this->conexion -> query($sql);

        if ($resultado && $resultado->num_rows > 0) {
            $viviendas = [];

            while ($fila = $resultado->fetch_assoc()) {
                $viviendas[] = $fila;
            }

            return $viviendas;
        }

        return [];
    }

    // Cerrar la conexión
    public function __destruct() {
        $this->conexion->close();
    }
}

?>
