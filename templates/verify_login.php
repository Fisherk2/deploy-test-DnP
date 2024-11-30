<?php
// Manipulamos variables de sesión
session_start();

// Aseguramos que los encabezados de seguridad estén presentes
include_once '../config/security_headers.php';
require_once '../model/User.php';

// Sanitizar y validar los datos del formulario
$email = filter_var($_POST['email'] ?? '', FILTER_SANITIZE_EMAIL);
$password = htmlspecialchars($_POST['password'] ?? '', ENT_QUOTES, 'UTF-8');

// Crear instancia de User
$user_DnP = new User('admin_DnP', '8md!M6s*7%aCDqoY');
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
