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
        $this->database = new DnPdatabase('localhost', 'DreamsAndPrints');
    }

    
    public function createUser(string $userId, string $name, string $email, string $userPassword, 
                              string $address, string $phone, int $userType): bool {
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

    public function readUsers(): array|bool {
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

    public function updateUserType(string $userId, int $newUserType): bool {
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

    public function deleteUser(string $userId): bool {
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

    public function verifyUserLogin(string $userEmail, string $userPassword): array|bool {
        try {
            // Verificar la conexión
            if (!$this->database->connect($this->username, $this->password)) {
                return false;
            }
            
            //Obtener la conexión
            $connection = $this->database->getConnection();

            // Preparar la consulta
            $stmt = $connection->prepare("CALL sp_verify_user_login(?, ?)");
            $stmt->bind_param("ss", $userEmail, $userPassword);
            $stmt->execute();
            
            // Obtener los resultados
            $result = $stmt->get_result();
            // Generamos un array asociativo con los datos del usuario
            $userData = $result->fetch_assoc();
            
            $this->database->disconnect();
            // Devuelve los datos del usuario si se encontró, o false si no se encontró
            return $userData ? $userData : false;
        } catch (Exception $e) {
            $this->database->disconnect();
            return false;
        }
    }
}

?>

