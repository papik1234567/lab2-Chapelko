
#!/bin/bash

score_kaspersky=0
score_eset=0
score_drweb=0

ask_choice() {
    local prompt="$1"
    local options="$2"
    local value

    while true; do
        read -r -p "$prompt" value

        case "$value" in
            $options)
                ANSWER="$value"
                return 0
                ;;
            *)
                echo "Ошибка! Выберите один из предложенных вариантов."
                ;;
        esac
    done
}

echo "=========================================="
echo "   МОДУЛЬ ВЫБОРА АНТИВИРУСНОГО РЕШЕНИЯ"
echo "=========================================="
echo
echo "Организация: офис на 50 рабочих станций."
echo

echo "1. Сколько рабочих станций необходимо защитить?"
echo "1. До 10"
echo "2. От 11 до 50"
echo "3. Более 50"
ask_choice "Ваш ответ: " "[123]"
scale=$ANSWER

case "$scale" in
    1)
        score_kaspersky=$((score_kaspersky + 5))
        score_eset=$((score_eset + 5))
        score_drweb=$((score_drweb + 5))
        ;;
    2)
        score_kaspersky=$((score_kaspersky + 15))
        score_eset=$((score_eset + 12))
        score_drweb=$((score_drweb + 10))
        ;;
    3)
        score_kaspersky=$((score_kaspersky + 15))
        score_eset=$((score_eset + 15))
        score_drweb=$((score_drweb + 15))
        ;;
esac

echo
echo "2. Требуется ли централизованное управление?"
echo "1. Да, обязательно"
echo "2. Нет"
ask_choice "Ваш ответ: " "[12]"
management=$ANSWER

case "$management" in
    1)
        score_kaspersky=$((score_kaspersky + 15))
        score_eset=$((score_eset + 12))
        score_drweb=$((score_drweb + 10))
        ;;
    2)
        score_kaspersky=$((score_kaspersky + 5))
        score_eset=$((score_eset + 5))
        score_drweb=$((score_drweb + 5))
        ;;
esac

echo
echo "3. Насколько ограничен бюджет организации?"
echo "1. Сильно ограничен"
echo "2. Средний бюджет"
echo "3. Бюджет не является главным ограничением"
ask_choice "Ваш ответ: " "[123]"
budget=$ANSWER

case "$budget" in
    1)
        score_kaspersky=$((score_kaspersky + 8))
        score_eset=$((score_eset + 12))
        score_drweb=$((score_drweb + 15))
        ;;
    2)
        score_kaspersky=$((score_kaspersky + 10))
        score_eset=$((score_eset + 10))
        score_drweb=$((score_drweb + 10))
        ;;
    3)
        score_kaspersky=$((score_kaspersky + 15))
        score_eset=$((score_eset + 10))
        score_drweb=$((score_drweb + 10))
        ;;
esac

echo
echo "4. В какие сроки необходимо внедрить антивирус?"
echo "1. В кратчайшие сроки"
echo "2. В течение нескольких недель"
echo "3. Сроки не ограничены"
ask_choice "Ваш ответ: " "[123]"
deadline=$ANSWER

case "$deadline" in
    1)
        score_kaspersky=$((score_kaspersky + 10))
        score_eset=$((score_eset + 12))
        score_drweb=$((score_drweb + 10))
        ;;
    2)
        score_kaspersky=$((score_kaspersky + 10))
        score_eset=$((score_eset + 10))
        score_drweb=$((score_drweb + 10))
        ;;
    3)
        score_kaspersky=$((score_kaspersky + 12))
        score_eset=$((score_eset + 10))
        score_drweb=$((score_drweb + 10))
        ;;
esac

echo
echo "5. Какова квалификация сотрудников, отвечающих за защиту?"
echo "1. Начальный уровень"
echo "2. Средний уровень"
echo "3. Высокий уровень"
ask_choice "Ваш ответ: " "[123]"
qualification=$ANSWER

case "$qualification" in
    1)
        score_kaspersky=$((score_kaspersky + 10))
        score_eset=$((score_eset + 12))
        score_drweb=$((score_drweb + 10))
        ;;
    2)
        score_kaspersky=$((score_kaspersky + 12))
        score_eset=$((score_eset + 12))
        score_drweb=$((score_drweb + 10))
        ;;
    3)
        score_kaspersky=$((score_kaspersky + 12))
        score_eset=$((score_eset + 10))
        score_drweb=$((score_drweb + 10))
        ;;
esac

max_score=$score_kaspersky

if [ "$score_eset" -gt "$max_score" ]; then
    max_score=$score_eset
fi

if [ "$score_drweb" -gt "$max_score" ]; then
    max_score=$score_drweb
fi

recommendation=""

if [ "$score_kaspersky" -eq "$max_score" ]; then
    recommendation="Kaspersky Endpoint Security"
fi

if [ "$score_eset" -eq "$max_score" ]; then
    if [ -n "$recommendation" ]; then
        recommendation="$recommendation, "
    fi
    recommendation="${recommendation}ESET NOD32"
fi

if [ "$score_drweb" -eq "$max_score" ]; then
    if [ -n "$recommendation" ]; then
        recommendation="$recommendation, "
    fi
    recommendation="${recommendation}Dr.Web"
fi

echo
echo "=========================================="
echo "             ИТОГОВЫЕ РЕЗУЛЬТАТЫ"
echo "=========================================="
echo "Kaspersky Endpoint Security: $score_kaspersky"
echo "ESET NOD32: $score_eset"
echo "Dr.Web: $score_drweb"
echo
echo "Рекомендация: $recommendation"
echo
echo "=========================================="
echo "Модуль завершил работу."
echo "=========================================="

if [ -n "${LAB_RESULTS_FILE:-}" ]; then
    {
        echo "МОДУЛЬ 1 — ВЫБОР АНТИВИРУСА"
        echo "Kaspersky Endpoint Security: $score_kaspersky"
        echo "ESET NOD32: $score_eset"
        echo "Dr.Web: $score_drweb"
        echo "Рекомендация: $recommendation"
        echo
    } >> "$LAB_RESULTS_FILE"
fi
