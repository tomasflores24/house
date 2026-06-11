#!/bin/bash
# Arma plano_final.html concatenando las partes en orden.
# Uso: ./armar.sh
cd "$(dirname "$0")"
cat partes/*.html > plano_final.html
echo "plano_final.html armado ✔ ($(wc -l < plano_final.html) líneas)"
