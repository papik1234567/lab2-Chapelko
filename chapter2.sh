
#!/bin/bash

correct=0
total=5
points=0

ask_answer() {
    while true; do
        read -r -p "Ваш ответ (1-5): " answer
        if [[ "$answer" =~ ^[1-5]$ ]]; then
            return
        fi
        echo "Введите число от 1 до 5."
    done
}

check_fragment() {
    local number="$1"
    local description="$2"
    local code="$3"
    local correct_answer="$4"

    echo
    echo "Фрагмент $number из $total"
    echo "$description"
    echo
    echo "$code"
    echo
    echo "Выберите тип дефекта:"
    echo "1. Неинициализированная переменная"
    echo "2. Мёртвое присваивание"
    echo "3. Утечка ресурса"
    echo "4. Магическое число"
    echo "5. Отсутствие обработки ошибок"

    ask_answer

    if [ "$answer" -eq "$correct_answer" ]; then
        echo "Верно! +2 очка."
        correct=$((correct + 1))
        points=$((points + 2))
    else
        echo "Неверно. Правильный ответ: $correct_answer. -1 очко."
        points=$((points - 1))
    fi
}

clear

echo "======================================"
echo "       МОДУЛЬ ФОРМАЛИЗАЦИИ РЕВЬЮ"
echo "======================================"
echo "Определите дефект в каждом фрагменте кода."
echo

check_fragment 1 "Проверка лицензии" \
'def check_license(config):
    if license_key:
        return validate(license_key)
    license_key = config.get("license")' 1

check_fragment 2 "Обработка результата сканирования" \
'def scan_file(path):
    result = "clean"
    result = antivirus_scan(path)
    return result' 2

check_fragment 3 "Чтение журнала" \
'def read_log(path):
    log_file = open(path, "r")
    data = log_file.read()
    return data' 3

check_fragment 4 "Проверка оценки" \
'def is_valid_score(score):
    return score > 87' 4

check_fragment 5 "Получение данных сервера" \
'def get_license_status(client, url):
    response = client.get(url)
    data = response.json()
    return data' 5

percentage=$((correct * 100 / total))

if [ "$percentage" -ge 80 ]; then
    level="Senior Reviewer"
elif [ "$percentage" -ge 50 ]; then
    level="Middle Reviewer"
else
    level="Junior Reviewer"
fi

echo
echo "======================================"
echo "             ИТОГИ РЕВЬЮ"
echo "======================================"
echo "Просмотрено фрагментов: $total"
echo "Правильных ответов: $correct"
echo "Точность: $percentage%"
echo "Итоговые баллы: $points"
echo "Уровень: $level"
echo "======================================"

read -r -p "Нажмите Enter для завершения..."
