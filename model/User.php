<?php

declare(strict_types=1);

require_once '../config/Database.php';

class User
{
    private $username;
    private $password;
    private $database;

    public function __construct(string $username, string $password)
    {
        $this->username = $username;
        $this->password = $password;
        $this->database = new DnPdatabase();
    }


    public function createUser(
        string $userId,
        string $name,
        string $email,
        string $userPassword,
        string $address,
        string $phone,
        int $userType
    ): bool {
        try {
            // Verificar la conexión
            if (!$this->database->connect($this->username, $this->password)) {
                return false;
            }

            // Obtener la conexión
            $connection = $this->database->getConnection();
            // Preparar la consulta
            $stmt = $connection->prepare("CALL sp_test_user_create(?, ?, ?, ?, ?, ?, ?)");
            $stmt->bind_param("ssssssi", $userId, $name, $email, $userPassword, $address, $phone, $userType);

            // Ejecutar la consulta
            $result = $stmt->execute();

            // Cerrar la conexión
            $this->database->disconnect();
            return $result;
        } catch (Exception $e) {
            $this->database->disconnect();
            return false;
        }
    }

    public function readUsers(): array|bool
    {
        try {
            // Verificar la conexión
            if (!$this->database->connect($this->username, $this->password)) {
                return false;
            }

            // Obtener la conexión
            $connection = $this->database->getConnection();

            // Preparar la consulta
            $stmt = $connection->prepare("CALL sp_test_user_read()");
            $stmt->execute();

            // Obtener los resultados
            $result = $stmt->get_result();
            $users = [];

            // Recorrer los resultados y almacenarlos en un array
            while ($row = $result->fetch_assoc()) {
                $users[] = $row;
            }

            $this->database->disconnect();
            return $users;
        } catch (Exception $e) {
            $this->database->disconnect();
            return false;
        }
    }

    public function updateUserType(string $userId, int $newUserType): bool
    {
        try {
            // Verificar la conexión
            if (!$this->database->connect($this->username, $this->password)) {
                return false;
            }

            // Obtener la conexión
            $connection = $this->database->getConnection();

            // Preparar la consulta
            $stmt = $connection->prepare("CALL sp_test_user_update(?, ?)");
            $stmt->bind_param("si", $userId, $newUserType);

            // Ejecutar la consulta
            $result = $stmt->execute();

            // Cerrar la conexión
            $this->database->disconnect();
            return $result;
        } catch (Exception $e) {
            $this->database->disconnect();
            return false;
        }
    }

    public function deleteUser(string $userId): bool
    {
        try {
            // Verificar la conexión
            if (!$this->database->connect($this->username, $this->password)) {
                return false;
            }

            // Obtener la conexión
            $connection = $this->database->getConnection();

            /// Preparar la consulta
            $stmt = $connection->prepare("CALL sp_test_user_delete(?)");
            $stmt->bind_param("s", $userId);

            // Ejecutar la consulta
            $result = $stmt->execute();
            $this->database->disconnect();
            return $result;
        } catch (Exception $e) {
            $this->database->disconnect();
            return false;
        }
    }

    public function verifyUserLogin(string $userEmail, string $userPassword): array|bool
    {
        try {
            // Verificar la conexión
            if (!$this->database->connect($this->username, $this->password)) {

                //Debug conexion
                //var_dump("Connection failed");

                return false;
            }

            //Obtener la conexión
            $connection = $this->database->getConnection();
            $connection->set_charset('utf8mb4');


            // Preparar la consulta

            //Debug antes de preparar
            //var_dump("Before prepare");
            $stmt = $connection->prepare("CALL sp_verify_user_login(?, ?)");
            //Debug despues de preparar
            //var_dump("After prepare");

            // Debug prepared statement
            //var_dump("Prepared statement created");
            //var_dump($connection->error);
            //var_dump("Parameters to bind:");
            //var_dump($userEmail);
            //var_dump($userPassword);

            $stmt->bind_param("ss", $userEmail, $userPassword);
            // Debug despues del bind_param
            //var_dump("After bind_param");

            // Debug execution
            $executed = $stmt->execute();
            //var_dump("Execute result: " . ($executed ? 'true' : 'false'));
            //var_dump("Statement error: " . $stmt->error);

            // Obtener los resultados
            $result = $stmt->get_result();

            //Debug resultado
            //var_dump("Result:");
            //var_dump($result);

            // Generamos un array asociativo con los datos del usuario
            $userData = $result->fetch_assoc();

            // Debug result data
            //var_dump("User data:");
            //var_dump($userData);

            $this->database->disconnect();
            // Devuelve los datos del usuario si se encontró, o false si no se encontró
            return $userData ? $userData : false;
        } catch (Exception $e) {

            //Debug del error
            //var_dump("Exception caught:");
            //var_dump($e->getMessage());

            $this->database->disconnect();
            return false;
        }
    }
}
