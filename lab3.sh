#!/bin/sh

#1. выводит в файл work3.log построчно список всех пользователей в системе в следующем формате: «user NNN has id MM»
cat /etc/passwd | awk -F: '{print "user " $1 " has id " $3}' > ~/Desktop/work3.log

#2. добавляет в файл work3.log строку, содержащую дату последней смены пароля для пользователя root
chage -l root | head -1 | awk -F: '{print $2}' >> ~/Desktop/work3.log

#3. добавляет в файл work3.log список всех групп в системе (только названия групп) через запятую
cat /etc/group | awk -F: '{print $1}' | tr -s '\n' ',' >> ~/Desktop/work3.log

#4. делает так, чтобы при создании нового пользователя у него в домашнем каталоге создавался файл readme.txt с текстом «Be careful!»
echo "Be careful!" > /etc/skel/readme.txt 

#5. создает пользователя u1 с паролем 12345678
useradd u1 -p $(openssl passwd -crypt 12345678)

#6. создает группу g1
groupadd g1

#7. делает так, чтобы пользователь u1 дополнительно входил в группу g1
usermod -a -G g1 u1

#8. добавляет в файл work3.log строку, содержащую сведения об идентификаторе и имени пользователя u1 и идентификаторах и именах всех групп, в которые он входит
id u1 | awk -F' ' '{print $1,$3}' >> ~/Desktop/work3.log

#9. делает так, чтобы пользователь user дополнительно входил в группу g1
usermod -a -G g1 root

#10. добавляет в файл work3.log строку с перечнем пользователей в группе g1 через запятую
cat /etc/group | grep g1 | awk -F: '{print $4}' >> ~/Desktop/work3.log

#11. делает так, что при входе пользователя u1 в систему вместо оболочки bash автоматически запускается /usr/bin/mc, при выходе из которого пользователь возвращается к вводу логина и пароля
usermod -s /usr/bin/mc u1

#12. создает пользователя u2 с паролем 87654321
useradd u2 -p $(openssl passwd -crypt 12345678)

#13. в каталоге /home создает каталог test13, в который копирует файл work3.log два раза с разными именами (work3-1.log и work3-2.log)
mkdir /home/test13
cp work3.log /home/test13/work3-1.log
cp work3.log /home/test13/work3-2.log

#14. сделает так, чтобы пользователи u1 и u2 смогли бы просматривать каталог test13 и читать эти файлы, только пользователь u1 смог бы изменять и удалять их, а все остальные пользователи системы не могли просматривать содержимое каталога test13 и файлов в нем. При этом никто не должен иметь права исполнять эти файлы
chown u1:u2 /home/test13
chown u1:u2 /home/test13/*
chmod 550 /home/test13
chmod 640 /home/test13/*

#15. создает в каталоге /home каталог test14, в который любой пользователь системы сможет записать данные, но удалить любой файл сможет только пользователь, который его создал или пользователь u1
mkdir /home/test14
chmod +t /home/test14
chown u1:u1 /home/test14

#16. копирует в каталог test14 исполняемый файл редактора nano и делает так, чтобы любой пользователь смог изменять с его помощью файлы, созданные в пункте 13
cp /bin/nano /home/test14/nano
chown u1:u1 /home/test14/nano
chmod u+s /home/test14/nano

#17. создает каталог test15 и создает в нем текстовый файл /test15/secret_file. Делает так, чтобы содержимое этого файла можно было вывести на экран, используя полный путь, но чтобы узнать имя этого файла, было бы невозможно.
mkdir /home/test15
touch /home/test15/secret_file
chmod 111 /home/test15
chmod 444 /home/test15/secret_file