# 🐚 SHELL4ME — Smart Shell Optimizer

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell Support">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-000000?style=for-the-badge&logo=linux&logoColor=white" alt="Platform Support">
  <img src="https://img.shields.io/badge/Kali%20Linux-Compatible-8190ff?style=for-the-badge&logo=kali-linux&logoColor=white" alt="Kali Compatible">
</p>

**SHELL4ME** es un auto-configurador inteligente de terminales que detecta automáticamente si estás utilizando **Bash** o **Zsh** y despliega un menú ASCII interactivo para activar/desactivar opciones con un solo clic.

---

## 🚀 Características Principales

* **Detección Automática de Shell:** Identifica si tu terminal corre sobre `zsh` o `bash` y adapta las opciones de forma dinámica.
* **Menú Interactivo en Terminal:** Muévete con las `Flechas`, selecciona con el `Espacio` y guarda con `Enter`.
* **Seguro:** Si vuelves a ejecutar el script para cambiar tus opciones, este limpiará el bloque anterior y generará uno nuevo sin duplicar líneas ni romper tu configuración actual (`.bashrc` o `.zshrc`).
* **Protección Anti-Errores:** Todas las opciones inyectadas cuentan con salvaguardas (`2>/dev/null || true`) para asegurar compatibilidad total entre sistemas antiguos y modernos sin romper la carga de tu terminal.

## 🚀 Novedades de la Versión 1.5

Se introducen mejoras en la estabilidad de la interfaz de usuario (TUI) y un sistema transparente de gestión de copias de seguridad para garantizar que el entorno nunca corra peligro.

### 🛠️ Mejoras Visuales y UX
* **Cero Parpadeos y Efecto Fantasma:** Se ha optimizado el refresco de pantalla mediante secuencias de escape nativas (`\e[H\e[J`), eliminando los restos de texto colgado al redimensionar la terminal o navegar rápido por el menú.
* **Cursor Oculto Dinámico:** El cursor parpadeante de la terminal se oculta automáticamente durante el uso del menú interactivo y se restaura al salir (`Q` o `Enter`).
* **Control de Interrupciones Nv-Nativo:** Integración de un manejador de señales (`trap`) para `Ctrl+C` que limpia la pantalla y devuelve el cursor a su estado original sin romper la terminal del usuario.

---

### 🛡️ Sistema de Seguridad y Respaldos Transparente

Para evitar la corrupción de tus archivos de configuración (`.bashrc` o `.zshrc`), la versión 1.5 procesa los cambios en tres fases totalmente visibles durante la ejecución:

```text
[1/3] Creando copia de seguridad en: ~/.zshrc.bak_shell4me...
[2/3] Detectada configuración previa de SHELL4ME. Limpiando líneas antiguas...
[3/3] Escribiendo nuevas directivas de optimización...

---

## 🛠️ Opciones Disponibles (Según tu Entorno)

### 🔹 Para Zsh (Kali Linux, macOS...)
* **autocd:** Accede a carpetas escribiendo solo su nombre (sin necesidad de anteponer `cd`).
* **correct / correctall:** Corrección ortográfica inteligente integrada para comandos y rutas de archivos.
* **histignoredups / histfindnodups:** Limpieza total del historial evitando comandos repetidos consecutivos.
* **sharehistory:** Sincroniza y comparte el historial de comandos entre pestañas abiertas en tiempo real.
* **bgnice:** Reduce la prioridad de procesos en segundo plano para evitar congelamientos en tu entorno visual.

### 🔹 Para Bash (Ubuntu, Debian, CentOS...)
* **autocd:** Navegación directa sin escribir el comando `cd`.
* **cdspell / dirspell:** Corrección automática de pequeños errores tipográficos al moverte entre directorios.
* **direxpand:** Expande visualmente las variables de entorno en la ruta al presionar el tabulador.
* **globstar:** Habilita el uso de doble asterisco (`**`) para realizar búsquedas recursivas profundas.
* **checkwinsize:** Forzado de actualización de filas y columnas al redimensionar las ventanas de la terminal.

---

## 📦 Instalación y Uso de un Solo Vistazo

Para clonar y ejecutar el optimizador en tu máquina local, abre tu terminal y ejecuta los siguientes comandos:

```bash
# 1. Clona el repositorio (o crea el archivo directamente)
git clone [https://github.com/DanSanMar/shell4me.git](https://github.com/DanSanMar/shell4me.git)
cd shell4me

# 2. Concede permisos de ejecución al script
chmod +x shell4me.sh

# 3. Ejecuta el asistente interactivo
./shell4me.sh
```
### 🎯 Aplicar los cambios de inmediato

Al finalizar, el script guardará todo de manera limpia. Para activar las nuevas funciones en la pestaña actual sin reiniciar la máquina, ejecuta:

**Si usas Zsh:**

Bash

```
source ~/.zshrc
```

**Si usas Bash:**

Bash

```
source ~/.bashrc
```

## Menú Interactivo


```
     ███████╗██╗  ██╗███████╗██╗     ██╗     ██╗  ██╗███╗   ███╗███████╗
     ██╔════╝██║  ██║██╔════╝██║     ██║     ██║  ██║████╗ ████║██╔════╝
     ███████╗███████║█████╗  ██║     ██║     ███████║██╔████╔██║█████╗  
     ╚════██║██╔══██║██╔══╝  ██║     ██║     ╚════██║██║╚██╔╝██║██╔══╝  
     ███████║██║  ██║███████╗███████╗███████╗     ██║██║ ╚═╝ ██║███████╗
     ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝     ╚═╝╚═╝     ╚═╝╚══════╝

               ░▒▓ S H E L L   4   M E ▓▒░ --[ V 1.0 ]--
--[ Optimizador y Configurador Inteligente de Shell Multientorno ]--
--========================================================================
 Detectado: Zsh -> Configurando: /home/kali/.zshrc
 Usa las flechas (↑ ↓) para moverte, [Espacio] para seleccionar y [Enter] para guardar.
--========================================================================

 ➔ [X] autocd: Entra a directorios directamente escribiendo solo su nombre
    [X] correct: Corrige automáticamente la ortografía de los comandos mal escritos
    [ ] globdots: Incluye archivos ocultos (con punto) al usar el comodín *
```
