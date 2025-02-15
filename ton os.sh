
#!/bin/bash

# Function to display the menu
show_menu() {
    clear
    echo "####################################"
    echo "#         TON OS (Installer)         #"
    echo "####################################"
    echo "Выберите язык для установки TON OS:"
    echo "1. Русский"
    echo "2. English"
    echo "------------------------------------"
    echo "Введите номер опции:"
}

# Функция для загрузки и запуска скрипта установки
install_language() {
    local choice=$1
    local url=""
    local filename="ton_os_installer.sh"

    case $choice in
        1)
            url="https://raw.githubusercontent.com/mogd-Kali/TON-OS/refs/heads/main/ru.sh"
            ;;
        2)
            url="https://raw.githubusercontent.com/mogd-Kali/TON-OS/refs/heads/main/eng.sh"
            ;;
        *)
            echo "Неизвестная опция. Установка прервана."
            exit 1
            ;;
    esac

    # Проверка наличия wget
    if ! command -v wget &> /dev/null; then
        echo "wget не установлен. Пытаюсь установить..."
        pkg install wget
        if [ $? -eq 0 ]; then
            echo "wget успешно установлен."
        else
            echo "Не удалось установить wget. Пожалуйста, установите его вручную."
            exit 1
        fi
    fi

    # Загрузка скрипта установки
    wget -O "$filename" "$url"
    if [ $? -eq 0 ]; then
        echo "Скрипт установки успешно скачан."
    else
        echo "Не удалось скачать скрипт установки."
        exit 1
    fi

    # Запуск скрипта установки
    bash "$filename"
    if [ $? -eq 0 ]; then
        echo "Установка завершена."
    else
        echo "Во время установки произошла ошибка."
    fi

    # Удаление скрипта установки после завершения
    rm "$filename"
    echo "Скрипт установки удален."
}

# Основной цикл программы
while true; do
    show_menu
    read choice

    case $choice in
        1)
            install_language 1  # Русский
            break
            ;;
        2)
            install_language 2  # English
            break
            ;;
        *)
            echo "Неизвестная опция. Попробуйте еще раз."
            ;;
    esac

    echo "Нажмите Enter, чтобы продолжить..."
    read
done

echo "Программа завершена."
exit 0
