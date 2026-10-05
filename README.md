````markdown
# Multi-Stage Compiler: C -> Lisp -> Forth

Compilador de dos fases desarrollado en C que traduce un subconjunto del lenguaje C a código para máquina de pila (Forth), utilizando Common Lisp como representación intermedia (IR).

El proyecto evidencia fundamentos avanzados en la teoría de lenguajes de programación, diseño de parsers y traducción de código entre paradigmas radicalmente distintos: imperativo (C), funcional (Lisp) y basado en pila (Forth).

## Overview

Este proyecto resuelve el problema de compilar código fuente estructurado hacia un lenguaje de bajo nivel basado en pila, dividiendo el problema en dos etapas (Frontend y Backend) para aislar la complejidad.

En lugar de construir un Árbol Sintáctico Abstracto (AST) pesado en memoria, la arquitectura utiliza una **traducción dirigida por sintaxis en una sola pasada**. El código objetivo se emite al vuelo ("on-the-fly") a medida que se resuelven las reducciones gramaticales.

## Key Features

- **Traducción Multi-Paradigma:** Conversión exitosa de estructuras imperativas (`for`, `while`, `switch`) a expresiones funcionales puras y, finalmente, a operaciones de manipulación de pila (`begin...while...repeat`).
- **Analizador Léxico Custom:** Implementación manual de `yylex()` en C puro, prescindiendo de generadores léxicos como Flex.
- **Gestión de Ámbitos (Scope) Simulada:** Lisp utiliza `setq` (asignación global). El compilador simula el _local scope_ de C inyectando dinámicamente prefijos a las variables según su contexto de función (ej. `main_var`), manteniendo aislados los entornos.
- **Transpiler Directo (No-AST):** Uso de atributos semánticos sintetizados en Bison para concatenar y emitir código dinámicamente sin estructuras de datos intermedias, optimizando el consumo de memoria.

## Architecture & Project Structure

La arquitectura consta de dos módulos totalmente independientes conectados mediante la entrada/salida estándar (stdio), facilitando el uso de _pipes_ de Unix.

```mermaid
flowchart LR
    A[Código C] -->|stdin| B(Frontend: trad)
    B -->|stdout| C[IR: Lisp]
    C -->|stdin| D(Backend: back)
    D -->|stdout| E[Output: Forth]
```

```text
project/
├── trad.y            # Frontend: analizador sintáctico C -> Lisp
├── back.y            # Backend: analizador sintáctico Lisp -> Forth
├── Makefile          # Compilación y ejecución de pruebas
├── run_tests.sh      # Suite automatizada de pruebas
└── pruebas/          # Batería de pruebas (frontend, backend e integración)
    ├── frontend/     # Casos de uso sintácticos en C
    ├── backend/      # Casos de uso de generación de pila en Lisp
    ├── integracion/  # Tests end-to-end de la pipeline completa
    └── programas/    # Programas C adicionales para pruebas manuales

```

## Technologies

| Tecnología               | Propósito                                                                 |
| ------------------------ | ------------------------------------------------------------------------- |
| **C**                    | Lenguaje principal de implementación y lógica del compilador.             |
| **GNU Bison**            | Generador del analizador sintáctico (LALR) y parseo de gramáticas.        |
| **Bash**                 | Orquestación del pipeline y ejecución automatizada de la suite de tests.  |
| **Common Lisp / Gforth** | Lenguajes objetivo utilizados para validar la correctitud de los outputs. |

## How It Works

1. **Frontend (`trad`):** Lee un archivo `.c`. Resuelve la precedencia de operadores y problemas clásicos como el _dangling-else_ usando declaraciones directas de Bison (`%left`, `%prec`). Maneja una tabla de símbolos local (`t_context`) para diferenciar globales de locales y emite código Lisp.
2. **Backend (`back`):** Lee el archivo `.l`. Añade prefijos `v_` a todas las variables para evitar colisiones con palabras reservadas de Forth. Transforma la notación prefija de Lisp a la postfija de Forth, inyectando operaciones de memoria de pila (`@`, `!`).

## Installation

**Requisitos previos:** `gcc`, `bison`, `clisp` (opcional, para testear IR) y `gforth`.

```bash
# 1. Clonar el repositorio
git clone <url-del-repo>
cd compiler-c-lisp-forth

# 2. Compilar el frontend y el backend
make

```

## Usage

El compilador no incluye lógicas de I/O en archivos de forma nativa; lee de `stdin` y escribe en `stdout`.

### Ejecución de Pipeline Completo

Para compilar un archivo C directamente a Forth y ejecutarlo:

```bash
cat mi_programa.c | ./trad | ./back | gforth

```

### Ejecución por fases (Debugging)

```bash
# Generar y evaluar solo la Representación Intermedia (Lisp)
./trad < mi_programa.c > temporal.l
clisp temporal.l

# Traducir la representación Lisp a Forth
./back < temporal.l > programa.f
gforth programa.f

```

## Input / Output

### Directiva Principal

Para compilar y ejecutar correctamente, el código C **debe** incluir la directiva embebida `//@ (main)` al final del archivo. El lexer la detecta y transcribe literalmente para instanciar el punto de entrada, evitando impresiones axiomáticas automáticas.

### Ejemplo de Traducción

**Input (C):**

```c
int a = 10;
main() {
    int b = 5;
    if (a > b) {
        printf("%d", a + b);
    }
}
//@ (main)

```

**Intermediate Representation (Lisp):**

```lisp
(setq a 10)
(defun main ()
(setq main_b 5)
(if (> a main_b) (princ (+ a main_b)))
)
(main)

```

**Output (Forth):**

```forth
variable v_a  10 v_a !
: main  variable v_main_b  5 v_main_b !
 v_a @ v_main_b @ >  IF  v_a @ v_main_b @ + .  THEN
 ;
 main

```

## Testing

El proyecto incluye un pipeline de pruebas dinámico (`run_tests.sh`) escrito en Bash que actúa como un entorno CI local. Valida los flujos positivos y el correcto manejo de errores sintácticos mediante códigos de salida.

La estrategia de pruebas se divide en:

- **Frontend Unit Tests:** Valida traducciones individuales de constructs de C (operadores, loops, funciones) y rechaza sintaxis inválida (ej. _cases_ sin _break_, bucles mal formados).
- **Backend Unit Tests:** Comprueba el mapeo de Lisp a Forth, manipulación de variables en memoria (`@`, `!`) y saltos condicionales postfijos.
- **Integration Tests:** Batería E2E comprobando la canalización completa `C -> Lisp -> Forth` asegurando que la semántica se preserva en los 3 lenguajes.

### Running the Tests

Para ejecutar la suite completa:

```bash
make test
```

Para eliminar los ejecutables y los archivos generados:

```bash
make clean
```

**Ejemplo de salida del test runner:**

```text
=======================================================
 FRONTEND   Casos VÁLIDOS (deben producir Lisp correcto)
=======================================================
  [PASS] t01_var_global_simple.c (Aceptado correctamente)
  [PASS] t11_switch_default.c (Aceptado correctamente)
...
=======================================================
 INTEGRACIÓN   Pipeline C -> Lisp (-> Forth)
=======================================================
  [PASS] it01_no_main_auto.c Pipeline C->Lisp->Forth completado
...

```

## Technical Highlights

- **Resolución de Ambigüedades Gramaticales:** En lugar de crear niveles intermedios de parsing (como `term` o `factor`) que saturan la pila recursiva, la gramática resuelve la asociatividad matemáticamente usando directivas deterministas `%left`, `%right` y soluciona el _Dangling-Else_ con predecencias relativas (`%nonassoc IF_THEN`, `%nonassoc ELSE`).
- **Optimización de Retornos (`strip_last_return`):** Algoritmo en C para manipulación de strings que evalúa si un `return` en C es la última instrucción de una función. Si es así, omite generar el bloque rígido `(return-from ...)` de Lisp, emitiendo una expresión puramente funcional y mucho más limpia.
- **Manejo de Memoria Dinámica Segura:** Se diseñó un contenedor envoltorio (`my_malloc`) sobre las asignaciones del sistema que implementa controles de _null-pointers_ y _OOM (Out Of Memory)_ para evitar _Segmentation Faults_ silenciosos durante la concatenación recursiva de código.
