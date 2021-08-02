#/bin/bash

# Очистка буфера для ввода `read`
# Применяется в циклах, чтобы в буфере `read` не накапливались лишние символы
# Выполняется 1 секунду и сбрасывает в специальную переменную случайно нажатые символы

read -t 1 -n 1000 clrbuf

# Можно обернуть в функцию
#    function clearBuf(){ read -t 1 -n 1000 clrbuf }

# Пример использоания

for i in 1 2 3 4
do
  read -t 1 -n 1000 clrbuf
  read -p "Yes or Not? [y/n]: " -n 1 anykey

  if [[ $anykey =~ ^[Yy]$ ]]
  then
    sleep 1 #имитация задержки для ввода лишних символов
    echo "Yes"
  else
    echo "Not"
  fi
done
