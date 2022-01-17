/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <iomanip>
#include <algorithm>
using namespace std;

void fillRandom(int* tab, int size, int min, int max);
void printArray(int* tab, int size);
void fillWithMax(int* tab, int size, int* t1, int* t2, int* t3);
float average(int* tab, int size);
int countHigher(int* tab, int size, float num);

int main(){
    srand((unsigned) time(0));

    int n, p, k, higherNums;
    float avg;

    cout << "Podaj rozmiar tablic:" << endl;
    cin >> n;
    cout << "Podaj dolna granice losowania:" << endl;
    cin >> p;
    cout << "Podaj gorna granice losowania:" << endl;
    cin >> k;

    int x[n], y[n], z[n], q[n];
    
    fillRandom(x, n, p, k);
    fillRandom(y, n, p, k);
    fillRandom(z, n, p, k);

    cout << endl << "TABLICA X" << endl;
    printArray(x, n);
    cout << endl << "TABLICA Y" << endl;
    printArray(y, n);
    cout << endl << "TABLICA Z" << endl;
    printArray(z, n);

    fillWithMax(q, n, x, y, z);
    cout << endl << "TABLICA Q (max z X, Y i Z)" << endl;
    printArray(q, n);

    cout << endl;
    avg = average(x, n);
    higherNums = countHigher(x, n, avg);
    cout << "Srednia z tablicy X: " << avg
         << " (elementow wiekszych od sredniej: " << higherNums << ")" << endl;

    int * xd = new int[higherNums];
    int ind = 0;
    for(int i = 0; i < n; i++){
        //cout << "X! --> " << x[i] << " compare to " << avg << endl;
        if(x[i] > avg){
            xd[ind] = x[i];
            ind++;
        }
    }

    cout << endl << "TABLICA XD (elementy z tablicy X wieksze od sredniej)" << endl;
    for(int i = 0; i < higherNums; i++){
        if(i == higherNums-1) cout << xd[i] << endl;
        else cout << xd[i] << ", ";
    }

    delete [] xd;

    return 0;
}

void fillRandom(int* tab, int size, int min, int max){
    for(int i = 0; i < size; i++){
        *(tab + i) = rand() % (max - min + 1) + min;
    }
}

void printArray(int* tab, int size){
    cout << "=======================================" << endl;
    for (int i = 0; i < size; i++){
        if ((i + 1) % 6 == 0) cout << " " << setw(5) << tab[i] << endl;
        else cout << " " << setw(5) << tab[i];
    }
    cout << endl;
}

void fillWithMax(int* tab, int size, int* t1, int* t2, int* t3){
    for(int i = 0; i < size; i++){
        *(tab + i) = max(*(t1+i), max(*(t2+i), *(t3+i)));
    }
}

float average(int* tab, int size){
    float sum;
    for(int i = 0; i < size; i++){
        sum += *(tab+i);
    }
    return (float) sum / size;
}

int countHigher(int* tab, int size, float num){
    int count = 0;
    for(int i = 0; i < size; i++){
        if(*(tab+i) > num) count++;
    }
    return count;
}