/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <ctime>
using namespace std;

pair<float, int> sredniaPrzez3(int* tab, int size);
void wypelnijLosowo(int tab[][5], int p, int k, int size);
pair<int, int> sumaNiep(int tab[][5], int n);

void zadanie1();
void zadanie2();

int main(){
    cout << setprecision(2);
    cout << fixed;
    int wybor;
    bool petla = true;

    while(petla){
        cout << "-------------------------" << endl;
        cout << "Wybierz numer zadania:" << endl;
        cout << "\t[1] Zadanie 1." << endl;
        cout << "\t[2] Zadanie 2." << endl;
        cout << "\t[0] Wyjscie." << endl;
        cin >> wybor;

        if(wybor == 0){
            petla = false;
            break;
        }else if(wybor == 1){
            zadanie1();
        }else if(wybor == 2){
            zadanie2();
        } else {
            cout << "Nie ma takiej opcji: ";
        }
        cout << "Enter aby kontynuowac . . ." << endl;
        cin.sync(); cin.get();
    }
    
    return 0;
}

void zadanie1(){
    int C[4] = { -2, 3, -5, 6 }, D[6] = { -2, 3, 4, 6, -88 , 99};
    float srednia;
    int ilosc;
    pair<float, int> para;
    
    // Wypisywanie tablic
    cout << "Tablica C:" << endl << "--------------------------------" << endl;
    for(int i = 0; i < 4; i++){
        cout << C[i] << ", ";
    }
    cout << endl << endl;
    cout << "Tablica D:" << endl << "--------------------------------" << endl;
    for(int i = 0; i < 6; i++){
        cout << D[i] << ", ";
    }
    cout << endl;

    cout << endl << "Srednia elementow podzielnych przez 3 w tablicy:" << endl;

    para = sredniaPrzez3(C, 4);
    cout << "\tC : " << para.first << " (" << para.second << " elem.)" << endl;
    para = sredniaPrzez3(D, 6);
    cout << "\tD : " << para.first << " (" << para.second << " elem.)" << endl;
}

void zadanie2(){
    int A[6][5], B[7][5];
    srand((unsigned) time(0));
    int p = -10, k = 25;
    pair<int, int> para;

    // Wypelnianie tablic
        wypelnijLosowo(A, p, k, 6);
        wypelnijLosowo(B, p, k, 7);

    cout << endl;
    // Wypisywanie tablic
    for(int i = 0; i < 6; i++){
        for(int j = 0; j < 5; j++){
            cout << A[i][j] << ", ";
        }
        cout << endl;
    }
    cout << endl << endl;
    for(int i = 0; i < 7; i++){
        for(int j = 0; j < 5; j++){
            cout << B[i][j] << ", ";
        }
        cout << endl;
    }

    cout << endl;

    para = sumaNiep(A, 6);
    cout << "Suma elem nieparzystych w tablicy A: " << para.first << " (ilosc: " << para.second << ")" << endl;
    para = sumaNiep(B, 7);
    cout << "Suma elem nieparzystych w tablicy B: " << para.first << " (ilosc: " << para.second << ")" << endl;
    cout << endl;
}

pair<float, int> sredniaPrzez3(int* tab, int size){
    int suma = 0;
    int n = 0;
    for(int i = 0; i < size; i++){
        if(*(tab + i) % 3 == 0){
            suma += *(tab + i);
            n++;
        }
    }
    return make_pair((float) suma/n, n);
}

void wypelnijLosowo(int tab[][5], int p, int k, int size){
    for(int i = 0; i < size; i++){
        for(int j = 0; j < 5; j++){
            tab[i][j] = rand() % (k - p + 1) + p;
        }
    }
}

pair<int, int> sumaNiep(int tab[][5], int n){
    int suma = 0, qty = 0;
    for(int i = 0; i < n; i++){
        for(int j = 0; j < 5; j++){
            if(abs(tab[i][j] % 2) == 1){
                suma += tab[i][j];
                qty++;
            }
        }
    }
    return make_pair(suma, qty);
}