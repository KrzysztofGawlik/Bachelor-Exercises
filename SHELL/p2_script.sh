#!/bin/bash
FLAG=true
printf "\n\t\t################################\n"
printf "\t\tAUTOR PROJEKTU: Krzysztof Gawlik\n"
printf "\t\tNUMER INDEKSU: 147762\n"
printf "\t\t################################\n"
FLAG=true
while [ $FLAG = "true" ]
do
    printf "\nWybierz jedną z opcji poprzez wpisanie odpowiedniej cyfry:\n\n"
    printf "\t1) Wyświetlenie nazw plików z aktualnego katalogu, o nazwach, których wzór został podany jako\n\t   parametr wywołania skryptu.\n\n"
    printf "\t2) Wyświetlenie zawartości wybranego przez użytkownika pliku jeśli nie jest on katalogiem, a jeśli\n\t   jest, to wylistowanie wszystkich plików z tego katalogu z rozszerzeniem 'dat'.\n\n"
    printf "\t3) Obliczenie sumy 8 pierwszych wyrazów ciągu arytmetycznego o parametrach wprowadzonych interaktywnie\n\t   przez użytkownika.\n\n"
    printf "\t4) Wyświetlenie szczegółowych informacji o plikach, których nazwy zawierają ciąg liter 'cop'.\n\n"
    printf "\t0) Wyjście z programu.\n\n"
    
    read -p "> " OPTION

    case $OPTION in

        0) FLAG=false ;;

        1)  echo "Lista plików zawierających '$1':"
            find -maxdepth 1 -type f -name "*$1*"
            echo ""; read -p "Enter aby kontynuować . . ." ;;

        2)  echo "Wybierz plik/katalog z listy poniżej:"
            echo "----------"
            dir -1
            echo "----------"
            read -p "> " OPTION
            if [ -d "$OPTION" ] ; then
                cd ${OPTION}
                find -maxdepth 1 -type f -name "*.dat"
                cd ..
            else
                if [ -f "$OPTION" ]; then
                    cat "${OPTION}"
                else
                    echo "Nie udało się przetworzyć polecenia... (nie ma takiego pliku lub format jest niepoprawny)"
                fi
            fi
            echo ""; read -p "Enter aby kontynuować . . ." ;;

        3)  echo "Wprowadź parametry ciągu aby obliczyć sumę pierwszych 8 wyrazów..."
            read -p "a1 = " A1
            read -p "r = "  R
            SC8=0
            for i in {1..8}
            do
                TEMP_VAL=$(( $i - 1 ))
                SC8=$(( $TEMP_VAL * $R + $A1 + $SC8 ))
            done
            echo ""
            echo "Suma pierwszych 8 wyrazów ciągu = ${SC8}."
            if [ $SC8 -lt 65536 ]; then
                echo "Tę wartość można zapisać w danej całkowitej bez znaku w słowie szesnastobitowym."
            fi
            echo ""
            echo "Parametry ciągu oraz zmienna sc8:"
            printf "a1 = $A1\t\tr = $R\t\tsc8 = $SC8\n"
            echo ""; read -p "Enter aby kontynuować . . ." ;;

        4)  echo "Szczegółowe informacje o plikach, których nazwy zawierają ciąg liter 'cop':"
            ls -lisanh *cop*
            echo ""; read -p "Enter aby kontynuować . . ." ;;

        *)  echo "Nie rozpoznany wybór..."
            echo ""; read -p "Enter aby kontynuować . . ." ;;
    esac
done