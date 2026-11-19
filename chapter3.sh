
#!/bin/bash

clear

echo "=========================================="
echo "       СРАВНИТЕЛЬНЫЙ АНАЛИЗ WSM"
echo "=========================================="
echo "Выбор антивируса для 50 рабочих станций"
echo

criteria=(
    "Централизованное управление"
    "Уровень защиты"
    "Стоимость владения"
    "Удобство администрирования"
)

alternatives=(
    "Kaspersky Endpoint Security"
    "ESET NOD32"
    "Dr.Web"
)

weights=()

echo "Введите веса критериев."
echo "Сумма всех весов должна составлять 100."
echo

while true; do
    sum=0
    weights=()

    for criterion in "${criteria[@]}"; do
        while true; do
            read -r -p "$criterion (0-100): " weight
            if [[ "$weight" =~ ^[0-9]+$ ]] && [ "$weight" -le 100 ]; then
                break
            fi
            echo "Введите целое число от 0 до 100."
        done

        weights+=("$weight")
        sum=$((sum + weight))
    done

    if [ "$sum" -eq 100 ]; then
        break
    fi

    echo
    echo "Сумма весов равна $sum. Необходимо получить 100."
    echo "Повторите ввод."
    echo
done

scores=()

echo
echo "Оцените каждое решение по шкале от 1 до 5."
echo

for alternative in "${alternatives[@]}"; do
    echo
    echo "$alternative"

    for criterion in "${criteria[@]}"; do
        while true; do
            read -r -p "$criterion (1-5): " score
            if [[ "$score" =~ ^[1-5]$ ]]; then
                break
            fi
            echo "Введите число от 1 до 5."
        done

        scores+=("$score")
    done
done

totals=(0 0 0)

for i in "${!alternatives[@]}"; do
    total=0

    for j in "${!criteria[@]}"; do
        index=$((i * ${#criteria[@]} + j))
        total=$((total + weights[j] * scores[index]))
    done

    totals[i]=$total
done

winner=0

for i in "${!alternatives[@]}"; do
    if [ "${totals[i]}" -gt "${totals[winner]}" ]; then
        winner=$i
    fi
done

echo
echo "=========================================="
echo "           МАТРИЦА РЕШЕНИЙ WSM"
echo "=========================================="
printf "%-32s %12s\n" "Антивирус" "Итоговый балл"
echo "------------------------------------------"

for i in "${!alternatives[@]}"; do
    printf "%-32s %12s\n" "${alternatives[i]}" "${totals[i]}"
done

echo "------------------------------------------"
echo "Победитель: ${alternatives[winner]}"
echo "Итоговый балл: ${totals[winner]}"
echo "=========================================="

read -r -p "Нажмите Enter для завершения..."
