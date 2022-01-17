/* 
  UWAGA !!!
  Aby program działał prawidłowo, wczytując listę studentów z pliku
  należy odpowiednio go przygotować, wg wzoru:
  nazwisko ocena_1 ocena_2 ocena_3 ocena_4 ocena_5
  nazwisko ocena_1 ... ocena_5
  ...
  W pliku powinno znajdować się tylu studentów, ilu podajemy na
  początku programu.
*/
#include <iostream>
#include <string>
#include <ctime>
#include <cstdlib>
#include <iomanip>
#include <fstream>

using namespace std;

struct student{
  std:: string nazwisko;
  float ocena[5];
  float srednia;

};

void readFromFile(student Tab1[], int n);
void readFromUser(student Tab1[], int n, float* zakres);
void printStudents(student Tab1[], int n);
void printStudent(student Tab1[], int n, string surname);
string checkStudent(student Tab1[], int n);
void saveToFile(student Tab1[], int n, string filename);
void recalculateAverage(student Tab1[], int id);
void changeGrade(student Tab1[], int n);
void checkAboveAverage(student Tab1[], int n);

int main()
{
  srand((unsigned) time(0));
  int n, random;
  float srednia;
  float zakres[] = {2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0};
  string surname;

  cout << "Podaj liczbe studentow:" << endl;
  cin >> n;
  student Tab1[n];

  string upload;
  cout << "Czy chcesz wczytac studentow z pliku 'ex_3_students.txt'? tak/nie" << endl;
  cin >> upload;

  if(upload == "tak"){
    readFromFile(Tab1, n);
  } else {
    readFromUser(Tab1, n, zakres);
  }

  printStudents(Tab1, n);

  checkAboveAverage(Tab1, n);

  cout << endl << "--- Wyswietlenie danych ---" << endl;
  surname = checkStudent(Tab1, n);
  printStudent(Tab1, n, surname);

  cout << endl << "--- Zmiana oceny ---" << endl;

  changeGrade(Tab1, n);

  saveToFile(Tab1, n, "ex_3_students_output.txt");

  cout << endl << "Koniec dzialania programu.";

  return 0;

}

void readFromFile(student Tab1[], int n){
  fstream my_file;
  my_file.open("ex_3_students.txt");
    for(int i = 0; i < n; i++){
      float suma;
      my_file >> Tab1[i].nazwisko;
      suma = 0;
      for(int j = 0; j < 5; j++){
      my_file >> Tab1[i].ocena[j];
      suma += Tab1[i].ocena[j];
    }
    Tab1[i].srednia = (suma / 5);
  }
  my_file.close();
}

void readFromUser(student Tab1[], int n, float* zakres){
  int random;
  for(int i = 0; i < n; i++){
    float suma;
    cout << "Nazwisko studenta:" << endl;
    cin >> Tab1[i].nazwisko;
    suma = 0;
    for(int j = 0; j < 5; j++){
      random = rand() % 7 + 0;
      Tab1[i].ocena[j] = zakres[random];
      suma += Tab1[i].ocena[j];
    }
    Tab1[i].srednia = (suma / 5);
  }
}

void printStudents(student Tab1[], int n){
  cout << endl << "----------------------------" << endl;
  for(int i = 0; i<n; i++){
    cout << Tab1[i].nazwisko << endl << "Oceny: ";
      for(int j = 0; j < 5; j++){
        cout << Tab1[i].ocena[j] << ", ";
      }
    cout << endl << "Srednia: " << setprecision(2) << Tab1[i].srednia << endl;
    cout << "----------------------------" << endl;
  }
}

void printStudent(student Tab1[], int n, string surname){
  cout << endl << "----------------------------" << endl;
  for(int i = 0; i<n; i++){
    if(Tab1[i].nazwisko == surname){
      cout << Tab1[i].nazwisko << endl << "Oceny: ";
      for(int j = 0; j < 5; j++){
        cout << Tab1[i].ocena[j] << ", ";
      }
      cout << endl << "Srednia: " << setprecision(2) << Tab1[i].srednia << endl;
      cout << "----------------------------" << endl;
    }
  }
}

string checkStudent(student Tab1[], int n){
  string surname;
  bool nieobecny = true;
  while(nieobecny){
    cout<<"Podaj nazwisko ucznia:"<<endl;
    cin >> surname;
    for(int i = 0; i < n; i++){
      if(Tab1[i].nazwisko == surname){
        nieobecny = false;
      }
    }
    if(nieobecny)
      cout << endl << "Nie znaleziono ucznia o tym nazwisku... Sprobuj ponownie." << endl;
  }
  return surname;
}

void saveToFile(student Tab1[], int n, string filename){
  string upload;
  cout << endl << "Czy chcesz zapisac dane do pliku? tak/nie" << endl;
  cin >> upload;
  if(upload == "tak"){
    fstream my_file;
    my_file.open(filename, ios::in | ios::out | ios::trunc);

    for(int i = 0; i<n; i++){
      my_file << "Nazwisko: " << Tab1[i].nazwisko << endl << "Oceny: ";
      for(int j = 0; j < 5; j++){
      my_file << Tab1[i].ocena[j] << ", ";
    }
    my_file << endl << "Srednia: " << setprecision(2) << Tab1[i].srednia << endl;
    my_file << "----------------------------" << endl;
  }
  cout << "Zapisano do pliku '" << filename << "'!" << endl;
  my_file.close();
  }
}

void recalculateAverage(student Tab1[], int id){
  float sum;
    for(int j = 0; j < 5; j++){
      sum += Tab1[id].ocena[j];
    }
    Tab1[id].srednia = sum / 5;
}

void changeGrade(student Tab1[], int n){
  string koniec = "nie";
  do{
    string surname = checkStudent(Tab1, n);
    int ktoryUczen = 0;
    for(int i = 0; i<n; i++){
      if(Tab1[i].nazwisko == surname){
        ktoryUczen = i;
      break;
      }
    }
    float nowaOcena;
    int ktoraOcena;
    cout<<"Podaj Ocene do zmiany, wybierz od 1 do 5 "<<endl;
    cin>>ktoraOcena;
    ktoraOcena = --ktoraOcena;
    cout<<"Podaj nowa ocene"<<endl;
    cin>>nowaOcena;
    Tab1[ktoryUczen].ocena[ktoraOcena] = nowaOcena;

    recalculateAverage(Tab1, ktoryUczen);
    printStudent(Tab1, n, surname);

  cout<<endl<<"Czy chcesz dalej poprawiac oceny? tak/nie"<<endl;
  cin>>koniec;

  } while(koniec == "tak");
}

void checkAboveAverage(student Tab1[], int n){
  float sumaSrednich = 0.0;
  for(int i = 0; i < n; i++){
    sumaSrednich += Tab1[i].srednia;
  }
  float sredniaAll;
  sredniaAll = sumaSrednich / n;
  cout << "\nSrednia dla grupy wynosi " << sredniaAll << endl;
  int licznik =1;
  int powyzej =0;  // powyzej sredniej
  cout << endl << "Lista studentow powyzej sredniej:"<<endl;
  for(int i = 0; i < n; i++){
    if (Tab1[i].srednia > sredniaAll ){
      cout<<licznik++<<". "<<Tab1[i].nazwisko<<endl;
      powyzej += 1;
    }
  }
  if(powyzej == 0) cout << "\tbrak studentow powyzej sredniej...\n";
  cout<< endl <<"Liczba studentow powyzej sredniej wynosi: "<<powyzej <<endl;

  float maxsrednia = 0;
    for(int i = 0;i < n; ++i){
       if(Tab1[i].srednia > maxsrednia){
          maxsrednia = Tab1[i].srednia;
       }
    }

    cout << endl << "Student o najwyzszej sredniej:\n";

    for(int i = 0;i < n; ++i)
    {
       if(Tab1[i].srednia == maxsrednia){
           cout << Tab1[i].nazwisko << endl;
           cout<< "Jego srednia: "<< Tab1[i].srednia << endl;
       }
    }
}