/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <cstdlib>
#include <ctime>
#include <iomanip>
using namespace std;

float customRandom();
void printMatrix(float* tab, int c, int r);
float avgBelowDiagonal(float* tab, int c, int r);
void sumVertical(float* tab, int c, int r, float* results);
void maxHorizontal(float * tab, int c, int r, float* results);

int main(){
    srand((unsigned) time(0));

    float a[8][8];
    float b[8][5];
    float c[8];
    float d[5];

    for(int i = 0; i < 8; i++){
        for(int j = 0; j < 8; j++){
            a[i][j] = customRandom();
        }
    }

    for(int i = 0; i < 8; i++){
        for(int j = 0; j < 5; j++){
            b[i][j] = customRandom();
        }
    }

    cout << "Macierz A:" << endl << "==================================" << endl;
    printMatrix(*a, 8, 8);
    cout << "Macierz B:" << endl << "==================================" << endl;
    printMatrix(*b, 8, 5);

    cout << "Srednia z liczb ponizej glownej przekatnej w macierzy A: "
         << avgBelowDiagonal(*a, 8, 8) << endl << endl;

    sumVertical(*b, 8, 5, c);
    cout << "Sumy kolumn w macierzy B:" << endl
         << "==================================" << endl;
    printMatrix(c, 5, 1);

    maxHorizontal(*b, 8, 5, d);
    cout << "Maksymalne wartosci w wierszach w macierzy B:" << endl
         << "==================================" << endl;
    for(int i = 0; i < 5; i++){
        cout << "Wiersz " << i+1 << ". -- " << d[i] << endl;
    }

    return 0;
}

float customRandom(){
    return (float) (rand() % 50) / 10;
}

void printMatrix(float* tab, int c, int r){
    for(int i = 0; i < r; i++){
        for(int j = 0; j < c; j++){
            cout << setw(6) << *(tab + (i*c) + j);
        }
        cout << endl;
    }
    cout << endl;
}

float avgBelowDiagonal(float* tab, int c, int r){
    float sum = 0;
    int elements = 0;
    for(int i = 0; i < r; i++){
        for(int j = 0; j < i; j++){
            sum += *(tab + (i*c) + j);
            elements++;
        }
    }
    return sum / elements;
}

void sumVertical(float* tab, int c, int r, float* results){
    for(int i = 0; i < c; i++){
        float sum = 0;
        for(int j = 0; j < r; j++){
            sum += *(tab + (j*c) + i);
        }
        *(results + i) = sum;
    }
}

void maxHorizontal(float * tab, int c, int r, float* results){
    float max, current;
    for(int i = 0; i < r; i++){
        max = -1;
        for(int j = 0; j < c; j++){
            current = *(tab + (i*c) + j);
            if(current > max)
            max = current;
        }
        *(results + i) = max;
    }
}