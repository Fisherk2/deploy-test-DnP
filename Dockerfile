# Usar una imagen base con PHP 8.3 y Apache
FROM php:8.3-apache

# Instalar extensiones de PHP necesarias (por ejemplo, pdo_mysql)
RUN docker-php-ext-install pdo pdo_mysql

# Copiar los archivos de tu proyecto al directorio raíz del servidor web
COPY . /var/www/html/

# Establecer los permisos correctos para los archivos
RUN chown -R www-data:www-data /var/www/html

# Exponer el puerto 80 para las solicitudes HTTP
EXPOSE 80

# Comando para iniciar Apache al ejecutar el contenedor
CMD ["apache2-foreground"]
