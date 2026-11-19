 
#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPORT="$SCRIPT_DIR/report.txt"

run_chapter1() {
    if [ -f "$SCRIPT_DIR/chapter1.sh" ]; then
        bash "$SCRIPT_DIR/chapter1.sh"
    else
        echo "Файл chapter1.sh не найден."
    fi
}

run_chapter2() {
    if [ -f "$SCRIPT_DIR/chapter2.sh" ]; then
        bash "$SCRIPT_DIR/chapter2.sh"
    else
        echo "Файл chapter2.sh не найден."
    fi
}

run_chapter3() {
    if [ -f "$SCRIPT_DIR/chapter3.sh" ]; then
        bash "$SCRIPT_DIR/chapter3.sh"
    else
        echo "Файл chapter3.sh не найден."
    fi
}

run_all() {
    echo "Запуск всех модулей."
    echo

    run_chapter1
    run_chapter2
    run_chapter3

    {
        echo "ОТЧЁТ ИНТЕГРИРОВАННОЙ СИСТЕМЫ"
        echo "Дата формирования: $(date)"
        echo
        echo "Результаты выполнения модулей:"
        echo
        echo "Модуль 1: выбор технологического решения."
        echo "Рекомендацию см. в результате выполнения chapter1.sh."
        echo
        echo "Модуль 2: формализация ревью кода."
        echo "Уровень ревьюера см. в результате выполнения chapter2.sh."
        echo
        echo "Модуль 3: сравнительный анализ WSM."
        echo "Победителя см. в результате выполнения chapter3.sh."
    } > "$REPORT"

    echo
    echo "Общий отчёт создан: $REPORT"
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
