# 🐚 SHELL4ME — Smart Shell Optimizer

  

<p align="center">

  <img src="https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell Support">

  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-000000?style=for-the-badge&logo=linux&logoColor=white" alt="Platform Support">

  <img src="https://img.shields.io/badge/Kali%20Linux-Compatible-8190ff?style=for-the-badge&logo=kali-linux&logoColor=white" alt="Kali Compatible">

</p>

  

**SHELL4ME** es un configurador de terminales orientado a detectar automáticamente si tu entorno trabaja sobre **Bash** o **Zsh**, desplegando un menú interactivo en la propia terminal para gestionar directivas de comportamiento comunes mediante el uso del teclado.

  

---

  

## 🚀 Características Principales

  

* **Detección Automática de Shell:** Identifica si tu terminal corre sobre `zsh` o `bash` para adaptar las opciones disponibles de forma dinámica.

* **Menú Interactivo en Terminal:** Permite desplazarse con las `Flechas (↑ ↓)`, alternar estados con el `Espacio` y guardar con `Enter`.

* **Actualización Limpia:** Si se vuelve a ejecutar el script para cambiar parámetros, este localiza el bloque previo instalado por la herramienta para reemplazarlo, buscando evitar la duplicidad de líneas o la alteración del resto de tu configuración (`.bashrc` o `.zshrc`).

* **Salvaguardas de Compatibilidad:** Las opciones inyectadas cuentan con redirecciones de error (`2>/dev/null || true`) con el fin de prevenir fallos de carga en entornos o versiones de Shell que carezcan de soporte para alguna directiva específica.

  

---

  

## 🚀 Novedades de la Versión 1.5.1

  

Esta versión introduce revisiones en el comportamiento de la interfaz de usuario (TUI) y añade mayor visibilidad al proceso de respaldo de archivos para aportar más control al usuario.

  

### 🛠️ Renderizado Atómico (Mitigación de Parpadeo)

* **Compatibilidad entre Entornos:** Al procesar bucles de texto a ritmos distintos según la Shell, la limpieza de pantalla tradicional generaba en ocasiones un efecto de parpadeo perceptible en entornos Bash.

* **Uso de un Buffer Único:** Se ha estructurado el menú para acumular el diseño en una variable intermedia, aplicando un único comando `printf` al final del ciclo. Al no dejar la terminal temporalmente vacía, la sobrescritura de caracteres reduce de forma notable las transiciones bruscas en la interfaz.

* **Gestión del Cursor:** El cursor habitual de la consola se oculta durante la navegación y se restablece de forma automática al salir a través de `Q` o al confirmar con `Enter`.

* **Control de Interrupciones:** Se ha incorporado un manejador de señales (`trap`) enfocado en interceptar combinaciones como `Ctrl+C`, asegurando que la terminal recupere su estado visual ordinario incluso si se detiene la ejecución abruptamente.

  

---

  

### 🛡️ Sistema de Seguridad y Respaldos Transparente

  

Con la idea de mantener la integridad de los ficheros de configuración, el asistente desglosa visualmente su actividad en tres fases bien definidas:

  

```text

[1/3] Creando copia de seguridad en: ~/.zshrc.bak_shell4me...

[2/3] Detectada configuración previa de SHELL4ME. Limpiando líneas antiguas...

[3/3] Escribiendo nuevas directivas de optimización...

  

Copia de Respaldo: Antes de modificar el archivo destino, se genera un duplicado preventivo con la extensión .bak_shell4me en el directorio de usuario, permitiendo conservar el estado original de la configuración por si se desea revertir el proceso manualmente.

  

Filtrado por Bloques (AWK): El script hace uso de marcas delimitadoras (# === INICIO... y # === FIN...). Si localiza estas marcas de ejecuciones previas, remueve quirúrgicamente solo las directivas añadidas por la herramienta, preservando intactos tus alias, funciones o scripts personales.

  

Desactivación Explícita: Al desmarcar una casilla del menú, el script escribe directivas de desactivación voluntaria (unsetopt / shopt -u) para intentar mitigar comportamientos que pudieran venir heredados o activos por defecto en la base del sistema operativo.

  
````



# 🛠️ Opciones Disponibles (Según tu Entorno)

🔹 Para Zsh (Kali Linux, macOS...)
	
autocd: Permite acceder a una ruta de directorio directamente escribiendo su nombre, sin necesidad del comando cd.

  

correct / correctall: Aplica corrección ortográfica e indicaciones ante pequeños fallos al escribir comandos o argumentos.

  

histignoredups / histfindnodups: Optimiza el archivo del historial omitiendo el registro de instrucciones consecutivas idénticas.

  

sharehistory: Intenta comunicar el historial entre diferentes terminales abiertas en tiempo real.

  

bgnice: Ajusta la prioridad de los procesos lanzados en segundo plano buscando preservar la fluidez del entorno gráfico.

  

# 🔹 Para Bash (Ubuntu, Debian, CentOS...)

autocd: Navegación por carpetas introduciendo la ruta de forma directa sin el prefijo cd.

  

cdspell / dirspell: Corrección automática de pequeños errores de tipeo al usar rutas o comandos de navegación.

  

direxpand: Intenta expandir visualmente el valor de las variables en la línea de comandos al pulsar la tecla de autocompletado.

  

globstar: Habilita el uso de patrones avanzados () para realizar búsquedas recursivas en subdirectorios.

  

checkwinsize: Comprueba y actualiza las variables de tamaño de ventana tras cada instrucción para reajustar el texto de la terminal.

  

## 📦 Instalación y Uso de un Solo Vistazo

Para probar este asistente en tu entorno local, puedes seguir los siguientes pasos en tu terminal:

  

## 1. Clona el repositorio

git clone [https://github.com/DanSanMar/shell4me.git](https://github.com/DanSanMar/shell4me.git)

cd shell4me

  

### 2. Concede permisos de ejecución al script

chmod +x shell4me.sh

  

### 3. Inicia el menú interactivo

./shell4me.sh

  

## 🎯 Aplicar los cambios de inmediato

Al finalizar de forma exitosa, las líneas se habrán guardado de manera limpia al final del fichero correspondiente. Para cargarlas en la sesión de terminal que tienes abierta actualmente sin requerir un reinicio completo, utiliza el comando correspondiente:

  

Si tu entorno es Zsh:

  

Bash

source ~/.zshrc

Si tu entorno es Bash:

  

Bash

source ~/.bashrc

Menú Interactivo (Vista Previa)

```

     ███████╗██╗  ██╗███████╗██╗     ██╗     ██╗  ██╗███╗   ███╗███████╗
     ██╔════╝██║  ██║██╔════╝██║     ██║     ██║  ██║████╗ ████║██╔════╝
     ███████╗███████║█████╗  ██║     ██║     ███████║██╔████╔██║█████╗  
     ╚════██║██╔══██║██╔══╝  ██║     ██║     ╚════██║██║╚██╔╝██║██╔══╝  
     ███████║██║  ██║███████╗███████╗███████╗     ██║██║ ╚═╝ ██║███████╗
     ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝     ╚═╝╚═╝     ╚═╝╚══════╝

               ░▒▓ S H E L L   4   M E ▓▒░ --[ V 1.5.1 ]--
--[ Optimizador y Configurador Inteligente de Shell Multientorno ]--
--========================================================================
 Detectado: Bash -> Configurando: /home/kali/.bashrc -> Para salir: Pulsa Ctrl+C
 Usa las flechas (↑ ↓) para moverte, [Espacio] para seleccionar y [Enter] para guardar.
--========================================================================
    [X] autocd: Entra a directorios directamente escribiendo solo su nombre
 ➔ [X] cdspell: Corrige errores ortográficos leves en el comando 'cd''
    [X] dirspell: Corrige errores ortográficos al usar el Autocompletar (Tab)
    [X] direxpand: Expande las variables al autocompletar (ej: cd $VAR -> ruta)
    [ ] dotglob: Incluye archivos ocultos (con punto) al usar el comodín *
    [ ] extglob: Habilita el Globbing extendido (patrones de búsqueda avanzados)
    [X] globstar: Permite usar ** para buscar recursivamente en subdirectorios
    [X] checkwinsize: Actualiza el tamaño de la ventana en Bash tras cada comando
    ```