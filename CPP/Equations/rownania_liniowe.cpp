/*
    GAWLIK KRZYSZTOF
    Indeks: 147762
*/
#include <iostream>
#include <cmath>
using namespace std;

void wyswietlMacierz(float** macierz, int rozmiar);

int main(){

    int rozmiar;
    float **macierz, *niewiadoma, div, p;
    
    printf("\nPodaj ile niewiadomych:\n");
    cin >> rozmiar;
    if(rozmiar > 16 || rozmiar < 1){
        printf("\nNieprawidlowy rozmiar - poprawny 1 .. 16");
        return 0;
    }

    niewiadoma = new float[rozmiar];
    macierz = new float*[rozmiar];

    printf("\nWpisz macierz: \n");
    for(int i = 0; i < rozmiar; i++){
        macierz[i] = new float[rozmiar + 1];
    }

    // POBIERZ MACIERZ
    for(int i = 0; i < rozmiar; i++){
        for(int j = 0; j <= rozmiar; j++){
            cin >> macierz[i][j];
        }
    }

    printf("\nPobrana macierz: \n");
    wyswietlMacierz(macierz, rozmiar);

    for(int i = 0; i < rozmiar; i++){
        for(int j = i + 1; j < rozmiar; j++){
            if(abs(macierz[i][i]) < abs(macierz[j][i])){
                for(int k = 0; k <= rozmiar; k++){
                    p = macierz[i][k];
                    macierz[i][k] = macierz[j][k];
                    macierz[j][k] = p;
                }
            }
        }
    }

    // GAUSS
    for(int i = 0; i < rozmiar - 1; i++){
        for(int j = i + 1; j < rozmiar; j++){
            div = macierz[j][i] / macierz[i][i];
            for(int k = 0; k <= rozmiar; k++){
                macierz[j][k] -= div * macierz[i][k];
            }
        }
    }

    printf("\nMacierz wynikowa: \n");
    wyswietlMacierz(macierz, rozmiar);

    // OBLICZENIA
    for(int i = rozmiar - 1; i >= 0; i--){
        niewiadoma[i] = macierz[i][rozmiar];
        for(int j = i + 1; j < rozmiar; j++){
            if(j != i){
                niewiadoma[i] -= macierz[i][j] * niewiadoma[j];
            }
        }
        niewiadoma[i] /= macierz[i][i];
    }

    // WYNIKI
    printf("\nRozwiazanie: \n");
    for(int i = 0; i < rozmiar; i++){
        printf("\tx%d = %g\n", i, niewiadoma[i]);
    }

    printf("\nWcisnij dowolny przycisk aby zakonczyc...");
    cin.sync(); cin.get();

    return 0;
}

void wyswietlMacierz(float** macierz, int rozmiar){
    for(int i = 0; i < rozmiar; i++){
        for(int j = 0; j <= rozmiar; j++){
            printf("%g\t", macierz[i][j]);
        }
        printf("\n");
    }
}