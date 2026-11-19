
#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPORT="$SCRIPT_DIR/report.txt"

run_chapter1() {
    bash "$SCRIPT_DIR/chapter1.sh"
}

run_chapter2() {
    bash "$SCRIPT_DIR/chapter2.sh"
}

run_chapter3() {
    bash "$SCRIPT_DIR/chapter3.sh"
}

run_all() {
    local temp_dir
    temp_dir="$(mktemp -d)"

    echo "Запуск всех модулей."
    echo

    echo "Запуск модуля 1..."
    bash "$SCRIPT_DIR/chapter1.sh" | tee "$temp_dir/chapter1.txt"

    echo
    echo "Запуск модуля 2..."
    bash "$SCRIPT_DIR/chapter2.sh" | tee "$temp_dir/chapter2.txt"

    echo
    echo "Запуск модуля 3..."
    bash "$SCRIPT_DIR/chapter3.sh" | tee "$temp_dir/chapter3.txt"

    {
        echo "=========================================="
        echo "       ОТЧЁТ ИНТЕГРИРОВАННОЙ СИСТЕМЫ"
        echo "=========================================="
        echo "Дата формирования: $(date)"
        echo

        echo "МОДУЛЬ 1. ВЫБОР ТЕХНОЛОГИЙ"
        echo "Результаты выполнения:"
        cat "$temp_dir/chapter1.txt"
        echo

        echo "МОДУЛЬ 2. ФОРМАЛИЗАЦИЯ РЕВЬЮ"
        echo "Результаты выполнения:"
        cat "$temp_dir/chapter2.txt"
        echo

        echo "МОДУЛЬ 3. СРАВНИТЕЛЬНЫЙ АНАЛИЗ WSM"
        echo "Результаты выполнения:"
        cat "$temp_dir/chapter3.txt"
        echo

        echo "=========================================="
        echo "       КОНЕЦ ИТОГОВОГО ОТЧЁТА"
        echo "=========================================="
    } > "$REPORT"

    rm -rf "$temp_dir"

    echo
    echo "Все модули выполнены."
    echo "Итоговый отчёт сохранён: $REPORT"
}

while true; do
    clear
    echo "======================================"
    echo "       ИНТЕГРИРОВАННАЯ СИСТЕМА"
    echo "======================================"
    echo "1. Выбор технологий"
    echo "2. Инспекция кода"
    echo "3. Сравнительный анализ WSM"
    echo "4. Запустить все модули последовательно"
    echo "5. Выход"
    echo "======================================"

    read -r -p "Выберите действие: " choice

    case "$choice" in
        1)
            run_chapter1
            ;;
        2)
            run_chapter2
            ;;
        3)
            run_chapter3
            ;;
        4)
            run_all
            ;;
        5)
            echo "Завершение работы."
            exit 0
            ;;
        *)
            echo "Неверный пункт меню."
            ;;
    esac

    echo
    read -r -p "Нажмите Enter для возврата в меню..."
done
