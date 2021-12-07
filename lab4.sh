#!/bin/sh

#1 	Установите из сетевого репозитория пакеты, входящие в группу «Developments Tools».
sudo apt-get install build-essential

#2	Установите из исходных кодов, приложенных к методическим указаниям пакет bastet-0.43. Для этого необходимо создать отдельный каталог и скопировать в него исходные коды проекта bastet. 
#	Вы можете использовать подключение сетевого каталога в хостовой операционной системе для передачи архива с исходными кодами в виртуальную машину. 
#	Далее следует распаковать архив до появления каталога с исходными файлами (в каталоге должен отображаться Makefile).
#	После этого соберите пакет bastet и запустите его, чтобы удостовериться, что он правильно собрался. 
#	Затем модифицируйте Makefile, добавив в него раздел install. Обеспечьте при установке копирование исполняемого файла в
#	/usr/bin с установкой соответствующих прав доступа. Выполните установку и проверьте, что любой пользователь может запустить установленный пакет.
tar zvxf bastet-0.43.tgz
cd bastet-0.43
sudo apt install libboost-all-dev
sudo apt-get install libncurses5-dev
make
./bastet

#install:
#	cp bastet /usr/bin
#	chmod a+x /usr/bin/bastet

sudo make install
ls -l /usr/bin | grep bastet
#-rwxr-xr-x 1 root root      712400 Dec  6 15:12 bastet


#3 	Создайте файл task3.log, в который выведите список всех установленных пакетов.
apt list --installed > ~/lab4/task3.log

#4 	Создайте файл task4_1.log, в который выведите список всех пакетов (зависимостей), необходимых
#	для установки и работы компилятора gcc. Создайте файл task4_2.log, в который выведите список
#	всех пакетов (зависимостей), установка которых требует установленного пакета libgcc.
apt-cache depends gcc > ~/lab4/task4_1.log
apt-cache rdepends libgcc > ~/lab4/task4_2.log

#5 	Создайте каталог localrepo в домашнем каталоге пользователя root и скопируйте в него пакет
#	checkinstall-1.6.2-3.el6.1.x86_64.rpm , приложенный к методическим указаниям. Создайте
#	собственный локальный репозиторий с именем localrepo из получившегося каталога с пакетом.
sudo su
cd /root
mkdir localrepo
sudo cp checkinstall-1.6.2-3.el6.1.x86_64.rpm /root/localrepo/

sudo apt-get install dpkg-dev
sudo apt-get install alien
alien checkinstall-1.6.2-3.el6.1.x86_64.rpm
dpkg-scanpackages . /dev/null > Release
dpkg-scanpackages . /dev/null | gzip -9c > Packages

#/etc/apt/sources.list
sudo nano /etc/apt/sources.list
#deb [trusted=yes] file:///root/localrepo ./

#6 	Создайте файл task6.log, в который выведите список всех доступных репозиториев.
sudo apt-cache policy > ~/lab4/task6.log

#7 	Настройте систему на работу только с созданным локальным репозиторием (достаточно переименовать
#	конфигурационные файлы других репозиториев). Выведите на экран список доступных для установки
#	пакетов и убедитесь, что доступен только один пакет, находящийся в локальном репозитории. Установите
#	этот пакет.
sudo apt-get update
#N: Download is performed unsandboxed as root as file '/root/localrepo/./InRelease' couldn't be accessed by user '_apt'. - pkgAcquire::Run (13: Permission denied)

#8 	Скопируйте в домашний каталог пакет fortunes-ru_1.52-2_all, приложенный к методическим рекомендациям, преобразуйте его в rpm пакет и установите.

sudo dpkg -i fortunes-ru_1.52-2_all.deb


#9 	Скачайте из сетевого репозитория пакет nano. Пересоберите пакет таким образом, чтобы после его
#	установки менеджером пакетов, появлялась возможность запустить редактор nano из любого каталога,
#	введя команду newnano.

tar -xvzf nano-5.9.tar.gz
cd nano-5.9
./configure --prefix=/usr/ --program-prefix=new
make 
make install