<?php
// Manipulamos variables de sesión
session_start();

// Aseguramos que los encabezados de seguridad estén presentes
include_once '../config/security_headers.php';
include_once __DIR__ . '/../config/env_var.php';
require_once '../model/User.php';

// Sanitizar las entradas
$email = filter_var($_POST['email'] ?? '', FILTER_SANITIZE_EMAIL);
$password = htmlspecialchars($_POST['password'] ?? '', ENT_QUOTES, 'UTF-8');

// Convertir a utf8mb4
$email = mb_convert_encoding($email, 'UTF-8', 'UTF-8');
$password = mb_convert_encoding($password, 'UTF-8', 'UTF-8');

// Crear instancia de User
$user_DnP = new User(USER_ADMIN_DNP, PWD_ADMIN_DNP);
$result = $user_DnP->verifyUserLogin($email, $password);

$message = '';
$success = false;


if ($result) {
    $message = "¡Bienvenido " . $result['user_name'] . "!";
    $success = true;

    // Iniciar sesión
    $_SESSION['user'] = $result;
    // Destruir la sesión si las credenciales son correctas
    session_destroy();
} else {

    // Destruir la sesión si las credenciales son incorrectas
    session_destroy();
    $message = "Credenciales incorrectas. Por favor, intente nuevamente.";
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verificación - Dreams and Prints</title>
    <link rel="stylesheet" href="../styles/login.css">
</head>
<body>
    <div class="login-container">
        <div class="result-box <?php echo $success ? 'success' : 'error'; ?>">
            <h2><?php echo $message; ?></h2>
            <a href="../templates/login.php" class="back-btn">Volver al Login</a>
        </div>
    </div>
</body>
</html>
