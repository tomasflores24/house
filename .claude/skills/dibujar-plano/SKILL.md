---
name: dibujar-plano
description: Convenciones para dibujar o modificar elementos en los planos SVG de la casa (habitaciones, puertas, ventanas, muebles, cañerías, electricidad). Usar SIEMPRE antes de editar plano_final.html o cualquier plano nuevo.
---

# Dibujar en los planos de la casa

## Regla de oro
**Escala: 1m = 34px.** Nunca dibujar "a ojo" — siempre convertir metros a píxeles con esta tabla y verificar contra las coordenadas existentes.

## Sistema de coordenadas (viewBox 0 0 400 720)

Eje Y (profundidad, desde la calle hacia el fondo):
- 0m (calle) = y700 · 1m = y666 · 2m = y632 · 3m = y598... fórmula: `y = 700 - metros*34`
- Hitos: 4m=564 · 6m=496 · 8m=428 · 9m=394 · 12m=292 · 13m=258 · 16m=156

Eje X (ancho, de oeste a este):
- x=60 medianera oeste (muro existente, 8px ancho)
- x=176–180 muro central
- x=309–313 pared este
- x=314–340 pasillo lateral 1m
- fórmula: `x = 60 + metros*34`

Norte = arriba (fondo del terreno). Terreno: 8.66 × 35m.

## Colores reservados (no reutilizar para otra cosa)

| Color | Uso |
|-------|-----|
| `#1565c0` azul | Ventanas/ventanales (línea width 5) |
| `#c62828` rojo | Puertas y aberturas (línea width 5) |
| `#3b8a3b` verde | Columnas medianera oeste |
| `#D43A3A` rojo col. | Columnas pared este |
| `#ff7800` naranja | Columnas centrales |
| `#333`/`#555` | Muros (rect, 3–8px grosor) |

## Colores para capas futuras (usar estos cuando se pidan)

| Capa | Color sugerido |
|------|----------------|
| Muebles (cama, mesa, sofá) | `#8d6e63` marrón, fill con opacity 0.5, contorno sólido |
| Cañerías agua fría | `#0288d1` celeste, línea dasharray "6 3" |
| Cañerías agua caliente | `#e53935` rojo, línea dasharray "6 3" |
| Desagües/cloacas | `#6d4c41` marrón oscuro, línea width 3 |
| Electricidad (cables/tomas) | `#fbc02d` amarillo, línea dasharray "2 3" |

Cada capa nueva va dentro de un `<g id="capa-nombre">` para poder manejarla entera.

## Dónde editar: carpeta `partes/`
`plano_final.html` es GENERADO — nunca editarlo a mano. Cada ambiente tiene su fragmento en `partes/` (prefijo numérico = orden de armado):
- PB: `12-pb-living` `13-pb-comedor` `14-pb-cocina` `15-pb-escalera-pasillo` `16-pb-lavadero` `17-pb-bano` `18-pb-recibidor` `19-pb-garage` `21-pb-columnas` `22-pb-puertas-ventanas` `23-pb-muebles`
- PA: `32-pa-vestidor1` `33-pa-dorm-principal` `34-pa-escalera-circulacion` `35-pa-bano` `36-pa-dorm2` `37-pa-vestidor2` `39-pa-columnas`
- Estructura: `00-head` `10/30-*-inicio-reglas` `11/31-*-muros` `90-leyenda`

Flujo: leer SOLO el fragmento pedido → editarlo → `./armar.sh` (regenera plano_final.html). Para fragmentos nuevos, respetar el prefijo numérico según dónde deba dibujarse (las capas de arriba van con número mayor dentro de su SVG) y agregarlo también a la lista `PARTES` de `dev.html`.

## Convenciones de etiquetas
- `.LA` = nombre del ambiente (bold 13px)
- `.LM` = medidas (11px), siempre en formato `A.AA × B.BBm`
- Comentario `<!-- NOMBRE -->` antes de cada bloque de elemento

## Tamaños estándar
- Puerta interior: ~28px (0.82m)
- Ventanal: ~61px (1.80m)
- Columna: rect 13×13 con stroke white 2
- Cama 2 plazas: 1.40×1.90m = 48×65px · Cama 1 plaza: 0.90×1.90m = 31×65px
- Mesa comedor 6p: 1.60×0.90m = 54×31px · Sofá 3c: 2.00×0.90m = 68×31px
- Cocina/mesada: 0.60m profundidad = 20px · Heladera: 0.70×0.70m = 24×24px

## Reglas al editar
1. NO cambiar el viewBox — todo se rompe
2. El único plano vigente es `plano_final.html` (PB + PA)
3. El resultado debe verse bien en celular: nada de hover, tooltips, ni interacciones de mouse
4. Un solo archivo HTML autocontenido siempre — CSS y JS inline, sin dependencias externas (se comparte por WhatsApp)
5. Leer `README.md` para el contexto del terreno y las preferencias del dueño
