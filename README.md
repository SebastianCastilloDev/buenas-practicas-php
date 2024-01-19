# Buenas prácticas con PHP

Esta es una guía basada en diversa documentación y en la lista de reproduccion de Miguel Ángel López en su canal de Youtube. 
[Enlace al canal](https://www.youtube.com/playlist?list=PL3birzc_gcN5LRB9h3yZbzBVSazuWWjQI)

No es una guía estricta, son recomendaciones.

**Nota: Se recomienda el uso del idioma inglés al momento de desarrollar.**

Lo anterior tiene dos razones, la primera es que es por lejos el idioma más extendido en el mundo del desarrollo. Y la segunda es que muchos frameworks ejecutan instrucciones basadas en el idioma inglés. Como por ejemplo:

`sail artisan make:migration add_rut_to_users_table`


# Composer

Composer es una herramienta de línea de comandos desarrollada para manejar las dependencias en proyectos PHP. Permite a los desarrolladores declarar las bibliotecas de las que depende su proyecto y gestiona automáticamente la instalación y actualización de estas dependencias. Composer utiliza un archivo llamado "composer.json" para definir las dependencias y sus versiones específicas.

Además de gestionar dependencias, Composer también puede manejar la carga automática de clases (autoload), lo que simplifica la inclusión de archivos de clases en un proyecto PHP.

En resumen, Composer simplifica el proceso de gestión de dependencias y facilita la creación y mantenimiento de proyectos PHP al proporcionar una forma estructurada de definir y cargar bibliotecas externas.

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

