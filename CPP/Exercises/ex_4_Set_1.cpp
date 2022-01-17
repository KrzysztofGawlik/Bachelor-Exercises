/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <cmath>

// ---------------------------------- ZADANIE 1 ----------------------------------
void ad1() {
    int x, y;
    
    std::cout << "Podaj x: ";
    std::cin >> x;
    std::cout << "Podaj y: ";
    std::cin >> y;

    if(x > y) {
        std::cout << "X jest wieksze od Y" << std::endl;
    } else if (y > x) {
        std::cout << "Y jest wieksze od X" << std::endl;
    } else {
        std::cout << "Obie liczby sa rowne" << std::endl;
    }
    if(x % 2 == 0) {
        std::cout << "X jest parzyste";
    } else {
        std::cout << "X jest nie parzyste";
    }
}

// ---------------------------------- ZADANIE 2 ----------------------------------
void ad2() {
    double x, wynik;

    printf("Podaj argument x: ");
    std::cin >> x;

    if(x >= 1 && x <= 10) {
        wynik = sin(M_PI * x * M_PI / 180) + 1;
    } else if (x > 10 && x <= 20) {
        wynik = sqrt(x);
    } else {
        wynik = (x*x/3) + x + 2;
    }

    printf("y(x) dla x = %f wynosi: %f.", x, wynik);
}

// ---------------------------------- ZADANIE 3 ----------------------------------
void ad3() {
    int wybor;
    float r, h, a, b, wynik;

    printf("Co chcesz obliczyc?\n1. Objetosc kuli\n2. Objetosc stozka\n3. Pole prostokata\n");
    std::cin >> wybor;

    switch(wybor) {
        case 1:
            printf("Podaj promien kuli: ");
            std::cin >> r;
            wynik = (M_PI * (r*r*r) / 3) * 4;
            printf("Objetosc = %f.", wynik);
        break;
        case 2:
            printf("Podaj promien podstawy: ");
            std::cin >> r;
            printf("Podaj wysokosc stozka: ");
            std::cin >> h;
            wynik = (M_PI * (r*r) * h) / 3;
            printf("Objetosc = %f.", wynik);
        break;
        case 3:
            printf("Podaj dlugosc boku a: ");
            std::cin >> a;
            printf("Podaj dlugosc boku b: ");
            std::cin >> b;
            wynik = a * b;
            printf("Pole = %f.", wynik);
        break;
        default: "Nie ma takiej opcji!";
    }
}

// ---------------------------------- ZADANIE 4 ----------------------------------
void ad4() {
    float a, b, k, rad, wynik;
    printf("Podaj kolejno po spacji dlugosc boku a i b oraz miare kata pomiedzy nimi: ");
    std::cin >> a >> b >> k;
    if(k >= 180 || k <= 0) {
        printf("Taki trojkat nie moze istniec!");
    } else {
        rad = k * M_PI / 180;
        wynik = (a * b * sinf(rad)) / 2;
        printf("Pole trojkata wynosi %f.", wynik);
    }
}

// ---------------------------------- ZADANIE 5 ----------------------------------
void ad5() {
    float d, t;
    int czasH, czasM, czasS;
    printf("Podaj dlugosc drogi w km: ");
    std::cin >> d;
    d *= 1000;
    t = (0.2*d) / 10 + (0.5*d) / 8 + (0.3*d) / 5;
    czasH = t / 3600;
    czasM = (t - czasH * 3600) / 60;
    czasS = t - czasH * 3600 - czasM * 60;
    printf("Czas jazdy: %d godzin %d minut %d sekund.", czasH, czasM, czasS);
}

// ---------------------------------- MAIN ----------------------------------
int main() {

    int zadanie;

    while (true) {
        std::cout << "\nWybierz numer cwiczenia:" << std::endl;
        std::cout << "1) Zadanie 1.1" << std::endl;
        std::cout << "2) Zadanie 1.2" << std::endl;
        std::cout << "3) Zadanie 1.3" << std::endl;
        std::cout << "4) Zadanie 1.4" << std::endl;
        std::cout << "5) Zadanie 1.5" << std::endl;
        std::cout << "0) Wyjscie" << std::endl;
        std::cin >> zadanie;

        switch(zadanie) {
            case 1: ad1(); break;
            case 2: ad2(); break;
            case 3: ad3(); break;
            case 4: ad4(); break;
            case 5: ad5(); break;
            case 0: return 0; break;
            default: std::cout << "Nie ma takiego cwiczenia!" << std::endl;
        }
        printf("\nEnter aby kontynuowac...");
        std::cin.sync(); std::cin.get();
    }
}