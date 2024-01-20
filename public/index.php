<?php

require_once dirname(__DIR__) . '/vendor/autoload.php'; // Incluye el autoloader de Composer

use Tantrum\BuenasPracticas\Libro;

// Crea una instancia de la clase Libro
$miLibro = new Libro("Título del Libro", "Autor del Libro");

// Imprime información del libro
echo "Libro:\n";
echo "Título: " . $miLibro->getTitulo() . "\n";
echo "Autor: " . $miLibro->getAutor() . "\n";

// Calcula y muestra el costo de envío
$distanciaEnvio = 150.5; // Distancia en kilómetros
$factorCostoEnvio = 100.1; // Factor de costo
$costoEnvio = $miLibro->calcularCostoEnvio($distanciaEnvio, $factorCostoEnvio);

echo "\nCosto de Envío:\n";
echo "Distancia: " . $distanciaEnvio . " km\n";
echo "Factor de Costo: " . $factorCostoEnvio . "\n";
echo "Costo de Envío: $" . $costoEnvio . "\n";
