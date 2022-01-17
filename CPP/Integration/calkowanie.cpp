/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <cmath>
using namespace std;

double f(double x);
double cykl(double a, int n);
double rect(double a, double b, int n);
double trap(double a, double b, int n);
double simp(double a, double b, int n);

int main() {
    int n = 100;
    double a = 0, b = 1;
    bool petla = true;

    do{
        b = cykl(a, n);
        if(b == 0){
            petla = false;
        } else {
            printf("Wyznaczona calka metoda prostokatow: %f\n", rect(a, b, n));
            printf("Wyznaczona calka metoda trapezow: %f\n", trap(a, b, n));
            printf("Wyznaczona calka metoda Simpsona: %f\n", simp(a, b, n));
            system("pause");
        }
    } while(petla == true);

    return 0;
}

double f(double x){
    //if(x == 0) return 0;
    return (sqrt(x) * sin(x));
}

double cykl(double a, int n){
    double userInput;
    printf("\n*** CALKOWANIE NUMERYCZNE ***\n");
    printf("Funkcja: sqrt(x)*sin(x)*dx\n");
    printf("Liczba podprzedzialow: %d\n", n);
    printf("Dolny przedzial calkowania: %f\n", a);
    printf("Podaj gorny przedzial calkowania (0 aby wyjsc): ");
    cin >> userInput;
    printf("------------------------------------\n");
    return userInput;
}

double rect(double a, double b, int n){
    double calka = 0, dx = (b - a) / n;
    for(int i = 1; i <= n; i++){
        calka += f(a+i*dx);
    }
    return calka * dx;
}

double trap(double a, double b, int n){
    double calka = 0, dx = (b - a) / n;
    for(int i = 0; i < n; i++){
        calka += f(a+i*dx);
    }
    return (calka + (f(a) + f(b)) / 2) * dx;
}

double simp(double a, double b, int n){
    double calka = 0;
    double suma = 0;
    double podzial = 0;
    double dx = (b - a) / n;
    for(int i = 0; i <= n; i++){
        podzial = a + i * dx;
        if(isnormal(f(podzial - dx / 2))) {
            suma += f(podzial - dx / 2);
        }
        if(i < n){
            calka += f(podzial);
        }
    }
    return (dx / 6 * ( f(a) + f(b) + 2 * calka + 4 * suma ));
}