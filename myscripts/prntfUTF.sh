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

# GPLv3 2021 Астапчик Михаил

function prntfUTF(){
local words=$1
local spaces=""
# Если ширина поля отрицательная
if [[ $2 = *[[:digit:]]* ]] && [[ $2 -lt 0 ]]
then
  # И если длина строки меньше поля,
  # то добавляем пробелы слева строки
  if [[ ${#words} -lt $(($2 * -1)) ]]
  then
    for((i=0;i<$(($2 * -1 - ${#words}));i++))
    do
      spaces+=" "
    done
    echo -n "$spaces$words"
    else
    echo -n "$words"
  fi
# Если ширина поля положительная
elif [[ $2 = *[[:digit:]]* ]] && [[ $2 -gt 0 ]]
then
  # И если длина строки меньше поля,
  # то добавляем пробелы справа строки
   if [[ ${#words} -lt $2 ]]
  then
    for((i=0;i<$(($2 - ${#words}));i++))
    do
      spaces+=" "
    done
    echo -n "$words$spaces"
    else
    echo -n "$words"
  fi
else
echo -n "$words"
fi
}


# Функция для передачи масива в функцию `prntfUTF`
# Тоже "костыль", в дальнейшем возможно объединение с prntfUTF
# Принимает лва аргумента
# $1 -- имя массива без кавычек и "$"
# $2 -- длина поля
# Например
#    arrow=("привет мир" "hello world")
#    prArrUTF arrow 16

# GPLv3 2021 Астапчик Михаил

function prArrUTF(){
local -n words=$1
for w in "${words[@]}"
do
prntfUTF "$w" $2
done
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
cyrUTFarr=("привет мир!" "hello world")

prntfUTF "$cyrUTF" -16; printf "\n"
prntfUTF "$cyrUTF" 16;  printf "\n"
prntfUTF "$latUTF" -16; printf "\n"
prntfUTF "$latUTF" 16;  printf "\n"
prntfUTF "$cyrUTF";     printf "\n"

echo "======="
prArrUTF cyrUTFarr 16;  printf "\n"
prArrUTF cyrUTFarr -16; printf "\n"
echo "======="

# 2
printf "The resolution problеm %10s UTF in printf\n" "строки"
printf "The resolution problеm %-10s UTF in printf\n" "строки"
printf "The resolution problеm $(prntfUTF "строки" 10) UTF in printf\n"
printf "The resolution problеm $(prntfUTF "строки" -10) UTF in printf\n"
