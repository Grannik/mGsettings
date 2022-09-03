#!/bin/bash
 E='echo -e';
 e='echo -en';
#
 i=0; CLEAR; CIVIS;NULL=/dev/null
 trap "R;exit" 2
 ESC=$( $e "\e")
 TPUT(){ $e "\e[${1};${2}H" ;}
 CLEAR(){ $e "\ec";}
 CIVIS(){ $e "\e[?25l";}
 R(){ CLEAR ;stty sane;CLEAR;};                 # в этом варианте фон прозрачный
#
 ARROW(){ IFS= read -s -n1 key 2>/dev/null >&2
           if [[ $key = $ESC ]];then
              read -s -n1 key 2>/dev/null >&2;
              if [[ $key = \[ ]]; then
                 read -s -n1 key 2>/dev/null >&2;
                 if [[ $key = A ]]; then echo up;fi
                 if [[ $key = B ]];then echo dn;fi
              fi
           fi
           if [[ "$key" == "$($e \\x0A)" ]];then echo enter;fi;}
 UNMARK(){ $e "\e[0m";}
 MARK(){ $e "\e[30;47m";}
#
 HEAD()
{
 for (( a=2; a<=35; a++ ))
          do
              TPUT $a 1
                        $E "\e[47;30m│\e[0m                                                                                \e[47;30m│\e[0m";
          done
              TPUT  1 1;$E "\033[0m\033[47;30m┌────────────────────────────────────────────────────────────────────────────────┐\033[0m"
              TPUT  3 3;$E "\e[1;36m *** gsettings ***\e[0m";
              TPUT  4 3;$E "\e[2m gsettings - GSettings configuration tool\e[0m";
              TPUT  5 1;$E "\e[47;30m├\e[0m\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m";
              TPUT  9 1;$E "\e[47;30m├\e[0m\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m";
              TPUT 10 3;$E "\e[36m Commands\e[0m";
              TPUT 25 1;$E "\e[47;30m├\e[0m\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m";
              TPUT 29 1;$E "\e[47;30m├\e[0m\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m";
              TPUT 31 1;$E "\e[47;30m├\e[0m\e[1;30m────────────────────────────────────────────────────────────────────────────────\e[0m\e[47;30m┤\e[0m";
              TPUT 32 3;$E "\e[2m Up \xE2\x86\x91 \xE2\x86\x93 Down Select Enter\e[0m";
}
 FOOT(){ MARK;TPUT 35 1;$E "\033[0m\033[47;30m└────────────────────────────────────────────────────────────────────────────────┘\033[0m";UNMARK;}
#
  M0(){ TPUT  6 3; $e " Установка                                                          \e[32m Install \e[0m";}
  M1(){ TPUT  7 3; $e " Kраткий обзор                                                     \e[32m Synopsis \e[0m";}
  M2(){ TPUT  8 3; $e " Описание                                                       \e[32m Description \e[0m";}
#
  M3(){ TPUT 11 3; $e " Получает значение KEY. Pаспечатывается как сериализованный GVariant    \e[32m get \e[0m";}
  M4(){ TPUT 12 3; $e " Отслеживает KEY для изменений и печатает измененные значения       \e[32m monitor \e[0m";}
  M5(){ TPUT 13 3; $e " Выясняет, доступен ли KEY для записи                              \e[32m writable \e[0m";}
  M6(){ TPUT 14 3; $e " Запрашивает диапазон допустимых значений для KEY                     \e[32m range \e[0m";}
  M7(){ TPUT 15 3; $e " Запрашивает описание допустимых значений для KEY                  \e[32m describe \e[0m";}
  M8(){ TPUT 16 3; $e " Устанавливает значение KEY в VALUE                                     \e[32m set \e[0m";}
  M9(){ TPUT 17 3; $e " Resets KEY to its default value                                      \e[32m reset \e[0m";}
 M10(){ TPUT 18 3; $e " Список ключей и значений, рекурсивно                     \e[32m reset-recursively \e[0m";}
 M11(){ TPUT 19 3; $e " Список установленных неперемещаемых схем                      \e[32m list-schemas \e[0m";}
 M12(){ TPUT 20 3; $e " Список установленных, перемещаемых схем           \e[32m list-relocatable-schemas \e[0m";}
 M13(){ TPUT 21 3; $e " Перечисляет ключи в SCHEMA                                       \e[32m list-keys \e[0m";}
 M14(){ TPUT 22 3; $e " Перечисляет дочерние элементы SCHEMA                         \e[32m list-children \e[0m";}
 M15(){ TPUT 23 3; $e " Перечисляет ключи и значения, рекурсивно                  \e[32m list-recursively \e[0m";}
 M16(){ TPUT 24 3; $e " Prints help and exits                                                 \e[32m help \e[0m";}
#
 M17(){ TPUT 26 3; $e " Hизкоуровневая система конфигурации                                  \e[32m dconf \e[0m";}
 M18(){ TPUT 27 3; $e " man                                                                  \e[32m dconf \e[0m";}
 M19(){ TPUT 28 3; $e "                                                                       \e[32m link \e[0m";}
#
 M20(){ TPUT 30 3; $e " Grannik Git                                                                 ";}
#
 M21(){ TPUT 33 3; $e " Exit                                                                        ";}
LM=21
   MENU(){ for each in $(seq 0 $LM);do M${each};done;}
    POS(){ if [[ $cur == up ]];then ((i--));fi
           if [[ $cur == dn ]];then ((i++));fi
           if [[ $i -lt 0   ]];then i=$LM;fi
           if [[ $i -gt $LM ]];then i=0;fi;}
REFRESH(){ after=$((i+1)); before=$((i-1))
           if [[ $before -lt 0  ]];then before=$LM;fi
           if [[ $after -gt $LM ]];then after=0;fi
           if [[ $j -lt $i      ]];then UNMARK;M$before;else UNMARK;M$after;fi
           if [[ $after -eq 0 ]] || [ $before -eq $LM ];then
           UNMARK; M$before; M$after;fi;j=$i;UNMARK;M$before;M$after;}
   INIT(){ R;HEAD;FOOT;MENU;}
     SC(){ REFRESH;MARK;$S;$b;cur=`ARROW`;}
# Функция возвращения в меню
     ES(){ MARK;$e " ENTER = main menu ";$b;read;INIT;};INIT
  while [[ "$O" != " " ]]; do case $i in
  0) S=M0;SC; if [[ $cur == enter ]];then R;echo -e "
 Предустановлена
";ES;fi;;
  1) S=M1;SC; if [[ $cur == enter ]];then R;echo -e "\e[32m
 gsettings get SCHEMA [:PATH]  KEY
 gsettings monitor SCHEMA [:PATH]  [KEY]
 gsettings writable SCHEMA [:PATH]  KEY
 gsettings range SCHEMA [:PATH]  KEY
 gsettings describe SCHEMA [:PATH]  KEY
 gsettings set SCHEMA [:PATH]  KEY VALUE
 gsettings reset SCHEMA [:PATH]  KEY
 gsettings reset-recursively SCHEMA [:PATH]
 gsettings list-schemas [--print-paths]
 gsettings list-relocatable-schemas
 gsettings list-keys SCHEMA [:PATH]
 gsettings list-children SCHEMA [:PATH]
 gsettings list-recursively [SCHEMA [:PATH]]
 gsettings help [COMMAND]
\e[0m
 Синтаксис использования GSettings:
 gsettings [--schemadir <КАТАЛОГ_СХЕМ>] <КОМАНДА> [<АРГУМЕНТЫ…>]
";ES;fi;;
  2) S=M2;SC; if [[ $cur == enter ]];then R;echo -e "
\e[32m gsettings\e[0m предлагает простой интерфейс командной строки для GSettings. Он позво-
 ляет вам получать, устанавливать или отслеживать изменения отдельного ключа.
 Аргументы SCHEMA и KEY требуются для большинства команд, чтобы указать идентифи-
 катор схемы и имя ключа для работы. Идентификатор схемы может дополнительно
 иметь суффикс :PATH. Указание пути необходимо только в том случае, если схема
 не имеет фиксированного пути.
 При установке ключа вам также необходимо указать VALUE. Формат значения соответ-
 ствует сериализованному GVariant, поэтому, например. строка должна содержать яв-
 ные кавычки:\e[32m 'foo'\e[0m. Этот формат также используется при распечатке значений. Об-
 ратите внимание, что gsettings требуется подключение к сеансовой шине D-Bus для
 записи изменений в базу данных dconf.
\e[32m gsettings\e[0m - это консольная утилита, при помощи которой можно
 управлять ключами dconf
";ES;fi;;
  3) S=M3;SC; if [[ $cur == enter ]];then R;echo -e "
 Получает значение KEY. Значение распечатывается как сериализованный GVariant
";ES;fi;;
  4) S=M4;SC; if [[ $cur == enter ]];then R;echo -e "
 Отслеживает KEY для изменений и печатает измененные значения.
 Если KEY не указан, отслеживаются все ключи в схеме. Мониторинг будет
 продолжаться до тех пор, пока процесс не будет завершен.
";ES;fi;;
  5) S=M5;SC; if [[ $cur == enter ]];then R;echo -e "
 Выясняет, доступен ли KEY для записи.
";ES;fi;;
  6) S=M6;SC; if [[ $cur == enter ]];then R;echo -e "
 Запрашивает диапазон допустимых значений для KEY.
";ES;fi;;
  7) S=M7;SC; if [[ $cur == enter ]];then R;echo -e "
 Запрашивает описание допустимых значений для KEY.
";ES;fi;;
  8) S=M8;SC; if [[ $cur == enter ]];then R;echo -e "
 Устанавливает значение KEY в VALUE.
 Значение указывается как сериализованный GVariant.
";ES;fi;;
  9) S=M9;SC; if [[ $cur == enter ]];then R;echo -e "
 Resets KEY to its default value.
";ES;fi;;
 10) S=M10;SC;if [[ $cur == enter ]];then R;echo -e "
 Список ключей и значений, рекурсивно:
\e[32m gsettings list-recursively org.gnome.desktop.background\e[0m

 Просмотр текущих настроек Touchpad:
\e[32m gsettings list-recursively org.gnome.desktop.peripherals.touchpad\e[0m
";ES;fi;;
 11) S=M11;SC;if [[ $cur == enter ]];then R;echo -e "
 Список установленных неперемещаемых схем. См.\e[32m list-relocatable-schemas\e[0m, если вас
 интересуют перемещаемые схемы. Если указан \e[32m--print-paths\e[0m, также печатается
 путь, по которому отображается каждая схема.

 Bыяснить пути и названия элементов схемы:
\e[32m gsettings list-schemas\e[0m

 Поиск соответствий схемы настройкам рабочего стола:
\e[32m gsettings list-schemas | grep background\e[0m
";ES;fi;;
 12) S=M12;SC;if [[ $cur == enter ]];then R;echo -e "
 Список установленных, перемещаемых схем.
 См. список-схемы, если вы заинтересованы в неперемещаемых схемах.
";ES;fi;;
 13) S=M13;SC;if [[ $cur == enter ]];then R;echo -e "
 Перечисляет ключи в SCHEMA.
";ES;fi;;
 14) S=M14;SC;if [[ $cur == enter ]];then R;echo -e "
 Перечисляет дочерние элементы SCHEMA.
";ES;fi;;
 15) S=M15;SC;if [[ $cur == enter ]];then R;echo -e "
 Перечисляет ключи и значения, рекурсивно.
 Если SCHEMA не указана, перечислите ключи во всех схемах.
";ES;fi;;
 16) S=M16;SC;if [[ $cur == enter ]];then R;echo -e "
 Prints help and exits.
 Для того чтобы получить подробную справку по интересующей команде, выполните:
\e[32m gsettings help <КОМАНДА>\e[0m
";ES;fi;;
 17) S=M17;SC;if [[ $cur == enter ]];then R;echo -e "
 Dconf – низкоуровневая система конфигурации. При помощи dconf в GNOME и Unity
 хранятся настройки большинства программ.
 Dconf это простая система конфигурации основанная на ключах. Ключи находятся в
 неструктурированной базе данных (ключи, логически связанные между собой объеди-
 нены в категории). База данных хранится в бинарном файле, который располагается
 в\e[32m ~/.config/dconf\e[0m
 Управление ключами dconf
 В большинстве случаев пользователю не нужно вручную редактировать настройки хра-
 нящиеся в dconf. Но иногда графическое представление тому или иному параметру
 отсутствует и единственным способом изменить его значение является редактирова-
 ние ключа напрямую. Это можно осуществить несколькими способами.

 и выполним команду:\e[32m dconf update\e[0m
";ES;fi;;
 18) S=M18;SC;if [[ $cur == enter ]];then R;man dconf;ES;fi;;
 19) S=M19;SC;if [[ $cur == enter ]];then R;echo -e "
 wiki.archlinux.org:
\e[36m https://wiki.archlinux.org/title/GNOME_(%D0%A0%D1%83%D1%81%D1%81%D0%BA%D0%B8%D0%B9)\e[0m

 Как настроить прокси в Ubuntu из терминала:
\e[36m https://bloglinux.ru/1317-kak-nastroit-proksi-v-ubuntu-iz-terminala.html\e[0m

 настройки сенсорной панели:
\e[36m https://fashguide.net/ru/%D0%BA%D0%B0%D0%BA-%D0%BD%D0%B0%D1%81%D1%82%D1%80%D0%BE%D0%B8%D1%82%D1%8C-%D0%BF%D0%B0%D1%80%D0%B0%D0%BC%D0%B5%D1%82%D1%80%D1%8B-%D1%81%D0%B5%D0%BD%D1%81%D0%BE%D1%80%D0%BD%D0%BE%D0%B9-%D0%BF%D0%B0\e[0m

 Изменение формата отображаемой даты:
\e[36m https://sysadminwiki.ru/wiki/Ubuntu\e[0m
";ES;fi;;
#
 20) S=M20;SC;if [[ $cur == enter ]];then R;echo -e "
 a - asciinema     file asciinema файл
 c - circular menu file общее меню
 s - source        file источник
 t - text          file текстовый файл
 l - bash list     file лист
 m - menu          file меню
 n - simple menu   file простое меню

 mGsettings Описание утилиты gsettings. GSettings configuration tool
 Asciinema:  \e[36m https://asciinema.org/a/WRPH9EVyrVDcFOlddDC7M2kDi\e[0m
 Github:     \e[36m \e[0m
 Gitlab:     \e[36m \e[0m
 Sourceforge:\e[36m \e[0m
 Notabug:    \e[36m \e[0m
 Codeberg:   \e[36m \e[0m
 Bitbucket:  \e[36m \e[0m
 Framagit:   \e[36m \e[0m
 Gitea:      \e[36m \e[0m
 GFogs: The owner has reached maximum creation limit of 10 repositories.
 Sa 03 Sep 2022 14:11:42 CEST
";ES;fi;;
 21) S=M21;SC;if [[ $cur == enter ]];then R;clear;ls -l;exit 0;fi;;
 esac;POS;done
