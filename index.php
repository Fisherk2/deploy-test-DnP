<?php
// Manipulamos variables de sesión
session_start();

// Aseguramos que los encabezados de seguridad estén presentes
include_once 'config/security_headers.php';

// Verificar si el usuario ha iniciado sesión
if (!isset($_SESSION['user'])) {
    header('Location: ../templates/login.php');
    exit();
}

?>      



