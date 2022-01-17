/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <cmath>
using namespace std;

void pobierzWielomian(double* wspWielomianu, double* wspPochodnej, int stopien);
double fX(double* wsp, int stopien, double x);
double pX(double* wsp, int stopien, double x);

int main(){

    int stopien, iterator = 100;
    double *wspolczynnik, *pochodna;
    double x, xStart, xStop;

    printf("Podaj stopien wielomianu: ");
    cin >> stopien;

    wspolczynnik = new double[stopien + 1];
    pochodna = new double[stopien + 1];
    pobierzWielomian(wspolczynnik, pochodna, stopien);

    printf("Podaj poczatek przedzialu: ");
    cin >> xStart;
    printf("Podaj koniec przedzialu: ");
    cin >> xStop;

    if(fX(wspolczynnik, stopien, xStart) * fX(wspolczynnik, stopien, xStop) > 0){
        printf("Brak miejsc zerowych lub wiecej niz jedno...");
        return 0;
    } else if(fX(wspolczynnik, stopien, xStart) == 0){
        printf("Poczatek przedzialu jest miejscem zerowym.");
        return 0;
    } else if(fX(wspolczynnik, stopien, xStop) == 0){
        printf("Koniec przedzialu jest miejscem zerowym.");
        return 0;
    } else {
        x = xStart;
        for(int i = 0; i <= iterator; i++){
            x = x - (fX(wspolczynnik, stopien, x) / pX(pochodna, stopien, x));
        }
    }

    printf("\n\nPo %d iteracji(-ach) przyblizony wynik wynosi: %f\n", iterator, x);
    printf("\nWcisnij dowolny przycisk aby zakonczyc . . .");
    cin.sync(); cin.get();

    return 0;
}

void pobierzWielomian(double* wspWielomianu, double* wspPochodnej, int stopien){
    printf("\nUzupelnij wspolczynniki: \n");
    for(int i = stopien; i >= 0; i--){
        printf("\tx^%d = ", i);
        cin >> wspWielomianu[i];
        wspPochodnej[i] = wspWielomianu[i] * i;
        printf("");
    }
    printf("\n");
}

double fX(double* wsp, int stopien, double x){
    double y = 0;
    for(int i = stopien; i >= 0; i--){
        y += wsp[i] * pow(x, i);
    }
    return y;
}

double pX(double* wsp, int stopien, double x){
    double y = 0;
    for(int i = stopien; i >= 0; i--){
        y += wsp[i] * pow(x, i - 1);
    }
    return y;
}