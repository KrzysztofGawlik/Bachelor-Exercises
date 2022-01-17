/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <tuple>
#include <ctime>
#include <cmath>
using namespace std;

void readArray(int* addr, int len);
void printArray(int* addr, int len);
int sum(int tab[], int len);
float avg(int tab[], int len);
tuple<int, int> minAndQty(int* addr, int len);
int countInArray(int tab[], int len, int input);
double stdDeviation(int tab[], int len);

int main() {
    int userInput;
    int y[10], a[10], x[15];
    srand((unsigned) time(0));
    
    while(true){
        printf("\nZADANIE 3 -- Wybierz cwiczenie (1 - 5):\n");
        printf("1) Cwiczenie 3.1\n");
        printf("2) Cwiczenie 3.2\n");
        printf("3) Cwiczenie 3.3\n");
        printf("4) Cwiczenie 3.4\n");
        printf("5) Cwiczenie 3.5\n");
        printf("0) Wyjscie\n");
        cin >> userInput;
        switch(userInput){
            case 1: {
                printf("Podaj 10 liczb calkowitych: \n");
                readArray(y, 10);
                printArray(y, 10);
                printf("\nSuma z podanych liczb wiekszych od 0: %d", sum(y, 10));
                printf("\nSrednia z podanych liczb mniejszych od 0: %.2f", avg(y, 10));
                // PAUSE
                printf("\nEnter aby kontynuowac . . .");
                cin.sync(); cin.get();
            } break;
            case 2: {
                int min, qty;
                printf("Podaj 10 liczb calkowitych: \n");
                readArray(a, 10);
                printArray(a, 10);
                tie(min, qty) = minAndQty(a, 10);
                printf("\nNajmniejsza wartosc \"%d\" powtarza sie %d razy.", min, qty);
                // PAUSE
                printf("\nEnter aby kontynuowac . . .");
                cin.sync(); cin.get();
            } break;
            case 3: {
                for(int i = 0; i < 15; i++){
                    x[i] = rand() % 30 + 5;
                }
                printArray(x, 15);
                printf("\nPodaj liczbe do wyszukania: ");
                cin >> userInput;
                int qty = countInArray(x, 15, userInput);
                if(qty == 0) printf("\nLiczba %d nie wystepuje w zbiorze.", userInput);
                if(qty != 0) printf("\nLiczba %d wystepuje w zbiorze %d raz(y).", userInput, qty);
                // PAUSE
                printf("\nEnter aby kontynuowac . . .");
                cin.sync(); cin.get();
            } break;
            case 4: {
                printArray(x, 15);
                printf("\nOdchylenie standardowe dla tego zbioru: %.10f", stdDeviation(x, 15));
                // PAUSE
                printf("\nEnter aby kontynuowac . . .");
                cin.sync(); cin.get();
            } break;
            case 5: {
                printf("\nWprowadz ilosc elementow tablicy XX i YY: ");
                cin >> userInput;
                int XX[userInput], YY[userInput], C[4] = {0, 0, 0, 0};
                for(int i = 0; i < userInput; i++){
                    XX[i] = rand() % 20 - 10;
                    YY[i] = rand() % 20 - 10;
                    if(XX[i] > 0 && YY[i] > 0) C[0]++;
                    if(XX[i] < 0 && YY[i] > 0) C[1]++;
                    if(XX[i] < 0 && YY[i] < 0) C[2]++;
                    if(XX[i] > 0 && YY[i] < 0) C[3]++;
                    printf("(%d, %d)\n", XX[i], YY[i]);
                }
                printf("\nC --> ");
                printArray(C, 4);
                printf("\nCwiartka I: %d", C[0]);
                printf("\nCwiartka II: %d", C[1]);
                printf("\nCwiartka III: %d", C[2]);
                printf("\nCwiartka IV: %d", C[3]);
                // PAUSE
                printf("\nEnter aby kontynuowac . . .");
                cin.sync(); cin.get();
            } break;
            case 0: {
                return 0;
            }
        }
    }

    return 0;
}

void readArray(int* addr, int len){
    for(int i = 0; i < len; i++){
        cin >> *(addr + i);
    }
}

void printArray(int* addr, int len){
    printf("Elementy tablicy: %d", *addr);
    for(int i = 1; i < len; i++){
        printf(", %d", *(addr + i));
    }
}

int sum(int tab[], int len){
    int sum = 0;
    for(int i = 0; i < len; i++){
        if(tab[i] > 0) sum += tab[i];
    }
    return sum;
}

float avg(int tab[], int len){
    float sum = 0;
    int n = 0;
    for(int i = 0; i < len; i++){
        if(tab[i] < 0){
            sum += tab[i];
            n++;
        }
    }
    return (float)sum / n;
}

tuple<int, int> minAndQty(int* addr, int len){
    int min = *addr;
    int qty = 0;
    for(int i = 1; i < len; i++){
        if(*(addr + i) < min) min = *(addr + i);
    }
    for(int i = 0; i < len; i++){
        if(*(addr + i) == min) qty++;
    }
    return make_tuple(min, qty);
}

int countInArray(int tab[], int len, int input){
    int qty = 0;
    for(int i = 0; i < len; i++){
        if(tab[i] == input) qty++;
    }
    return qty;
}

double stdDeviation(int tab[], int len){
    double sr = 0, sum = 0;
    for(int i = 0; i < len; i++){
        sr += tab[i];
    }
    sr /= len;
    for(int i = 0; i < len; i++){
        sum += pow((tab[i] - sr), 2);
    }
    return sqrt(sum / len);
}