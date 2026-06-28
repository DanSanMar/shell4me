# 🐚 SHELL4ME — Smart Shell Optimizer

<p align="center">
  <img src="https://img.shields.io/badge/Shell-Bash%20%7C%20Zsh-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white" alt="Shell Support">
  <img src="https://img.shields.io/badge/Platform-Linux%20%7C%20macOS-000000?style=for-the-badge&logo=linux&logoColor=white" alt="Platform Support">
  <img src="https://img.shields.io/badge/Kali%20Linux-Compatible-8190ff?style=for-the-badge&logo=kali-linux&logoColor=white" alt="Kali Compatible">
</p>

**SHELL4ME** es un configurador y optimizador inteligente de terminales interactivo y multiplataforma. Detecta automáticamente si estás utilizando **Bash** o **Zsh** (como en las versiones modernas de Kali Linux) y despliega un menú ASCII interactivo para activar superpoderes de navegación, historial y autocompletado con un solo clic.

---

## 🚀 Características Principales

* **Detección Automática de Shell:** Identifica de forma infalible si tu terminal corre sobre `zsh` o `bash` y adapta las opciones de forma dinámica.
* **Menú Interactivo en Terminal:** Olvídate de editar archivos de configuración a mano. Muévete con las `Flechas`, selecciona con el `Espacio` y guarda con `Enter`.
* **Idempotente y Seguro:** Si vuelves a ejecutar el script para cambiar tus opciones, este limpiará el bloque anterior y generará uno nuevo sin duplicar líneas ni romper tu configuración actual (`.bashrc` o `.zshrc`).
* **Protección Anti-Errores:** Todas las opciones inyectadas cuentan con salvaguardas (`2>/dev/null || true`) para asegurar compatibilidad total entre sistemas antiguos y modernos sin romper la carga de tu terminal.

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