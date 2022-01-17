/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <math.h>
using namespace std;

// ---------------------------------- ZADANIE 1 ----------------------------------
void ad1() {
    int k, n;
    int suma = 0;

    printf("\nFunkcja zwroci sume liczb naturalnych od K do N.\nPodaj K: ");
    cin >> k;
    printf("Podaj N: ");
    cin >> n;

    if(k > n) {
        printf("K nie moze byc wieksze od N! Enter - sprobuj ponownie...");
        cin.sync(); cin.get();
        ad1(); exit;
    } else {
        while(k <= n) {
            suma = suma + k;
            k++;
        }
        printf("Suma = %d", suma);
    }
}

// ---------------------------------- ZADANIE 2 ----------------------------------
void ad2()  {
    int n;

    printf("\nFunkcja wyswietli tabliczke mnozenia od 1 do n.\nPodaj n (<=10): ");
    cin >> n;

    if(n > 10 || n < 1) {
        printf("N nie moze byc mniejsze od 1 i wieksze od 10! Enter - sprobuj ponownie...");
        cin.sync(); cin.get();
        ad2(); exit;
    } else {
        for(int i = 0; i <= n; i++) {
            if(i != 0) {
                printf("\t%d", i);
            } else {
                printf("\t|");
            }
        }
        printf("\n--------|----------------------------------------------------------------------------------");

        for(int i = 0; i <= n; i++) {
            if(i != 0) {
                printf("%d\t|", i);
                int x = 1;
                while(x <= n) {
                    printf("\t%d", x*i);
                    x++;
                }
                cout << endl;
            } else {
                printf("\n");
            }
        }
    }
}

// ---------------------------------- ZADANIE 3 ----------------------------------
float y(float x) {
    return 3*(x*x)+(3*x-1);
}

void ad3()  {
    int n;
    float x, a, h;

    printf("\nObliczanie funkcji y(x) = 3*x^2+3x-1 dla x = a+i*h, gdzie i = 0,1,2...n : n > 0\n");
    printf("Podaj oddzielajac spacja wpolczynniki a, h, n (np. 2 14 8): ");
    cin >> a >> h >> n;
    if(n < 0) {
        printf("N nie moze byc mniejsze od 1! Enter - sprobuj ponownie...");
        cin.sync(); cin.get();
        ad3(); exit;
    } else {
        for(int i = 0; i <= n; i ++) {
            x = a+(i*h);
            printf("n = %d --> y(%f) = %f\n", i, x, y(x));
        }
    }
}

// ---------------------------------- ZADANIE 4 ----------------------------------
void ad4()  {
    int m;
    float wynik;

    printf("\nFunkcja obliczy sume 1+j/2*j^3+3 dla j od 0 do m.\nPodaj wartosc m: ");
    cin >> m;
    if(m < 0) {
        printf("M nie moze byc mniejsze od 0! Enter - sprobuj ponownie...");
        cin.sync(); cin.get();
        ad4(); exit;
    } else {
        for(int j = 0; j <= m; j++) {
            wynik += (float)(1 + j)/((2 * j * j * j) + 3);
        }
        printf("Wynik = %f", wynik);
    }
}

// ---------------------------------- ZADANIE 5 (not working) ----------------------------------
void ad5()  {
    int n;
    float wynik = 1, wynikCzesciowy;

    printf("\nFunkcja obliczy iloczyn k/2.5*k+1.5 dla k od 1 do n.\nPodaj wartosc n: ");
    cin >> n;
    if(n < 1) {
        printf("N nie moze byc mniejsze od 1! Enter - sprobuj ponownie...");
        cin.sync(); cin.get();
        ad5(); exit;
    } else {
        for(int k = 1; k <= n; k++) {
            wynikCzesciowy = k/((2.5 * k) + 1.5);
            wynik *= wynikCzesciowy;
        }
        printf("Wynik = %f", wynik);
    }
}

// ---------------------------------- ZADANIE 6 ----------------------------------
bool sprawdzTrojkat(float a, float b, float c)  {
    if( a+b>c && b+c>a && a+c>b ) return true;
    return false;
}

float obliczPoleTrojkata(float a, float b, float c) {
    float p;
    p = (a+b+c)/2;
    return sqrt(p * (p-a) * (p-b) * (p-c));
}

// ---------------------------------- MAIN ----------------------------------
int main() {
    int zadanie;
    float a, b, c;
    bool trojkat;

    while (true) {
        cout << "\nWybierz numer cwiczenia:" << endl;
        cout << "1) Zadanie 2.1" << endl;
        cout << "2) Zadanie 2.2" << endl;
        cout << "3) Zadanie 2.3" << endl;
        cout << "4) Zadanie 2.4" << endl;
        cout << "5) Zadanie 2.5" << endl;
        cout << "6) Zadanie 2.6" << endl;
        cout << "0) Wyjscie" << endl;
        cin >> zadanie;

        switch(zadanie) {
            case 1: ad1(); break;
            case 2: ad2(); break;
            case 3: ad3(); break;
            case 4: ad4(); break;
            case 5: ad5(); break;
            case 6: {
                printf("Funkcja obliczy pole trojkata o podanych bokach, jezeli jest mozliwy.\n");
                printf("Podaj trzy dlugosci bokow trojkata (np. 3 4 5): ");
                cin >> a >> b >> c;
                trojkat = sprawdzTrojkat(a, b, c);
                printf("Czy trojkat jest mozliwy? %s\n", trojkat ? "true" : "false");
                if(trojkat) {
                    printf("Pole trojkata = %f", obliczPoleTrojkata(a, b, c));
                }
            } break;
            case 0: return 0; break;
            default: cout << "Nie ma takiego cwiczenia!" << endl;
        }
        printf("\nEnter aby kontynuowac...");
        cin.sync(); cin.get();
    }

    return 0;
}