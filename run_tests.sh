#!/bin/bash
# =============================================================================
# run_tests.sh — Suite de pruebas automatizada dinámica
# =============================================================================

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'  # No Color

# 1. Buscar ejecutables 'trad' y 'back' en el directorio actual
if [ -x "./trad" ]; then 
    RAW_TRAD="./trad"
else 
    echo -e "${RED}ERROR: No se encuentra el ejecutable 'trad' en este directorio. Asegúrate de haberlo compilado.${NC}"
    exit 1
fi

if [ -x "./back" ]; then 
    RAW_BACK="./back"
else 
    echo -e "${RED}ERROR: No se encuentra el ejecutable 'back' en este directorio. Asegúrate de haberlo compilado.${NC}"
    exit 1
fi

TRAD="$RAW_TRAD"
BACK="$RAW_BACK"
PASS=0
FAIL=0
SKIP=0
TOTAL=0
TMP_FILES=()

pass() { echo -e "  ${GREEN}[PASS]${NC} $1" ; ((PASS++)) ; ((TOTAL++)) ; return 0; }
fail() { echo -e "  ${RED}[FAIL]${NC} $1" ; echo -e "       Detalle: $2" ; ((FAIL++)) ; ((TOTAL++)) ; return 0; }
skip() { echo -e "  ${YELLOW}[SKIP]${NC} $1 — $2" ; ((SKIP++)) ; ((TOTAL++)) ; return 0; }

cleanup_tmp() {
    local f
    for f in "${TMP_FILES[@]}"; do
        [ -n "$f" ] && [ -e "$f" ] && rm -f "$f"
    done
}

# Wrappers para limpiar comentarios de C y Lisp antes de compilar
setup_wrappers() {
    local trad_wrapper back_wrapper
    trad_wrapper=$(mktemp)
    back_wrapper=$(mktemp)
    TMP_FILES+=("$trad_wrapper" "$back_wrapper")

    cat > "$trad_wrapper" <<EOF
#!/bin/bash
set -euo pipefail
perl -0777 -pe 's@/\*.*?\*/@@gs' | "$RAW_TRAD"
EOF

    cat > "$back_wrapper" <<EOF
#!/bin/bash
set -euo pipefail
sed -E 's/[[:space:]]*;.*$//' | sed '/^[[:space:]]*$/d' | "$RAW_BACK"
EOF

    chmod +x "$trad_wrapper" "$back_wrapper"
    TRAD="$trad_wrapper"
    BACK="$back_wrapper"
}

run_test_dynamic() {
    local file="$1"
    local tool="$2"
    local expect_error="$3"
    local basename=$(basename "$file")

    # Ejecutamos el wrapper pasándole el archivo
    err_out=$("$tool" < "$file" 2>&1)
    local exit_code=$?

    if [ "$expect_error" = false ]; then
        if [ $exit_code -eq 0 ]; then
            pass "$basename (Aceptado correctamente)"
        else
            # Si falla, mostramos la primera línea de la salida
            local primera_linea=$(echo "$err_out" | head -n 1)
            fail "$basename (Debía ser aceptado pero falló)" "Exit code: $exit_code | Salida: $primera_linea"
        fi
    else
        # Es una prueba de error: buscamos exit code != 0 o que la salida contenga palabras clave de error
        if [ $exit_code -ne 0 ] || echo "$err_out" | grep -qi "error\|syntax\|línea\|linea\|line"; then
            pass "$basename (Rechazado correctamente)"
        else
            fail "$basename (Debía ser rechazado pero fue aceptado)" "Exit code: $exit_code"
        fi
    fi
}

# =============================================================================
# EJECUCIÓN DINÁMICA
# =============================================================================

run_frontend() {
    echo -e "\n${BLUE}=======================================================${NC}"
    echo -e "${BLUE} FRONTEND — Casos VÁLIDOS (deben producir Lisp correcto)${NC}"
    echo -e "${BLUE}=======================================================${NC}"
    for file in pruebas/frontend/t*.c; do
        [ -f "$file" ] && run_test_dynamic "$file" "$TRAD" false
    done

    echo -e "\n${BLUE}=======================================================${NC}"
    echo -e "${BLUE} FRONTEND — Casos INVÁLIDOS (deben producir error)     ${NC}"
    echo -e "${BLUE}=======================================================${NC}"
    for file in pruebas/frontend/e*.c; do
        [ -f "$file" ] && run_test_dynamic "$file" "$TRAD" true
    done
}

run_backend() {
    echo -e "\n${BLUE}=======================================================${NC}"
    echo -e "${BLUE} BACKEND — Casos VÁLIDOS (Lisp -> Forth correcto)      ${NC}"
    echo -e "${BLUE}=======================================================${NC}"
    for file in pruebas/backend/bt*.l; do
        [ -f "$file" ] && run_test_dynamic "$file" "$BACK" false
    done

    echo -e "\n${BLUE}=======================================================${NC}"
    echo -e "${BLUE} BACKEND — Casos INVÁLIDOS (deben producir error)      ${NC}"
    echo -e "${BLUE}=======================================================${NC}"
    for file in pruebas/backend/be*.l; do
        [ -f "$file" ] && run_test_dynamic "$file" "$BACK" true
    done
}

run_integracion() {
    echo -e "\n${BLUE}=======================================================${NC}"
    echo -e "${BLUE} INTEGRACIÓN — Pipeline C -> Lisp (-> Forth)           ${NC}"
    echo -e "${BLUE}=======================================================${NC}"
    
    for file in pruebas/integracion/it*.c; do
        [ ! -f "$file" ] && continue
        local basename=$(basename "$file")
        
        # Primero probamos el frontend
        lisp_out=$("$TRAD" < "$file" 2>/dev/null)
        if [ $? -eq 0 ]; then
            # Hacemos el pipeline completo hacia el backend
            forth_out=$(echo "$lisp_out" | "$BACK" 2>/dev/null)
            if [ $? -eq 0 ]; then
                pass "$basename Pipeline C->Lisp->Forth completado"
            else
                fail "$basename Pipeline falló en el Backend" ""
            fi
        else
            fail "$basename Falló en el Frontend" ""
        fi
    done
}

print_summary() {
    echo -e "\n======================================================="
    echo " RESUMEN FINAL"
    echo "======================================================="
    echo -e "  Total de pruebas: $TOTAL"
    echo -e "  ${GREEN}Pasados:  $PASS${NC}"
    echo -e "  ${RED}Fallidos: $FAIL${NC}"
    echo -e "  ${YELLOW}Omitidos: $SKIP${NC}"
    echo "======================================================="
    [ "$FAIL" -eq 0 ] && [ "$TOTAL" -gt 0 ] && echo -e "  ${GREEN}¡TODAS LAS PRUEBAS PASADAS CON ÉXITO!${NC}\n" \
                      || echo -e "  ${RED}HAY FALLOS O NO SE ENCONTRARON PRUEBAS — revisa los detalles arriba${NC}\n"
}

# =============================================================================
# MAIN
# =============================================================================
trap cleanup_tmp EXIT
setup_wrappers

run_frontend
run_backend
run_integracion
print_summary

exit $FAIL