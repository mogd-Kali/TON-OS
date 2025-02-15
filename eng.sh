#!/bin/bash

# Function to display the menu
show_menu() {
    clear
    echo "####################################"
    echo "#         TON OS (Simple)          #"
    echo "####################################"
    echo "1. Show current date"
    echo "2. List files in directory"
    echo "3. Run echo command"
    echo "4. Calculator"
    echo "5. Create file"
    echo "6. Delete file"
    echo "7. Move file"
    echo "8. View keyostonos.md content"
    echo "9. Display file tree"
    echo "10. Download file (wget)"
    echo "11. Go to TON OS website"
    echo "12. Create programs directory"
    echo "13. Command line"
    echo "14. Package Store"
    echo "15. View Programs"
    echo "16. Run Program"
    echo "17. Exit"
    echo "------------------------------------"
    echo "Enter an option number:"
}

# Function to display the current date
show_date() {
    date
}

# Function to display the list of files in the directory
show_files() {
    read -p "Enter directory path: " directory
    if [ -d "$directory" ]; then
        ls -l "$directory"
    else
        echo "Directory not found."
    fi
}

# Function to run the echo command
run_echo() {
    read -p "Enter text for echo: " text
    echo "$text"
}

# Function for calculator
run_calculator() {
    read -p "Enter expression (e.g., 2+2): " expression

    # Security check to avoid running arbitrary commands
  

    # Perform the calculation using bc
    result=$(echo "$expression" | bc -l)

    echo "Result: $result"
}

# Function to create a file
create_file() {
    read -p "Enter filename: " filename
    touch "$filename"
    if [ $? -eq 0 ]; then
        echo "File $filename created."
    else
        echo "Failed to create file $filename."
    fi
}

# Function to delete a file
delete_file() {
    read -p "Enter filename to delete: " filename
    if [ -f "$filename" ]; then
        read -p "Are you sure you want to delete file $filename? (y/n): " confirm
        if [[ "$confirm" == "y" ]]; then
            rm "$filename"
            if [ $? -eq 0 ]; then
                echo "File $filename deleted."
            else
                echo "Failed to delete file $filename."
            fi
        else
            echo "Deletion cancelled."
        fi
    else
        echo "File $filename not found."
    fi
}

# Function to move a file
move_file() {
    read -p "Enter filename to move: " source
    read -p "Enter destination path: " destination
    if [ -f "$source" ]; then
        mv "$source" "$destination"
        if [ $? -eq 0 ]; then
            echo "File $source moved to $destination."
        else
            echo "Failed to move file $source."
        fi
    else
        echo "File $source not found."
    fi
}

# Function to view the contents of a file
view_file() {
    if [ -f "keyostonos.md" ]; then
        less "keyostonos.md"
        echo ""
    else
        echo "Error 404ts: File keyostonos.md not found."
    fi
}

# Function to display the file tree
tree_view() {
    read -p "Enter path to directory: " directory
    if [ -d "$directory" ]; then
        tree "$directory"
    else
        echo "Directory not found."
    fi
}

# Function to download a file using wget
download_file() {
    read -p "Enter URL of file to download: " url
    read -p "Enter filename to save as: " filename

    # Проверка наличия wget
    if ! command -v wget &> /dev/null; then
        echo "wget not found. Attempting installation..."
        pkg install wget
        if [ $? -eq 0 ]; then
            echo "wget installed successfully."
        else
            echo "Failed to install wget. Please install it manually."
            return
        fi
    fi

    wget -O "$filename" "$url"
    if [ $? -eq 0 ]; then
        echo "File $url downloaded successfully and saved as $filename."
    else
        echo "Failed to download file $url."
    fi
}

# Function to run the command line
run_command_line() {
    while true; do
        read -p "TON OS $ " command
        command_parts=($command)
        action="${command_parts[0]}"
        args=("${command_parts[@]:1}")

        case "$action" in
            "shutdown-tos")
                echo "Exiting TON OS..."
                break
                ;;
            "open")
                if [ -n "${args[0]}" ]; then
                    if [ -f "${args[0]}" ]; then
                        less "${args[0]}"
                    else
                        echo "File ${args[0]} not found."
                    fi
                else
                    echo "Enter the filename to open."
                fi
                ;;
            "info-tos")
                echo "Version: 1.0.3"
                echo "Publisher: Mogd"
                ;;
            "/On")
                echo "hello world"
                ;;
            "exit")
                break
                ;;
            "hel")
                echo "Available commands:
                shutdown-tos - exits the OS
                open - opens a file
                info-tos - displays OS information
                /On - prints hello world
                hel - shows all available commands
                cls - clears the command line screen
                ping - checks the connection to the node
                ipconfig - shows network configurations
                nslookup - displays the IP address of the site
                ftp - Opens the FTP client
                exit - closes the current session"
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
                    echo "ipconfig command not found. Install net-tools."
                fi
                ;;
            "nslookup")
                if command -v nslookup &> /dev/null; then
                    nslookup "${args[0]}"
                else
                    echo "nslookup command not found. Install dnsutils."
                fi
                ;;
            "ftp")
                if command -v ftp &> /dev/null; then
                    ftp "${args[0]}"
                else
                    echo "ftp command not found. Install ftp."
                fi
                ;;
            *)
                echo "Unknown command: $action"
                ;;
        esac
    done
}

# Функция для перехода на сайт TON OS
goto_ton_os() {
    echo "Going to TON OS website (ton-os.tiiny.site)..."
    echo "You will be redirected to your web browser."
    xdg-open "ton-os.tiiny.site" & 
}

# Функция для вывода списка доступных пакетов
show_packages() {
    echo "Available packages to install:"
    echo "  1. open-su"
    echo "  2. chromium"
    echo "  3. mc"
    echo "  4. vim"
    echo "  5. nano"
}

# Функция для установки пакета
install_package() {
    read -p "Enter the name of the package to install: " package
    case "$package" in
        "open-su")
            echo "Installing open-su..."
            create_program_link "open-su"
            echo "Installation complete."
            ;;
        "chromium")
            echo "Installing chromium..."
            create_program_link "chromium"
            echo "Installation complete."
            ;;
        "mc")
            echo "Installing mc..."
            create_program_link "mc"
            echo "Installation complete."
            ;;
        "vim")
            echo "Installing vim..."
            create_program_link "vim"
            echo "Installation complete."
            ;;
        "nano")
            echo "Installing nano..."
            create_program_link "nano"
            echo "Installation complete."
            ;;
        *)
            echo "Package $package not found."
            ;;
    esac
}

# Функция для создания каталога programs
create_programs_directory() {
    if [ ! -d "programs" ]; then
        mkdir programs
        if [ $? -eq 0 ]; then
            echo "Created directory programs."
        else
            echo "Failed to create directory programs."
        fi
    else
        echo "Directory programs already exists."
    fi
}

# Функция для вывода списка программ
show_programs() {
    if [ -d "programs" ]; then
        echo "List of programs in directory programs:"
        ls -l programs
    else
        echo "Directory programs does not exist. Create it first."
    fi
}

# Функция для создания ссылки на программу (только имитация)
create_program_link() {
    program_name=$1
    if [ ! -d "programs" ]; then
        create_programs_directory
    fi
    touch "programs/$program_name.sh" # Создаем .sh файл
    echo "Created shortcut for $program_name.sh in directory programs."
}

# Функция для запуска программы
run_program() {
    read -p "Enter the name of the program to run: " program_name

    if [ -f "programs/$program_name.sh" ]; then
        bash "programs/$program_name.sh"
        echo ""
        echo "Press Enter to continue..."
        read
    else
        echo "Program $program_name not found."
    fi
}

# Функция для вывода дерева файлов
tree_view() {
    read -p "Enter path to directory: " directory
    if [ -d "$directory" ]; then
        tree "$directory"
    else
        echo "Directory not found."
    fi
}

# Функция для скачивания файла с помощью wget
download_file() {
    read -p "Enter file URL to download: " url
    read -p "Enter filename to save as: " filename

    # Проверка наличия wget
    if ! command -v wget &> /dev/null; then
        echo "wget not installed. Attempting to install..."
        pkg install wget
        if [ $? -eq 0 ]; then
            echo "wget installed successfully."
        else
            echo "Failed to install wget. Please install it manually."
            return
        fi
    fi

    wget -O "$filename" "$url"
    if [ $? -eq 0 ]; then
        echo "File $url downloaded and saved as $filename."
    else
        echo "Failed to download file $url."
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
                echo "Exiting TON OS..."
                break
                ;;
            "open")
                if [ -n "${args[0]}" ]; then
                    if [ -f "${args[0]}" ]; then
                        less "${args[0]}"
                    else
                        echo "File ${args[0]} not found."
                    fi
                else
                    echo "Enter the filename to open."
                fi
                ;;
            "info-tos")
                echo "Version: 1.0.3"
                echo "Publisher: Mogd"
                echo "Edition: pro"
                ;;
            "/On")
                echo "hello world"
                ;;
            "exit")
                break
                ;;
            "hel")
                echo "Available commands:
                shutdown-tos - exits the OS
                open - opens a file
                info-tos - displays OS information
                /On - пишит hello world
                hel - shows all available commands
                cls - clears the command line screen
                ping - checks the connection to the node
                ipconfig - shows network configurations
                nslookup - displays the IP address of the site
                ftp - Opens the FTP client
                exit - closes the current session"
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
                    echo "ipconfig command not found. Install net-tools."
                fi
                ;;
            "nslookup")
                if command -v nslookup &> /dev/null; then
                    nslookup "${args[0]}"
                else
                    echo "nslookup command not found. Install dnsutils."
                fi
                ;;
            "ftp")
                if command -v ftp &> /dev/null; then
                    ftp "${args[0]}"
                else
                    echo "ftp command not found. Install ftp."
                fi
                ;;
            *)
                echo "Unknown command: $action"
                ;;
        esac
    done
}

# Функция для перехода на сайт TON OS
goto_ton_os() {
    echo "Going to TON OS website (ton-os.tiiny.site)..."
    echo "You will be redirected to your web browser."
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
            echo "Exiting..."
            break
            ;;
        *)
            echo "Unknown option. Try again."
            ;;
        esac

        echo "Press Enter to continue..."
        read
done

echo "Program completed."
exit 0