#!/bin/bash

# Функция для вывода меню
show_menu() {
    clear
    echo "####################################"
    echo "#         TON OS (Простая)         #"
    echo "####################################"
    echo "1. Показать текущую дату"
    echo "2. Показать список файлов в директории"
    echo "3. Выполнить команду echo"
    echo "4. Калькулятор"
    echo "5. Создать файл"
    echo "6. Удалить файл"
    echo "7. Переместить файл"
    echo "8. Просмотреть содержимое keyostonos.md"
    echo "9. Вывести дерево файлов"
    echo "10. Скачать файл (wget)"
    echo "11. Перейти на сайт TON OS"
    echo "12. Создать директорию programs"
    echo "13. Командная строка"
    echo "14. Магазин Пакетов"
    echo "15. Просмотр Программ"
    echo "16. Запустить программу"
    echo "17. Выйти"
    echo "------------------------------------"
    echo "Введите номер опции:"
}

# Функция для отображения текущей даты
show_date() {
    date
}

# Функция для отображения списка файлов в директории
show_files() {
    read -p "Введите путь к директории: " directory
    if [ -d "$directory" ]; then
        ls -l "$directory"
    else
        echo "Директория не найдена."
    fi
}

# Функция для выполнения команды echo
run_echo() {
    read -p "Введите текст для echo: " text
    echo "$text"
}

# Функция для калькулятора
run_calculator() {
    read -p "Введите выражение (например, 2+2): " expression

    # Проверка наличия bc
    if ! command -v bc &> /dev/null; then
        echo "bc не установлен. Устанавливаю..."
        sudo apt install bc  # или pkg install bc, в зависимости от вашей системы
        if [ $? -ne 0 ]; then
            echo "Не удалось установить bc. Пожалуйста, установите его вручную."
            return
        fi
    fi

    # Выполнение вычисления с помощью bc
    result=$(echo "$expression" | bc -l)

    echo "Результат: $result"
}

# Функция для создания файла
create_file() {
    read -p "Введите имя файла: " filename
    touch "$filename"
    if [ $? -eq 0 ]; then
        echo "Файл $filename создан."
    else
        echo "Не удалось создать файл $filename."
    fi
}

# Функция для удаления файла
delete_file() {
    read -p "Введите имя файла для удаления: " filename
    if [ -f "$filename" ]; then
        read -p "Вы уверены, что хотите удалить файл $filename? (y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
            rm "$filename"
            if [ $? -eq 0 ]; then
                echo "Файл $filename удален."
            else
                echo "Не удалось удалить файл $filename."
            fi
        else
            echo "Удаление отменено."
        fi
    else
        echo "Файл $filename не найден."
    fi
}

# Функция для перемещения файла
move_file() {
    read -p "Введите имя файла для перемещения: " source
    read -p "Введите путь назначения: " destination
    if [ -f "$source" ]; then
        mv "$source" "$destination"
        if [ $? -eq 0 ]; then
            echo "Файл $source перемещен в $destination."
        else
            echo "Не удалось переместить файл $source."
        fi
    else
        echo "Файл $source не найден."
    fi
}

# Функция для просмотра содержимого файла
view_file() {
    if [ -f "keyostonos.md" ]; then
        less "keyostonos.md"
        echo ""
    else
        echo "Ошибка 404ts: Файл keyostonos.md не найден."
    fi
}

# Функция для вывода дерева файлов
tree_view() {
    read -p "Введите путь к директории: " directory
    if [ -d "$directory" ]; then
        tree "$directory"
    else
        echo "Директория не найдена."
    fi
}

# Функция для скачивания файла с помощью wget
download_file() {
    read -p "Введите URL файла для скачивания: " url
    read -p "Введите имя файла для сохранения: " filename

    # Проверка наличия wget
    if ! command -v wget &> /dev/null; then
        echo "wget не установлен. Пытаюсь установить..."
        pkg install wget
        if [ $? -eq 0 ]; then
            echo "wget успешно установлен."
        else
            echo "Не удалось установить wget. Пожалуйста, установите его вручную."
            return
        fi
    fi

    wget -O "$filename" "$url"
    if [ $? -eq 0 ]; then
        echo "Файл $url успешно скачан и сохранен как $filename."
    else
        echo "Не удалось скачать файл $url."
    fi
}

# Функция для запуска командной строки
run_command_line() {
    while true; do
        read -p "TON OS $ " command
        command_parts=($command)
        action="${command_parts[0]}"
        args=("${command_parts[@]:1}")

        case "$action" in
            "shutdown-tos")
                echo "Выход из TON OS..."
                break
                ;;
            "open")
                if [ -n "${args[0]}" ]; then
                    if [ -f "${args[0]}" ]; then
                        less "${args[0]}"
                    else
                        echo "Файл ${args[0]} не найден."
                    fi
                else
                    echo "Укажите имя файла для открытия."
                fi
                ;;
            "info-tos")
                echo "Ваша версия: 1.0.3"
                echo "Издатель: Mogd"
                echo "Издание: pro"
                ;;
            "/On")
                echo "hello world"
                ;;
            "exit")
                break
                ;;
            "hel")
                echo "Доступные команды:
                shutdown-tos - выходит из OS
                open - открывает файл
                info-tos - информация о ОС
                /On - пишит hello world
                hel - показывает все доступные команды
                cls - очищает экран командной строки
                ping - проверяет соединение с узлом
                ipconfig - показывает конфигурации сети
                nslookup - отображает IP-адрес сайта
                ftp - Открывает FTP-клиент
                exit - закрывает текущую сессию"
                ;;
            "cls")
                clear
                ;;
            "ping")
                ping "${args[0]}"
                ;;
            "ipconfig")
                if command -v ipconfig &> /dev/null; then
                    ipconfig
                else
                    echo "Команда ipconfig не найдена. Установите net-tools."
                fi
                ;;
            "nslookup")
                if command -v nslookup &> /dev/null; then
                    nslookup "${args[0]}"
                else
                    echo "Команда nslookup не найдена. Установите dnsutils."
                fi
                ;;
            "ftp")
                if command -v ftp &> /dev/null; then
                    ftp "${args[0]}"
                else
                    echo "Команда ftp не найдена. Установите ftp."
                fi
                ;;
            *)
                echo "Неизвестная команда: $action"
                ;;
        esac
    done
}

# Функция для перехода на сайт TON OS
goto_ton_os() {
    echo "Переход на сайт TON OS (ton-os.tiiny.site)..."
    echo "Вы будете перенаправлены в ваш веб-браузер."
    xdg-open "ton-os.tiiny.site" & 
}

# Функция для отображения списка доступных пакетов
show_packages() {
    echo "Доступные пакеты для установки:"
    echo "  1. open-su"
    echo "  2. chromium"
    echo "  3. mc"
    echo "  4. vim"
    echo "  5. nano"
}

# Функция для установки пакета
install_package() {
    read -p "Введите название пакета для установки: " package
    case "$package" in
        "open-su")
            echo "Выполняется установка open-su..."
            create_program_link "open-su"
            echo "Установка завершена."
            ;;
        "chromium")
            echo "Выполняется установка chromium..."
            create_program_link "chromium"
            echo "Установка завершена."
            ;;
        "mc")
            echo "Выполняется установка mc..."
            create_program_link "mc"
            echo "Установка завершена."
            ;;
        "vim")
            echo "Выполняется установка vim..."
            create_program_link "vim"
            echo "Установка завершена."
            ;;
        "nano")
            echo "Выполняется установка nano..."
            create_program_link "nano"
            echo "Установка завершена."
            ;;
        *)
            echo "Пакет $package не найден."
            ;;
    esac
}

# Функция для создания каталога programs
create_programs_directory() {
    if [ ! -d "programs" ]; then
        mkdir programs
        if [ $? -eq 0 ]; then
            echo "Создана директория programs."
        else
            echo "Не удалось создать директорию programs."
        fi
    else
        echo "Директория programs уже существует."
    fi
}

# Функция для вывода списка программ
show_programs() {
    if [ -d "programs" ]; then
        echo "Список программ в директории programs:"
        ls -l programs
    else
        echo "Директория programs не существует. Сначала создайте ее."
    fi
}

# Функция для создания ссылки на программу (только имитация)
create_program_link() {
    program_name=$1
    if [ ! -d "programs" ]; then
        create_programs_directory
    fi
    touch "programs/$program_name.sh" # Создаем .sh файл
    echo "Создан ярлык для $program_name.sh в директории programs."
}

# Функция для запуска программы
run_program() {
    read -p "Введите имя программы для запуска: " program_name

    if [ -f "programs/$program_name.sh" ]; then
        bash "programs/$program_name.sh"
        echo ""
        echo "Нажмите Enter для продолжения..."
        read
    else
        echo "Программа $program_name не найдена."
    fi
}

# Функция для вывода дерева файлов
tree_view() {
    read -p "Введите путь к директории: " directory
    if [ -d "$directory" ]; then
        tree "$directory"
    else
        echo "Директория не найдена."
    fi
}

# Функция для скачивания файла с помощью wget
download_file() {
    read -p "Введите URL файла для скачивания: " url
    read -p "Введите имя файла для сохранения: " filename

    # Проверка наличия wget
    if ! command -v wget &> /dev/null; then
        echo "wget не установлен. Пытаюсь установить..."
        pkg install wget
        if [ $? -eq 0 ]; then
            echo "wget успешно установлен."
        else
            echo "Не удалось установить wget. Пожалуйста, установите его вручную."
            return
        fi
    fi

    wget -O "$filename" "$url"
    if [ $? -eq 0 ]; then
        echo "Файл $url успешно скачан и сохранен как $filename."
    else
        echo "Не удалось скачать файл $url."
    fi
}

# Функция для запуска командной строки
run_command_line() {
    while true; do
        read -p "TON OS $ " command
        command_parts=($command)
        action="${command_parts[0]}"
        args=("${command_parts[@]:1}")

        case "$action" in
            "shutdown-tos")
                echo "Выход из TON OS..."
                break
                ;;
            "open")
                if [ -n "${args[0]}" ]; then
                    if [ -f "${args[0]}" ]; then
                        less "${args[0]}"
                    else
                        echo "Файл ${args[0]} не найден."
                    fi
                else
                    echo "Укажите имя файла для открытия."
                fi
                ;;
            "info-tos")
                echo "Ваша версия: 1.0.3"
                echo "Издатель: Mogd"
                echo "Издание: pro"
                ;;
            "/On")
                echo "hello world"
                ;;
            "exit")
                break
                ;;
            "hel")
                echo "Доступные команды:
                shutdown-tos - выходит из OS
                open - открывает файл
                info-tos - информация о ОС
                /On - пишит hello world
                hel - показывает все доступные команды
                cls - очищает экран командной строки
                ping - проверяет соединение с узлом
                ipconfig - показывает конфигурации сети
                nslookup - отображает IP-адрес сайта
                ftp - Открывает FTP-клиент
                exit - закрывает текущую сессию"
                ;;
            "cls")
                clear
                ;;
            "ping")
                ping "${args[0]}"
                ;;
            "ipconfig")
                if command -v ipconfig &> /dev/null; then
                    ipconfig
                else
                    echo "Команда ipconfig не найдена. Установите net-tools."
                fi
                ;;
            "nslookup")
                if command -v nslookup &> /dev/null; then
                    nslookup "${args[0]}"
                else
                    echo "Команда nslookup не найдена. Установите dnsutils."
                fi
                ;;
            "ftp")
                if command -v ftp &> /dev/null; then
                    ftp "${args[0]}"
                else
                    echo "Команда ftp не найдена. Установите ftp."
                fi
                ;;
            *)
                echo "Неизвестная команда: $action"
                ;;
        esac
    done
}

# Функция для перехода на сайт TON OS
goto_ton_os() {
    echo "Переход на сайт TON OS (ton-os.tiiny.site)..."
    echo "Вы будете перенаправлены в ваш веб-браузер."
    xdg-open "ton-os.tiiny.site" & 
}

# Основной цикл программы
while true; do
    show_menu
    read choice

    case $choice in
        1)
            show_date
            ;;
        2)
            show_files
            ;;
        3)
            run_echo
            ;;
        4)
            run_calculator
            ;;
        5)
            create_file
            ;;
        6)
            delete_file
            ;;
        7)
            move_file
            ;;
        8)
            view_file
            ;;
        9)
            tree_view
            ;;
        10)
            download_file
            ;;
        11)
            goto_ton_os
            ;;
        12)
            create_programs_directory
            ;;
        13)
            run_command_line
            ;;
        14)
            show_packages
            install_package
            ;;
        15)
            show_programs
            ;;
        16)
            run_program
            ;;
        17)
            echo "Завершение работы..."
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