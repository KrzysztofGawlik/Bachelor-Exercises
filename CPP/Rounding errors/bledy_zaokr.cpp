#include <iostream>
using namespace std;

void addFloat(float podstawa, float skladnik, int warunek) {
    printf("Pojedyncza precyzja - float:\n");
    printf("\tLiczba poczatkowa: %f\n\tLiczba dodawana: %f\n\tIlosc powtorzen: %i\n", podstawa, skladnik, warunek);
    
   for(int i = 0; i < warunek; i++) {
       podstawa = podstawa + skladnik;
   }
   
   printf("\tWynik: %f\n", podstawa);
}

void addDouble(double podstawa, double skladnik, int warunek) {
    printf("Podwojna precyzja - double:\n");
    printf("\tLiczba poczatkowa: %f\n\tLiczba dodawana: %f\n\tIlosc powtorzen: %i\n", podstawa, skladnik, warunek);
    
   for(int i = 0; i < warunek; i++) {
       podstawa = podstawa + skladnik;
   }
   
   printf("\tWynik: %f\n", podstawa);
}

int main()
{
    addFloat(365, 0.00024, 3000);
    printf("---------------------------------------------\n");
    addDouble(365, 0.00024, 3000);

    return 0;
}
