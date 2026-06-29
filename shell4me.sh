#!/bin/bash

# DETECCIÓN: Mira el nombre del proceso padre (PPID) que invocó el script
DETECTED_SHELL=$(ps -p $PPID -o comm= 2>/dev/null | tr -d '-')
# --- MARCADORES ---
MARKER_START="# === INICIO BLOQUE PERSONALIZADO SHELL4ME ==="
MARKER_END="# === FIN BLOQUE PERSONALIZADO SHELL4ME ==="

# Restaurar cursor y limpiar si el usuario presiona Ctrl+C
trap 'echo -e "\e[?25h"; echo -e "\n${YELLOW}Operación cancelada por el usuario.${RESET}"; exit 1' INT TERM

# Sistema de respaldo secundario si ps falla
if [ -z "$DETECTED_SHELL" ] || [ "$DETECTED_SHELL" == "bash" ] || [ "$DETECTED_SHELL" == "sh" ]; then
    if [[ "$SHELL" == *"zsh"* ]]; then
        DETECTED_SHELL="zsh"
    fi
fi

# Configurar variables y opciones expandidas según la Shell detectada
if [[ "$DETECTED_SHELL" == *"zsh"* ]]; then
    TARGET_RC="$HOME/.zshrc"
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
    local menu=""
    
    # Acumular todo el diseño en una única variable de texto
    menu+="\e[H" # Mueve el cursor arriba sin borrar la pantalla
    menu+="${CYAN}\n"
    menu+="     ███████╗██╗  ██╗███████╗██╗     ██╗     ██╗  ██╗███╗   ███╗███████╗\n"
    menu+="     ██╔════╝██║  ██║██╔════╝██║     ██║     ██║  ██║████╗ ████║██╔════╝\n"
    menu+="${GREEN}"
    menu+="     ███████╗███████║█████╗  ██║     ██║     ███████║██╔████╔██║█████╗  \n"
    menu+="     ╚════██║██╔══██║██╔══╝  ██║     ██║     ╚════██║██║╚██╔╝██║██╔══╝  \n"
    menu+="${MAGENTA}"
    menu+="     ███████║██║  ██║███████╗███████╗███████╗     ██║██║ ╚═╝ ██║███████╗\n"
    menu+="     ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝     ╚═╝╚═╝     ╚═╝╚══════╝\n"
    menu+="\n"
    menu+="${WHITE}               ░▒▓ S H E L L   4   M E ▓▒░ --[ V 1.5.1 ]--\n"
    menu+="${BLUE}--[ Optimizador y Configurador Inteligente de Shell Multientorno ]--${RESET}\n"
    menu+="${WHITE}--========================================================================${RESET}\n"
    menu+=" Detectado: ${GREEN}$SHELL_NAME${RESET} -> Configurando: ${YELLOW}$TARGET_RC${RESET} -> Para salir: Pulsa ${MAGENTA}Ctrl+C${RESET}\n"
    menu+=" Usa las ${YELLOW}flechas (↑ ↓)${RESET} para moverte, ${YELLOW}[Espacio]${RESET} para seleccionar y ${YELLOW}[Enter]${RESET} para guardar.\n"
    menu+="${WHITE}--========================================================================${RESET}\n\n"

    local idx=0
    for ((i=0; i<${#OPCIONES[@]}; i+=3)); do
        local opt="${OPCIONES[i]}"
        local desc="${OPCIONES[i+1]}"
        local state="${OPCIONES[i+2]}"
        
        local check="[ ]"
        if [ "$state" == "on" ]; then check="[X]"; fi

        if [ $idx -eq $cursor ]; then
            menu+=" ${GREEN}➔ $check $opt:${RESET} $desc\n"
        else
            menu+="    $check $opt: $desc\n"
        fi
        ((idx++))
    done
    menu+="\n${CYAN}------------------------------------------------------------------------${RESET}"
    menu+="\e[K" # Borra caracteres fantasmas sobrantes al final de la pantalla

    # Renderizado instantáneo de un solo golpe (Atómico)
    printf "$menu"
}

# Limpieza inicial completa del lienzo y ocultar cursor
echo -ne "\e[H\e[2J"
echo -e "\e[?25l"

# --- Bucle principal ---
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
    elif [[ $key == "q" || $key == "Q" ]]; then
        echo -ne "\e[H\e[2J"
        echo -e "\e[?25h" # Restaurar cursor al salir con Q
        echo -e "${YELLOW}Operación cancelada. No se han hecho cambios.${RESET}"
        exit 0
    fi
done

# --- PROCESAMIENTO Y GUARDADO ---
touch "$TARGET_RC"

BACKUP_FILE="${TARGET_RC}.bak_shell4me"
echo -e "\n${BLUE}[1/3]${RESET} Creando copia de seguridad en: ${YELLOW}$BACKUP_FILE${RESET}..."
cp "$TARGET_RC" "$BACKUP_FILE"

if grep -q "$MARKER_START" "$TARGET_RC"; then
    echo -e "${BLUE}[2/3]${RESET} Detectada configuración previa de SHELL4ME. Limpiando líneas antiguas..."
    awk "/$MARKER_START/{p=1;next} /$MARKER_END/{p=0;next} !p" "$TARGET_RC" > "${TARGET_RC}.tmp"
    mv "${TARGET_RC}.tmp" "$TARGET_RC"
else
    echo -e "${BLUE}[2/3]${RESET} No se detectaron bloques previos. Procediendo a la inserción limpia..."
fi

echo -e "${BLUE}[3/3]${RESET} Escribiendo nuevas directivas de optimización..."

{
echo "$MARKER_START"
echo "# Configuración de $SHELL_NAME - Generado por SHELL4ME"

for ((i=0; i<${#OPCIONES[@]}; i+=3)); do
    opt="${OPCIONES[i]}"
    desc="${OPCIONES[i+1]}"
    state="${OPCIONES[i+2]}"
    
    if [ "$state" == "on" ]; then
        echo -e "\n# [ACTIVO] $desc"
        if [ "$SHELL_NAME" == "Zsh" ]; then
            echo "setopt $opt 2>/dev/null || true"
        else
            echo "shopt -s $opt 2>/dev/null || true"
        fi
    else
        echo -e "\n# [INACTIVO] $desc"
        if [ "$SHELL_NAME" == "Zsh" ]; then
            echo "unsetopt $opt 2>/dev/null || true"
        else
            echo "shopt -u $opt 2>/dev/null || true"
        fi
    fi
done

echo -e "\n$MARKER_END"
} >> "$TARGET_RC"

echo -e "\n${GREEN}███████╗██╗  ██╗██╗████████╗██████╗ ░▒▓ S H E L L   4   M E ▓▒░${RESET}"
echo -e "${GREEN}██╔════╝╚██╗██╔╝██║╚══██╔══╝██╔══██╗ ¡Modificaciones guardadas con éxito!${RESET}"
echo -e "${GREEN}█████╗   ╚███╔╝ ██║   ██║   ██║  ██║ Archivo modificado: ${YELLOW}$TARGET_RC${RESET}"
echo -e "${GREEN}██╔══╝   ██╔██╗ ██║   ██║   ██║  ██║ Respaldo intacto en: ${YELLOW}$BACKUP_FILE${RESET}"
echo -e "${GREEN}███████╗██╔╝ ██╗██║   ██║   ██████╔╝${RESET}"
echo -e "${GREEN}╚══════╝╚═╝  ╚═╝╚═╝   ╚═╝   ╚═════╝ ${RESET}"
echo -e "\nPara aplicar los cambios ahora mismo sin reiniciar la terminal, ejecuta:"
echo -e "➔ ${CYAN}source $TARGET_RC${RESET}\n"

echo -e "\e[?25h" # Restaurar cursor al finalizar con éxito