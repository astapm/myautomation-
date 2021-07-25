#/bin/bash

# Функция проверки целого числа в заданном диапазоне целых чисел
# принимает три позиционных аргумента
# $1 -- проверяемое число
# $2 -- начало диапазона
# $3 -- конец диапазона

# Пример вызова
#     checkRange 1 2 3

# GPLv3+ 2021

function checkRange () {
if [[ $1 = *[[:digit:]]* ]] && [[ $1 != *[[:space:]]* ]]
then
  if [[ $2 = *[[:digit:]]* ]] && [[ $2 != *[[:space:]]* ]]
  then
    if [[ $3 = *[[:digit:]]* ]] && [[ $3 != *[[:space:]]* ]]
    then
      if [[ $1 -ge $2 ]] && [[ $1 -le $3 ]]
      then
        return 0
      else
        return 1
      fi
    else
      return 1
    fi
  else
  return 1
  fi
else
  return 1    
fi
}


# Примеры испльзования

if checkRange 2 1 9
then
  echo "in range"
else
  echo "not in range"
fi

if checkRange 2 6 9
then
  echo "in range"
else
  echo "not in range"
fi

if checkRange 2 1 9
then
  echo "in range"
else
  echo "not in range"
fi
