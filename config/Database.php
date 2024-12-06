<?php

/*
Mas informacion acerca de la conexion de base de datos:
https://www.w3schools.com/php/php_mysql_intro.asp 
 */

declare(strict_types=1);

include_once __DIR__ . '/env_var.php';

class DnPdatabase
{
    private $host;
    private $database;
    private $connection;

    public function __construct($host = DB_HOST, $database = DB_NAME)
    {
        $this->host = $host;
        $this->database = $database;
    }

    public function connect($username, $password): bool
    {
        try {
            $this->connection = new mysqli(
                $this->host,
                $username,
                $password,
                $this->database
            );

            if ($this->connection->connect_error) {
                return false;
            }

            // Establecer el conjunto de caracteres a utf8mb4
            $this->connection->set_charset("utf8mb4");

            return true;
        } catch (Exception $e) {
            return false;
        }
    }

    public function disconnect(): bool
    {
        if ($this->connection) {
            return $this->connection->close();
        }
        return false;
    }

    public function getConnection(): mysqli
    {
        return $this->connection;
    }
}
