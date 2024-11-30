<?php
// Manipulamos variables de sesión
session_start();

// Aseguramos que los encabezados de seguridad estén presentes
include_once '../config/security_headers.php';

?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Dreams and Prints</title>
    <link rel="stylesheet" href="../styles/login.css">
</head>
<body>
    <div class="login-container">
        <div class="login-box">
            <h2>Iniciar Sesión</h2>
            <form action="verify_login.php" method="POST">
                <div class="input-group">
                    <input type="email" name="email" required>
                    <label>Correo Electrónico</label>
                </div>
                <div class="input-group">
                    <input type="password" name="password" required>
                    <label>Contraseña</label>
                </div>
                <button type="submit" class="login-btn">Acceder</button>
            </form>
        </div>
    </div>
</body>
</html>
