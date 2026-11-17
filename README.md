DUNGEON.exe xd
Generación procedural de mazmorras mediante Binary Space Partitioning (BSP)

Proyecto desarrollado en **Godot 4 con GDScript**, enfocado en la implementación de algoritmos aplicados al desarrollo de videojuegos.

descripcion
DUNGEON.exe es un prototipo que genera mazmorras bidimensionales automáticamente mediante el algoritmo **Binary Space Partitioning (BSP)
El sistema crea habitaciones de diferentes tamaños, las conecta mediante pasillos y permite generar nuevas distribuciones sin diseñar manualmente cada escenario.

como funciona el algoritmo?
BSP utiliza una estrategia de divide and conquer, subdividiendo recursivamente un espacio rectangular.

El proceso consta de cinco etapas:
1. **Inicialización:** se crea una matriz de 60 × 36 casillas.
2. **Partición:** el mapa se divide en regiones mediante cortes horizontales y verticales.
3. **Recursividad:** las regiones continúan dividiéndose hasta alcanzar un límite de tamaño o profundidad.
4. **Generación:** se crean habitaciones de dimensiones pseudoaleatorias.
5. **Conexión:** se construyen pasillos que comunican las habitaciones.

Tecnologia utilizada
| Godot 4 | Motor gráfico 2D |
| GDScript | Lenguaje de programación |
| BSP | Generación y división espacial |
| RandomNumberGenerator | Generación pseudoaleatoria |

funciones principales
- `generate_dungeon()`: inicializa y genera el mapa.
- `split_region()`: implementa la división recursiva BSP.
- `create_room()`: construye habitaciones.
- `connect_rooms()`: conecta habitaciones mediante pasillos.
- `_draw()`: representa gráficamente la mazmorra.

como ejecutar
1. Descargar o clonar este repositorio.
2. Abrir el proyecto mediante `project.godot` en Godot 4.
3. Abrir la escena `main.tscn.tscn`.
4. Presionar **F6** para ejecutar.
5. Presionar **Espacio** para generar una nueva mazmorra.

aplicaciones

BSP es una técnica de partición espacial utilizada en geometría computacional y desarrollo de videojuegos.
En este proyecto se aplica para automatizar la creación de escenarios, reduciendo la necesidad de diseñar manualmente cada mapa.

Futuras mejoras
El prototipo constituye la base de un videojuego roguelike que posteriormente incorporará exploración, enemigos, combate, objetos y niveles de dificultad.

#Conclusión

DUNGEON.exe demuestra cómo la recursividad, la división espacial y la generación pseudoaleatoria pueden combinarse para construir escenarios dinámicos mediante un algoritmo funcional.


Estado: Prototipo funcional  
Algoritmo:Binary Space Partitioning (BSP)  
Motor: Godot 4  
lenguaje:GDScript
