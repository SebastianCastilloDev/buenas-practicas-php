<?php
namespace Tantrum\BuenasPracticas;
class Libro {
  private $titulo;
    private $autor;
    public function __construct($titulo, $autor) {
        $this->titulo = $titulo;
        $this->autor = $autor;
        var_dump('Se ha creado un nuevo libro');
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