#/bin/bash

# Функция форматирует строку в поле с заданной минимальной длинной
# Если строка меньше поля, то добпвляются пробелы справа или слева строки

# Это "костыль" для решения проблемы с форматированием строк UTF-8 в printf "%Ns"
# printf по разному выравнивает строки с разным числом байт на символ
#     printf "latin string   : %5s\n" "qwe"
#     latin string   :   qwe
#     printf "cyrillic string: %5s\n" "йцу"
#     cyrillic string: йцу

# Функция принимает два позиционных параметра
# $1 -- строка
# $2 -- длина поля
# Если ширина поля отрицательная, и длина строки меньше поля, то добавляем пробелы слева
# Если ширина поля положительная, и длина строки меньше поля, то добавляем пробелы справа

# Пример вызова
#     prntfUTF "Привет мир" 10
#     prntfUTF "Привет мир" -10
# Переменные тоже нужно заключать в кавычки
#     v="Привет мир"
#     prntfUTF "$v" 10
# Пример с `printf` 
#     printf "The resolution $(prntfUTF "проблемы" 10) с UTF\n"
# Передача масива пока через цикл который можно обернуть в отдельную функцию
# И пока только из одиночных элементов
#     arr=("П" "П" "П")
#     for var in ${arr[*]};do prntfUTF '$var' -5;done

# GPLv3 2021 Астапчик Михаил

prntfUTF(){
local spaces=""
# Если ширина поля отрицательная
if [[ $2 = *[[:digit:]]* ]] && [[ $2 -lt 0 ]]
then
  # И если длина строки меньше поля,
  # то добавляем пробелы слева строки
  if [[ ${#1} -lt $(($2 * -1)) ]]
  then
    for((i=0;i<$(($2 * -1 - ${#1}));i++))
    do
      spaces+=" "
    done
    echo -n "$spaces$1"
    else
    echo -n "$1"
  fi
# Если ширина поля положительная
elif [[ $2 = *[[:digit:]]* ]] && [[ $2 -gt 0 ]]
then
  # И если длина строки меньше поля,
  # то добавляем пробелы справа строки
   if [[ ${#1} -lt $2 ]]
  then
    for((i=0;i<$(($2 - ${#1}));i++))
    do
      spaces+=" "
    done
    echo -n "$1$spaces"
    else
    echo -n "$1"
  fi
else
echo -n "$1"
fi
}

# ############################
# Заготовка для формата строки в поле с максимальной длинной
# echo "${1:0:$(($2 * -1))}$spaces"
# echo "$spaces${1:0:$2}"
# ############################

# Примеры использования
# 1
cyrUTF="привет мир!"
latUTF="hello world"
prntfUTF "$cyrUTF" -16
prntfUTF "$cyrUTF" 16
prntfUTF "$latUTF" -16
prntfUTF "$latUTF" 16
prntfUTF "$cyrUTF"

# 2
printf "The resolution problеm %10s UTF in printf\n" "строки"
printf "The resolution problеm %-10s UTF in printf\n" "строки"
printf "The resolution problеm $(prntfUTF "строки" 10) UTF in printf\n"
printf "The resolution problеm $(prntfUTF "строки" -10) UTF in printf\n"

