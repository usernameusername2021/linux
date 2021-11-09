#!/bin/sh

#1. Создать каталог test в домашнем каталоге пользователя.
mkdir ~/test
#2. Создать в нем файл list, содержащий список всех файлов и поддиректориев каталога /etc (включая скрытые) в таком виде, что можно однозначно определить какая из записей является именем файла, а какая — названием директории.
ls /etc -l -a > ~/test/list
#3. Вывести в конец этого файла два числа. Сначала количество поддиректориев в каталоге /etc, а затем количество скрытых файлов в каталоге /etc.
find /etc -maxdepth 1 -mindepth 1 -type d| wc -l >> ~/test/list
find /etc -maxdepth 1 -type f -name ".*" | wc -l >> ~/test/list
#4. Создать в каталоге test каталог links.
mkdir ~/test/links
#5. Создать в каталоге links жесткую ссылку на файл list с именем list_hlink.
ln -P ~/test/list ~/test/links/list_hlink
#6. Создать в каталоге links символическую ссылку на файл list с именем list_slink.
ln -s ~/test/list ~/test/links/list_slink
#7. Вывести на экран количество имен (жестких ссылок) файла list_hlink, количество имен (жестких ссылок) файла list и количество имен (жестких ссылок) файла list_slink.
stat -c %h ~/test/links/list_hlink
stat -c %h ~/test/list
stat -c %h ~/test/links/list_slink
#8. Дописать в конец файла list_hlink число строк в файле links.
cat ~/test/list | wc -l >> ~/test/list_hlink
#9. Сравнить содержимое файлов list_hlink и list_slink. Вывести на экран YES, если файлы идентичны.
cmp ~/test/links/list_hlink ~/test/links/list_slink && echo YES
#10. Переименовать файл list в list1.
mv ~/test/list ~/test/list1
#11. Сравнить содержимое файлов list_hlink и list_slink. Вывести на экран YES, если файлы идентичны.
cmp ~/test/links/list_hlink ~/test/links/list_slink && echo YES
#12. Создать в домашнем каталоге пользователя жесткую ссылку на файл list_link с именем list1.
ln -P ~/test/links/list_hlink ~/list1
#13. Создать в домашнем каталоге файл list_conf, содержащий список файлов с расширением .conf, из каталога /etc и всех его подкаталогов.
find /etc -type f -name "*.conf" > ~/list_conf
#14. Создать в домашнем каталоге файл list_d, содержащий список всех подкаталогов каталога /etc, расширение которых .d.
find /etc -maxdepth 1 -type d -name "*.d" > ~/list_d
#15. Создать файл list_conf_d, включив в него последовательно содержимое list_conf и list_d.
cat ~/list_conf > ~/list_conf_d 
cat ~/list_d >> ~/list_conf_d 
#16. Создать в каталоге test скрытый каталог sub.
mkdir ~/test/.sub
#17. Скопировать в него файл list_conf_d.
cp ~/list_conf_d ~/test/.sub
#18. Еще раз скопировать туда же этот же файл в режиме автоматического создания резервной копии замещаемых файлов.
cp -b ~/list_conf_d ~/test/.sub
#19. Вывести на экран полный список файлов (включая все подкаталоги и их содержимое) каталога test.
find ~/test -type f 
#20. Создать в домашнем каталоге файл man.txt, содержащий документацию на команду man.
man --help > ~/man.txt
#21. Разбить файл man.txt на несколько файлов, каждый из которых будет иметь размер не более 1 килобайта.
split -b 1024 ~/man.txt ~/
#22. Создать каталог man.dir.
mkdir ~/man.dir
#23. Переместить одной командой все файлы, полученные в пункте 21 в каталог man.dir.
mv ~/a* ~/man.dir
#24. Собрать файлы в каталоге man.dir обратно в файл с именем man.txt.
cat ~/man.dir/a* > ~/man.dir/man.txt
#25. Сравнить файлы man.txt в домашней каталоге и в каталоге man.dir и вывести YES, если файлы идентичны.
cmp ~/man.txt ~/man.dir/man.txt && echo YES
#26. Добавить в файл man.txt, находящийся в домашнем каталоге несколько строчек с произвольными символами в начало файла и несколько строчек в конце файла.
echo "Первая строка
$(cat ~/man.txt)" > ~/man.txt
echo "Последняя строка" >> ~/man.txt
#27. Одной командой получить разницу между файлами в отдельный файл в стандартном формате для наложения патчей.
diff -u ~/man.txt ~/man.dir/man.txt > ~/patch
#28. Переместить файл с разницей в каталог man.dir.
mv ~/patch ~/man.dir
#29. Наложить патч из файла с разницей на man.txt в каталоге man.dir.
patch ~/man.dir/man.txt ~/man.dir/patch
#30. Сравнить файлы man.txt в домашней каталоге и в каталоге man.dir и вывести YES, если файлы идентичны.
cmp ~/man.txt ~/man.dir/man.txt && echo YES




#
{ find /etc -type f -name "*.conf" 2>/dev/null | tee ~/list_conf ; find /etc -maxdepth 1 -type d -name "*.d" 2>/dev/null | tee ~/list_d;} > ~/list_conf_d 
