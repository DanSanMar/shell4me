#!/bin/bash

# DETECCIÓN: Mira el nombre del proceso padre (PPID) que invocó el script
DETECTED_SHELL=$(ps -p $PPID -o comm= 2>/dev/null | tr -d '-')

# Sistema de respaldo secundario si ps falla
if [ -z "$DETECTED_SHELL" ] || [ "$DETECTED_SHELL" == "bash" ] || [ "$DETECTED_SHELL" == "sh" ]; then
    if [[ "$SHELL" == *"zsh"* ]]; then
        DETECTED_SHELL="zsh"
    fi
fi

# Configurar variables y opciones expandidas según la Shell detectada
if [[ "$DETECTED_SHELL" == *"zsh"* ]]; then
    TARGET_RC="$HOME/.zshrc"
    MARKER="# === BLOQUE SETOPT PERSONALIZADO (ZSH) ==="
    SHELL_NAME="Zsh"
    OPCIONES=(
        "autocd"         "Entra a directorios directamente escribiendo solo su nombre" "on"
        "correct"        "Corrige automáticamente la ortografía de los comandos mal escritos" "on"
        "correctall"     "Corrige la ortografía de los argumentos y rutas de archivos" "on"
        "globdots"       "Incluye archivos ocultos (con punto) al usar el comodín *" "off"
        "extendedglob"   "Habilita patrones de búsqueda ultra avanzados en la terminal" "off"
        "histignoredups" "No guarda un comando en el historial si es igual al anterior" "on"
        "histfindnodups" "Al buscar en el historial con flechas, omite duplicados" "on"
        "sharehistory"   "Comparte el historial de comandos en tiempo real entre pestañas" "on"
        "bgnice"         "Ejecuta los procesos en segundo plano con menor prioridad" "on"
        "nonomatch"      "Si un patrón de búsqueda falla, no lances error (estilo Bash)" "on"
    )
else
    TARGET_RC="$HOME/.bashrc"
    MARKER="# === BLOQUE SHOPT PERSONALIZADO (BASH) ==="
    SHELL_NAME="Bash"
    OPCIONES=(
        "autocd"       "Entra a directorios directamente escribiendo solo su nombre" "on"
        "cdspell"      "Corrige errores ortográficos leves en el comando 'cd'" "on"
        "dirspell"     "Corrige errores ortográficos al usar el Autocompletar (Tab)" "on"
        "direxpand"    "Expande las variables al autocompletar (ej: cd \$VAR -> ruta)" "on"
        "dotglob"      "Incluye archivos ocultos (con punto) al usar el comodín *" "off"
        "extglob"      "Habilita el Globbing extendido (patrones de búsqueda avanzados)" "off"
        "globstar"     "Permite usar ** para buscar recursivamente en subdirectorios" "on"
        "checkwinsize" "Actualiza el tamaño de la ventana en Bash tras cada comando" "on"
        "histappend"   "Añade comandos al historial en lugar de sobrescribir el archivo" "on"
    )
fi


CYAN="\e[36m"
GREEN="\e[32m"
MAGENTA="\e[35m"
WHITE="\e[97m"
BLUE="\e[34m"
YELLOW="\e[33m"
RESET="\e[0m"

num_opciones=$((${#OPCIONES[@]} / 3))
cursor=0

mostrar_logo_y_menu() {
    clear
    
    echo -e "${CYAN}"
    echo "     ███████╗██╗  ██╗███████╗██╗     ██╗     ██╗  ██╗███╗   ███╗███████╗"
    echo "     ██╔════╝██║  ██║██╔════╝██║     ██║     ██║  ██║████╗ ████║██╔════╝"
    echo -e "${GREEN}"
    echo "     ███████╗███████║█████╗  ██║     ██║     ███████║██╔████╔██║█████╗  "
    echo "     ╚════██║██╔══██║██╔══╝  ██║     ██║     ╚════██║██║╚██╔╝██║██╔══╝  "
    echo -e "${MAGENTA}"
    echo "     ███████║██║  ██║███████╗███████╗███████╗     ██║██║ ╚═╝ ██║███████╗"
    echo "     ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝     ╚═╝╚═╝     ╚═╝╚══════╝"
    echo ""
    echo -e "${WHITE}               ░▒▓ S H E L L   4   M E ▓▒░ --[ V 1.0 ]--"
    echo -e "${BLUE}--[ Optimizador y Configurador Inteligente de Shell Multientorno ]--${RESET}"
    echo -e "${WHITE}--========================================================================${RESET}"
    echo -e " Detectado: ${GREEN}$SHELL_NAME${RESET} -> Configurando: ${YELLOW}$TARGET_RC${RESET}"
    echo -e " Usa las ${YELLOW}flechas (↑ ↓)${RESET} para moverte, ${YELLOW}[Espacio]${RESET} para seleccionar y ${YELLOW}[Enter]${RESET} para guardar."
    echo -e "${WHITE}--========================================================================${RESET}\n"

    local idx=0
    for ((i=0; i<${#OPCIONES[@]}; i+=3)); do
        local opt="${OPCIONES[i]}"
        local desc="${OPCIONES[i+1]}"
        local state="${OPCIONES[i+2]}"
        
        local check="[ ]"
        if [ "$state" == "on" ]; then check="[X]"; fi

        if [ $idx -eq $cursor ]; then
            echo -e " ${GREEN}➔ $check $opt:${RESET} $desc"
        else
            echo -e "    $check $opt: $desc"
        fi
        ((idx++))
    done
    echo -e "\n${CYAN}------------------------------------------------------------------------${RESET}"
}

# Bucle principal de captura de teclado
while true; do
    mostrar_logo_y_menu
    IFS= read -rsn1 key
    if [[ $key == $'\x1b' ]]; then
        read -rsn2 -t 0.1 key
        case "$key" in
            "[A")
                ((cursor--))
                [ $cursor -lt 0 ] && cursor=$((num_opciones - 1))
                ;;
            "[B")
                ((cursor++))
                [ $cursor -ge $num_opciones ] && cursor=0
                ;;
        esac
    elif [[ $key == "" ]]; then
        break
    elif [[ $key == " " ]]; then
        elemento_idx=$((cursor * 3 + 2))
        if [ "${OPCIONES[elemento_idx]}" == "on" ]; then
            OPCIONES[elemento_idx]="off"
        else
            OPCIONES[elemento_idx]="on"
        fi
    fi
done

# --- PROCESAMIENTO Y GUARDADO ---
if [ -f "$TARGET_RC" ] && grep -q "$MARKER" "$TARGET_RC"; then
    echo "Actualizando configuración existente..."
    sed -i "/$MARKER/,\$d" "$TARGET_RC"
fi

touch "$TARGET_RC"
echo -e "\nGuardando configuración..."

{
echo "$MARKER"
echo "# ---------------- ---------------------------------------------------"
echo "# Configuración personalizada de $SHELL_NAME - Generado por SHELL4ME"
echo "# -------------------------------------------------------------------"

for ((i=0; i<${#OPCIONES[@]}; i+=3)); do
    opt="${OPCIONES[i]}"
    desc="${OPCIONES[i+1]}"
    state="${OPCIONES[i+2]}"
    
    if [ "$state" == "on" ]; then
        echo -e "\n# $desc"
        if [ "$SHELL_NAME" == "Zsh" ]; then
            echo "setopt $opt 2>/dev/null || true"
        else
            echo "shopt -s $opt 2>/dev/null || true"
        fi
    fi
done

echo -e "\n# Fin del bloque personalizado"
echo "# ==================================="
} >> "$TARGET_RC"

echo -e "\n${GREEN}¡Éxito! Modificaciones guardadas en $TARGET_RC.${RESET}"
echo -e "Para aplicar los cambios ahora mismo, ejecuta: ${YELLOW}source $TARGET_RC${RESET}"