# Buenas prácticas con PHP

Para llevar a cabo las buenas prácticas de escritura de código nos apoyaremos de un conjunto de herramientas, para ello hemos desarrollado un [script](#bash-script) que nos permitirá llevar a cabo esta tarea. En este documento examinaremos la creación de un proyecto de prueba con composer, para poder ejecutar herramientas de análisis de código.


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
[PSR-12](#psr-12)  
[PHPCS](#phpcs)  
[PHPCS-fixer](#phpcs-fixer)  
[PHPStan](#phpstan)  
[PHPmd](#phpmd)  
[Herramienta Bash](#bash-script)  

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
https://github.com/squizlabs/PHP_CodeSniffer

Podemos crear un [archivo de configuracion](), pero en este caso sólo lo haremos por la terminal, ya que con indicarle que standard queremos revisar, podremos obtener los resultados que deseamos respecto a PSR12. Por simplicidad, utilizaremos la versión 3.8. Pero esto no es algo estricto.

**Instalacion:**
`composer require --dev "squizlabs/php_codesniffer=3.8"`
De acuerdo a su documentación: 

PHP_CodeSniffer es un conjunto de dos scripts PHP. 

El script principal `phpcs` que tokeniza archivos PHP, JavaScript y CSS para detectar violaciones de un estándar de codificación definido.

Y un segundo script `phpcbf` para corregir automáticamente las violaciones del estándar de codificación. 

**NOTA:** Utilizaremos PHPCS sólo con archivos PHP.

Para nuestros fines ejecutaremos los script de la siguiente manera:

**Para revisar el código:**
`vendor/bin/phpcs --standard=PSR12 --extensions=php --ignore=vendor/ .`

**Para corregir el código:**
`vendor/bin/phpcbf --standard=PSR12 --extensions=php --ignore=vendor/ .`

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

https://phpstan.org/

Es una herramienta para hacer análisis estático del código.

**Instalación:**
`composer require --dev phpstan/phpstan`

Para ejecutarlo con los checks más básicos ejecutaremos:
`vendor/bin/phpstan analyse src`

Para ejecutar un análisis más profundo podemos pasar el flag `--level`. Los niveles de rigurosidad se pueden revisar en este [enlace](https://phpstan.org/user-guide/rule-levels). Siendo 9 el nivel más alto, donde podremos, por ejemplo, analizar los tipos de datos utilizados en nuestro código. Entregándonos la siguiente salida:

```
------ --------------------------------------------------------------------------------------------------- 
  Line   Libro.php                                                                                          
 ------ --------------------------------------------------------------------------------------------------- 
  :4     Property Tantrum\BuenasPracticas\Libro::$titulo has no type specified.                             
  :5     Property Tantrum\BuenasPracticas\Libro::$autor has no type specified.                              
  :6     Method Tantrum\BuenasPracticas\Libro::__construct() has parameter $autor with no type specified.   
  :6     Method Tantrum\BuenasPracticas\Libro::__construct() has parameter $titulo with no type specified.  
  :11    Method Tantrum\BuenasPracticas\Libro::getTitulo() has no return type specified.                    
  :14    Method Tantrum\BuenasPracticas\Libro::getAutor() has no return type specified.                     
 ------ ---------------------------------------------------------------------------------------------------
 
 ```



## PHPMD:

Esta herramienta nos permitirá revisar si se cumple con los principios SOLID y con la calistenia de objetos

https://phpmd.org/

**Instalación**:
`composer require --dev phpmd/phpmd`

Crearemos el siguiente archivo de configuración

`dev/tools/phpmd.xml`

```xml
<?xml version="1.0"?>
<ruleset>
    <rule ref="rulesets/cleancode.xml"/>
    <rule ref="rulesets/codesize.xml"/>
    <rule ref="rulesets/controversial.xml"/>
    <rule ref="rulesets/design.xml"/>
    <rule ref="rulesets/naming.xml"/>
    <rule ref="rulesets/unusedcode.xml"/>
</ruleset>
```

para ejecutar nuestro análisis lo haremos con el siguiente comando.

`vendor/bin/phpmd src ansi dev/tools/phpmd.xml`

# Bash Script

Este script Bash tiene la finalidad de proporcionar a los desarrolladores una interfaz interactiva para realizar diversas herramientas de análisis estático y formateo de código en proyectos PHP. Las herramientas incluyen PHPCS (PHP_CodeSniffer) para realizar un "code sniffing" según el estándar PSR-12, PHPCS Fixer (PHP-CS-Fixer) para corregir automáticamente las violaciones del estándar de codificación, PHPStan para realizar análisis estático del código con diferentes niveles de rigor, y PHPMD (PHP Mess Detector) para revisar el cumplimiento de los principios SOLID y las reglas de "code smells".

El script guía al usuario a través de cada herramienta, preguntándole si desea ejecutarla y proporcionando opciones adicionales según sea necesario. Cada pregunta está resaltada con un fondo amarillo para mejorar la legibilidad. El flujo de trabajo del script permite al usuario elegir qué herramientas ejecutar y en qué orden, proporcionando una interfaz sencilla y amigable para realizar las tareas de análisis y formateo de código en proyectos PHP.

**ADVERTENCIA:**
**ESTE SCRIPT REQUIERE QUE LAS HERRAMIENTAS ESTEN INSTALADAS**
**ASI COMO TAMBIEN DE LA EXISTENCIA DE EL ARCHIVO [phpmd.xml](/dev/tools/phpmd.xml)**


```bash
#!/bin/bash

while true; do
    # Preguntar al usuario si desea ejecutar PHPCS
    echo
    echo -e "\033[43m¿Deseas ejecutar PHPCS para Code Sniffing?\033[0m" 
    read -p "(y/n): " answer_phpcs
    if [ "$answer_phpcs" == "y" ]; then
        # Ejecución de PHPCS
        ./vendor/bin/phpcs --standard=PSR12 --extensions=php --ignore=vendor/ .
    else
        echo
        echo "Script terminado."
        exit 0
    fi

    # Preguntar al usuario si desea ejecutar PHPCS Fixer
    echo
    echo -e "\033[43m¿Deseas ejecutar PHPCS Fixer?\033[0m"
    read -p "(y/n): " answer_phpcs_fixer
    if [ "$answer_phpcs_fixer" == "y" ]; then
        # Ejecución de PHPCS Fixer
        ./vendor/bin/php-cs-fixer fix .
    else
        break
    fi
done

# Preguntar al usuario el nivel para PHPStan
echo
echo -e "\033[43m¿Deseas ejecutar PHPStan con análisis avanzado?\033[0m"
read -p "(y/n): " answer_phpstan
if [ "$answer_phpstan" == "y" ]; then
    read -p "Ingresa el nivel de análisis para PHPStan (1-9): " phpstan_level
    # Ejecución de PHPStan con el nivel especificado
    ./vendor/bin/phpstan analyse src --level=$phpstan_level
else
    echo
    echo "Script terminado."
    exit 0
fi

# Preguntar al usuario si desea ejecutar PHPMD
echo
echo -e "\033[43m¿Deseas ejecutar PHPMD?\033[0m"
read -p "(y/n): " answer_phpmd
if [ "$answer_phpmd" == "y" ]; then 
    # Ejecución de PHPMD
    ./vendor/bin/phpmd src ansi dev/tools/phpmd.xml
else
    echo
    echo "Script terminado."
    exit 0
fi
echo
echo "Script finalizado con éxito."
```