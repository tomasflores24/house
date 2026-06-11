# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Proyecto

Diseño arquitectónico de una casa particular en un terreno de **8.66m × 35m**. Los planos son archivos HTML estáticos con SVG inline — se abren directo en el navegador, sin servidor ni build. **Leer `README.md` para el contexto del terreno y el porqué de cada decisión de diseño.**

## Archivos y flujo de trabajo

- `partes/` — **acá se edita.** Un fragmento HTML por ambiente/sección, con prefijo numérico que define el orden de armado (`17-pb-bano.html`, `33-pa-dorm-principal.html`, etc.)
- `armar.sh` — concatena `partes/*.html` → `plano_final.html`. **Correrlo después de cada edición.**
- `plano_final.html` — archivo GENERADO, no editarlo a mano. Es el que se abre en el navegador / se comparte por WhatsApp
- `dev.html` — vista en vivo para desarrollo: lee `partes/` directo, checkboxes por ambiente, auto-refresh 1s. Requiere Live Server (http), no funciona con file://. No editarlo salvo que se agreguen/renombren partes (tiene la lista hardcodeada)
- `README.md` — contexto del terreno, preferencias del dueño y temas pendientes
- `.claude/skills/dibujar-plano/` — convenciones de dibujo (escala, colores, tamaños estándar)

**Flujo:** editar solo el fragmento del ambiente pedido (ej. "baño PB" → `partes/17-pb-bano.html`) → `./armar.sh` → listo. No hace falta leer el plano completo.

## Sistema de coordenadas SVG

**Escala:** `1m = 34px`

**Eje Y (profundidad desde calle):**
| Metro | Y (px) |
|-------|--------|
| 0m (calle) | 700 |
| 4m | 564 |
| 6m | 496 |
| 8m | 428 |
| 9m | 394 |
| 12m | 292 |
| 13m | 258 |
| 16m | 156 |

**Eje X (ancho):**
- `x=60` — medianera oeste (muro existente)
- `x=176/180` — muro central divisorio
- `x=309/313` — pared este
- `x=314–340` — pasillo lateral 1m (este)

El norte está arriba (fondo del terreno = patio trasero).

## Layout de habitaciones

### Planta Baja (PB)
| Zona | Posición (desde calle) | Dimensiones |
|------|------------------------|-------------|
| Patio trasero | 16m–35m | 8.66 × 19m |
| Living | 12m–16m, oeste | 3.40 × 4.00m |
| Comedor | 13m–16m, este | 3.84 × 3.00m |
| Cocina | 9m–13m, este | 3.84 × 4.00m |
| Escalera U | 8m–12m, oeste | 2.20 × 4.00m |
| Pasillo interior | 8m–12m, centro | ~1.00m |
| Lavadero + Dep. | 6m–9m, este | 3.84 × 3.00m |
| Baño PB | 4m–8m, oeste | 2.20 × 4.00m |
| Recibidor | 4m–8m, centro | 1.20 × 4.00m |
| Garage | 0m–6m, este | 3.84 × 6.00m |
| Patio delantero | 0m–4m, oeste | libre |

### Planta Alta (PA)
| Zona | Posición (desde calle) | Dimensiones |
|------|------------------------|-------------|
| Vestidor 1 | 12m–16m, oeste | 3.45 × 4.00m (colchón térmico contra medianera) |
| Dorm. Principal | 12m–16m, este | 3.50 × 4.00m (cama en pared este, TV en pared oeste) |
| Escalera U | 8m–12m, oeste | 2.20 × 4.00m |
| Circulación | 8m–12m, centro | 2.24 × 4.00m |
| Baño PA | 8m–12m, este | 2.80 × 4.00m |
| Dorm. 2 | 4m–8m, oeste | 3.40 × 4.00m |
| Vestidor 2 | 6m–8m, este | 3.84 × 2.00m (sobre lavadero) |
| Sin losa | 0m–4m + garage | — |

## Sistema de columnas

- **Verde** (`#3b8a3b`) — columnas existentes en medianera oeste, cada 4m
- **Rojo** (`#D43A3A`) — columnas nuevas en pared este, cada 4m
- **Naranja** (`#ff7800`) — columnas centrales, cada 4m
- Las columnas de soporte del Vestidor 2 (naranja + rojo) están a `y=490` (6m)

## Puertas y aberturas (solo PB por ahora)

- **Azul** (`#1565c0`) — ventanas: ventanales pared norte (~1.80m) y ventana baño PB en pared sur (~1.00m)
- **Rojo** (`#c62828`) — puertas (~28px ≈ 0.82m) y aberturas entre ambientes
- Aberturas anchas (living↔comedor, cocina↔comedor) se dibujan como hueco en el muro central
- En PA solo el Dorm Principal tiene aberturas dibujadas: ventana norte y puerta al vestidor (pared oeste, parte sur). También tiene muebles (cama + TV) en `<g id="capa-muebles-pa">`

## Convenciones SVG

Al agregar o modificar elementos, respetar:
1. Los comentarios `<!-- NOMBRE AMBIENTE -->` antes de cada bloque
2. Las clases `.LA` (label ambiente, bold 13px) y `.LM` (label medidas, 11px) para etiquetas
3. Muros estructurales: `fill="#333"` o `fill="#555"`, grosor 4–8px
4. Muros secundarios / divisorios: `fill="#444"` o con `opacity`
5. El `viewBox="0 0 400 720"` es fijo — no cambiar sin recalcular todas las coordenadas
