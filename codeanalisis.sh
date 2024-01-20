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
