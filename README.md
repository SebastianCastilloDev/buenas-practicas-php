# Buenas prácticas con PHP

Esta es una guía basada en diversa documentación y en la lista de reproduccion de Miguel Ángel López en su canal de Youtube. 
[Enlace al canal](https://www.youtube.com/playlist?list=PL3birzc_gcN5LRB9h3yZbzBVSazuWWjQI)

No es una guía estricta, son recomendaciones.

## Tabla de contenidos

[Introducción](#introducción)
**Primera parte: Creando un proyecto para realizar pruebas**
[Composer](#composer)  
[Iniciando un proyecto](#iniciando-un-proyecto)  
[Creando una clase](#creando-una-clase)  
[Creando un index.php](#creando-un-indexphp)  
[Importancia del namespace](#importancia-del-namespace)  
**Segunda parte: Implementando herramientas de calidad del código**

## Introducción

La adopción de estándares, como PSR-12 (Coding Style Guide), es crucial para mantener consistencia en el código fuente y mejorar la legibilidad. Herramientas como PHPCS Fixer, PHPCS, PHPStan, PHPMD y GrumPHP son esenciales para garantizar el cumplimiento de estos estándares y la calidad del código.

* PHPCS Fixer: Automatiza la corrección de problemas de estilo según las reglas definidas por PSR-12, asegurando uniformidad en el código.

* PHPCS: Verifica el cumplimiento de estándares de codificación, identificando posibles mejoras y garantizando coherencia en el estilo del código.

* PHPStan: Realiza análisis estático para descubrir posibles errores y mejorar la calidad del código, identificando problemas antes de la ejecución.

* PHPMD: Busca posibles problemas en el código fuente mediante reglas predefinidas, promoviendo buenas prácticas y señalando áreas de mejora.

* GrumPHP: Automatiza la ejecución de estas herramientas en cada confirmación, proporcionando una capa adicional de verificación y garantizando la calidad del código a lo largo del tiempo.


**Nota: Se recomienda el uso del idioma inglés al momento de desarrollar.**

Lo anterior tiene dos razones, la primera es que es por lejos el idioma más extendido en el mundo del desarrollo. Y la segunda es que muchos frameworks ejecutan instrucciones basadas en el idioma inglés. Como por ejemplo:

`sail artisan make:migration add_rut_to_users_table`


## Composer

Composer es una herramienta de línea de comandos desarrollada para manejar las dependencias en proyectos PHP. Permite a los desarrolladores declarar las bibliotecas de las que depende su proyecto y gestiona automáticamente la instalación y actualización de estas dependencias. Composer utiliza un archivo llamado "composer.json" para definir las dependencias y sus versiones específicas.

Además de gestionar dependencias, Composer también puede manejar la carga automática de clases (autoload), lo que simplifica la inclusión de archivos de clases en un proyecto PHP.


## Iniciando un proyecto

Todo proyecto debe iniciar con `composer init`. Por simplicidad no agregaremos dependencias del proyecto ni dependencias de desarrollo. Tampoco se agregará la estabilidad mínima ni el tipo de licencia. Este es sólo un ejemplo y puede variar bastante dependiendo del proyecto.



```bash
tantrum@ubuntulinux:~/coding/php/buenas-practicas$ composer init

                                            
  Welcome to the Composer config generator  
                                            


This command will guide you through creating your composer.json config.

Package name (<vendor>/<name>) [tantrum/buenas-practicas]:    
Description []: My new project
Author [Sebastian Castillo <tantrum5535@gmail.com>, n to skip]: 
Minimum Stability []: 
Package Type (e.g. library, project, metapackage, composer-plugin) []: project
License []: 

Define your dependencies.

Would you like to define your dependencies (require) interactively [yes]? no
Would you like to define your dev dependencies (require-dev) interactively [yes]? no
Add PSR-4 autoload mapping? Maps namespace "Tantrum\BuenasPracticas" to the entered relative path. [src/, n to skip]:     

{
    "name": "tantrum/buenas-practicas",
    "description": "My new project",
    "type": "project",
    "autoload": {
        "psr-4": {
            "Tantrum\\BuenasPracticas\\": "src/"
        }
    },
    "authors": [
        {
            "name": "Sebastian Castillo",
            "email": "tantrum5535@gmail.com"
        }
    ],
    "require": {}
}

Do you confirm generation [yes]? 
Generating autoload files
Generated autoload files
PSR-4 autoloading configured. Use "namespace Tantrum\BuenasPracticas;" in src/
Include the Composer autoloader with: require 'vendor/autoload.php';
```

Esto nos creará los siguientes elementos:

* `src/`: Este será el directorio donde escribiremos la lógica de nuestra aplicación.
* `vendor/`: Este será el directorio donde se guardarán las dependencias del proyecto.
* `composer.json`: Es un archivo que describe nuestro proyecto, en términos de su configuración y sus dependencias, así como también nos permite escribir scripts para ejecutar comandos a través de la CLI de Composer. Es un archivo que en ocasiones vamos a manipular manualmente. **Nota:** Este archivo es lo que package.json es a Javascript cuando se ejecuta en un entorno NodeJS.

Observemos el campo autoload del archivo `composer.json`:

```json
"autoload": {
    "psr-4": {
        "Tantrum\\BuenasPracticas\\": "src/"
    }
}
```

**Cualquier clase en el espacio de nombres Tantrum\BuenasPracticas se buscará en el directorio `src/``.**

PSR-4 específica un estándar de carga automática que define un mapeo de espacio de nombres a directorios que ayuda a cargar automáticamente las clases del proyecto.

## Creando una clase

Para poder apreciar las buenas prácticas, escribiremos esta clase, LLENA DE MALAS PRÁCTICAS!!.


Archivo: `src/Libro.php`
```php
<?php
class Libro {
    private $titulo;
    private $autor;
    public function __construct($titulo, $autor) {
        $this->titulo = $titulo;
        $this->autor = $autor;
    }
    public function getTitulo() {
        return $this->titulo;
    }
    public function getAutor(){
        return $this->autor;
    }
    public function calcularCostoEnvio(float $distancia, float $factorCosto):float {
        $costoEnvio = $distancia * $factorCosto;
        return $costoEnvio;
    }
}
?>
```
Esta clase representa un libro y contiene información relevante sobre él. Tiene dos propiedades privadas, **\$titulo** y **$autor**, que son establecidas a través del constructor al momento de crear una instancia de la clase. La clase proporciona métodos públicos para obtener el título y el autor del libro, llamados **getTitulo** y **getAutor**, respectivamente.

Además de la información básica del libro, la clase incluye un método adicional llamado **calcularCostoEnvio**. Este método acepta dos parámetros, **\$distancia** y **\$factorCosto**, ambos de tipo float. La función de este método es calcular el costo de envío del libro en función de la distancia y un factor de costo proporcionados. El resultado, representado por la variable **\$costoEnvio**, es devuelto como un valor de tipo float.

En resumen, la clase Libro encapsula la información esencial de un libro y proporciona la funcionalidad adicional de calcular el costo de envío, ofreciendo así una representación básica y funcional de un libro en un contexto más amplio.

**NOTA:** Observe que en el método **calcularCostoEnvio** hemos indicado los tipos de datos que se pasan por parámetro, así como el tipo de dato que devuelve el método y no así en los otros métodos ni en el constructor.

## Creando un index.php

Crearemos una nueva carpeta public, ya que es en esta carpeta donde serviremos los archivos finalmente hacia el cliente.

Archivo: `public/index.php`
```php
<?php

require_once dirname(__DIR__) . '/vendor/autoload.php'; // Incluye el autoloader de Composer

use Tantrum\BuenasPracticas\Libro;

// Crea una instancia de la clase Libro
$miLibro = new Libro("Título del Libro", "Autor del Libro");

// Imprime información del libro
echo "Libro:";
echo "Título: " . $miLibro->getTitulo();
echo "Autor: " . $miLibro->getAutor();

// Calcula y muestra el costo de envío
$distanciaEnvio = 150.5; // Distancia en kilómetros
$factorCostoEnvio = 100.1; // Factor de costo
$costoEnvio = $miLibro->calcularCostoEnvio($distanciaEnvio, $factorCostoEnvio);

echo "Costo de Envío:";
echo "Distancia: " . $distanciaEnvio . " km";
echo "Factor de Costo: " . $factorCostoEnvio;
echo "Costo de Envío: $" . $costoEnvio;
```

## Importancia del namespace

Al intentar ejecutar esto con:
`php -S localhost:3000`
e ingresando la siguiente URL:
`http://localhost:3000/public`
Veremos lo siguiente en nuestra terminal:

```bash
tantrum@ubuntulinux:~/coding/php/buenas-practicas$ php -S localhost:3000
[Fri Jan 19 20:34:33 2024] PHP 8.1.2-1ubuntu2.14 Development Server (http://localhost:3000) started
[Fri Jan 19 20:34:36 2024] 127.0.0.1:37168 Accepted
[Fri Jan 19 20:34:36 2024] 127.0.0.1:37168 [404]: GET / - No such file or directory
[Fri Jan 19 20:34:36 2024] 127.0.0.1:37168 Closing
[Fri Jan 19 20:34:45 2024] 127.0.0.1:53148 Accepted
[Fri Jan 19 20:34:48 2024] PHP Fatal error:  Uncaught Error: Class "Tantrum\BuenasPracticas\Libro" not found in /home/tantrum/coding/php/buenas-practicas/public/index.php:8
Stack trace:
#0 {main}
  thrown in /home/tantrum/coding/php/buenas-practicas/public/index.php on line 8
[Fri Jan 19 20:34:48 2024] 127.0.0.1:53148 [500]: GET /public - Uncaught Error: Class "Tantrum\BuenasPracticas\Libro" not found in /home/tantrum/coding/php/buenas-practicas/public/index.php:8
Stack trace:
#0 {main}
  thrown in /home/tantrum/coding/php/buenas-practicas/public/index.php on line 8
[Fri Jan 19 20:34:48 2024] 127.0.0.1:53148 Closing
```

Particularmente nos interesa este mensaje:
`GET /public - Uncaught Error: Class "Tantrum\BuenasPracticas\Libro" not found in /home/tantrum/coding/php/buenas-practicas/public/index.php`

**¿A qué se debe esto?**
**Respuesta:** No hemos incluído el `namespace` en nuestro archivo `Libro.php`

Al agregarlo de la siguiente forma:

```php
<?php
namespace Tantrum\BuenasPracticas;
class Libro {
    ...
```
Nos deshacemos de ese error.

**NOTA:** Es muy importante agregar nuestro namespace a nuestras clases, ya que el autoload de composer lo requiere.

Finalmente, una vez corregido esto, podremos ver nuestra aplicación funcionando.

# PSR-12

https://www.php-fig.org/psr/psr-12/

Para la implementación de estas herramientas, crearemos una carpeta en la la raiz del proyecto `dev/tools`, donde dejaremos nuestras herramientas. 


## PHPCS:

## PHPCS Fixer:
https://github.com/PHP-CS-Fixer/PHP-CS-Fixer

**Instalación**
`composer require --dev friendsofphp/php-cs-fixer`

podemos crear un [archivo de configuración](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer/blob/master/doc/config.rst), pero por simpleza lo haremos sólo por comandos de la terminal, ya que por defecto PHPCS Fixer utilizará el conjunto de [reglas PSR12](https://github.com/PHP-CS-Fixer/PHP-CS-Fixer/blob/master/doc/ruleSets/PSR12.rst).

Además PHPCS Fixer ignorará por defecto la carpeta vendor y cualquier archivo o directorio oculto de configuracion, tales como .vscode

El comando a utilizar será:
`./vendor/bin/php-cs-fixer fix .`
**Advertencia:** Este comando realizará TODOS los cambios en los archivos que coincidan con la ruta proporcionada.

Para ver que archivos serán modificados sin realizar las modificaciones directamente le podemos pasar el flag `--dry-run`
`./vendor/bin/php-cs-fixer --dry-run fix .`

Una vez ejecutado el script podremos visualizar los cambios directamente en los archivos.

## PHPStan:

## PHPMD:

## GrumPHP: