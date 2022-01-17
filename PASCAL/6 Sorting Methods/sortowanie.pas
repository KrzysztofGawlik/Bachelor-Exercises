{

 AiSD_5 Gawlik Krzysztof 147762 20/21 Informatyka 1 v.01

 *** UWAGA ***
 Program zgodnie z wytycznymi dokonuje sortowania juz w tablicy
 z danymi nie posortowanymi. Ponowne klikniecie przycisku
 "Sortowanie ..." spowoduje uruchomienie procedur na posortowanych
 danych!

}

unit Sortowanie;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button_sShell: TButton;
    Button_Kopiuj: TButton;
    Button_Kopiuj_Odwrotnie: TButton;
    Button_Koniec: TButton;
    Button_Info: TButton;
    Button_sS: TButton;
    Button_sPPWyb: TButton;
    Button_sPPWzS: TButton;
    Button_sPPW: TButton;
    Button_sB: TButton;
    Button_Losuj: TButton;
    Edit_Porownania: TEdit;
    Edit_Zamiany: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    ListBox_Dane_Nieposortowane: TListBox;
    ListBox_Dane_Posortowane: TListBox;
    procedure Button_InfoClick(Sender: TObject);
    procedure Button_KoniecClick(Sender: TObject);
    procedure Button_KopiujClick(Sender: TObject);
    procedure Button_Kopiuj_OdwrotnieClick(Sender: TObject);
    procedure Button_LosujClick(Sender: TObject);
    procedure Button_sBClick(Sender: TObject);
    procedure Button_sPPWClick(Sender: TObject);
    procedure Button_sPPWybClick(Sender: TObject);
    procedure Button_sPPWzSClick(Sender: TObject);
    procedure Button_sSClick(Sender: TObject);
    procedure Button_sShellClick(Sender: TObject);
  private

  public

  end;

const
  ROZMIAR_TABLICY = 20;

var
  Form1: TForm1;
  tabLiczb : array[0..ROZMIAR_TABLICY] of integer;
  tabSort : array[0..ROZMIAR_TABLICY] of integer;
  i, gPorownanie, gZamiana : Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure wyswietlLiczby();
begin
  Form1.ListBox_Dane_Nieposortowane.Items.Clear;
  for i := 1 to ROZMIAR_TABLICY do
  begin
    Form1.ListBox_Dane_Nieposortowane.Items.Add(IntToStr(i) + ': ' + IntToStr(tabLiczb[i]));
  end;
end;

procedure kopiujLS();
begin
  for i := 1 to ROZMIAR_TABLICY do
  begin
    tabSort[i] := tabLiczb[i];
  end;
end;

procedure wyswietlPosortowane();
begin
  Form1.ListBox_Dane_Posortowane.Items.Clear;
  for i := 1 to ROZMIAR_TABLICY do
  begin
    Form1.ListBox_Dane_Posortowane.Items.Add(IntToStr(i) + ': ' + IntToStr(tabSort[i]));
  end;
end;

procedure zamien(var a, b : Integer);
var
  p : Integer;
begin
  p := a;
  a := b;
  b := p;
end;

function podziel(start, stop : Integer) : Integer;
var
  lewo, prawo, srodek : Integer;
begin
  srodek := tabLiczb[start];
  lewo := start + 1;
  prawo := stop;
  while lewo <= prawo do
  begin
    while (lewo <= stop) and (tabLiczb[lewo] < srodek) do
    begin
      lewo := lewo + 1;
      Inc(gPorownanie); // Dodaje porownanie gdy spelni sie warunek while
    end;
    Inc(gPorownanie); // Dodaje porownanie gdyby sie nie spelnil warunek while
    while (prawo > start) and (tabLiczb[prawo] >= srodek) do
    begin
      prawo := prawo - 1;
      Inc(gPorownanie); // Dodaje porownanie gdy spelni sie warunek while
    end;
    Inc(gPorownanie); // Dodaje porownanie gdyby sie nie spelnil warunek while
    if lewo < prawo then
      begin
        zamien(tabLiczb[lewo], tabLiczb[prawo]);
        Inc(gZamiana);
      end;
  end;
  zamien(tabLiczb[start], tabLiczb[prawo]);
  Inc(gZamiana);
  podziel := prawo;
end;

procedure ssRekurencja(start, stop : Integer);
var
  znakPodzialu : Integer;
begin
  if start < stop then
  begin
    znakPodzialu := podziel(start, stop);
    ssRekurencja(start, znakPodzialu - 1);
    ssRekurencja(znakPodzialu + 1, stop);
  end;
end;

procedure TForm1.Button_InfoClick(Sender: TObject);
begin
  Application.MessageBox('AiSD_5 Gawlik Krzysztof 147762 20/21 Informatyka 1 v.01',PChar('Informacja'));
end;

procedure TForm1.Button_KoniecClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TForm1.Button_KopiujClick(Sender: TObject);
begin
  for i := 1 to ROZMIAR_TABLICY do
    begin
      tabLiczb[i] := tabSort[i];
    end;
    wyswietlLiczby();
end;

procedure TForm1.Button_Kopiuj_OdwrotnieClick(Sender: TObject);
begin
  for i := 1 to ROZMIAR_TABLICY do
    begin
      tabLiczb[i] := tabSort[21-i];
    end;
    wyswietlLiczby();
end;

procedure TForm1.Button_LosujClick(Sender: TObject);
begin
  ListBox_Dane_Nieposortowane.Clear;
  Randomize;
  for i := 1 to ROZMIAR_TABLICY do
  begin
    tabLiczb[i] := Random(1000);
    ListBox_Dane_Nieposortowane.Items.Add(IntToStr(i) + ': ' + IntToStr(tabLiczb[i]));
  end;
end;

// Sortowanie babelkowe
procedure TForm1.Button_sBClick(Sender: TObject);
var
  porownanie, zamiana, i, j : Integer;
begin
  porownanie := 0;
  zamiana := 0;
  for i := 1 to ROZMIAR_TABLICY-1 do
  begin
    for j := ROZMIAR_TABLICY downto i+1 do
    begin
      if tabLiczb[j - 1] > tabLiczb[j] then
        begin
          zamien(tabLiczb[j-1], tabLiczb[j]);
          inc(zamiana);
        end;
      inc(porownanie);
    end;
  end;
  kopiujLS();
  wyswietlPosortowane();
  Edit_Zamiany.Text := IntToStr(zamiana);
  Edit_Porownania.Text := IntToStr(porownanie);
end;

// Sortowanie przez proste wstawianie
procedure TForm1.Button_sPPWClick(Sender: TObject);
var
  porownanie, zamiana, i, j : Integer;
  koniec : Boolean;
begin
  porownanie := 0;
  zamiana := 0;
  for i := 1 to ROZMIAR_TABLICY-1 do
  begin
    koniec := False;
    j := i + 1;
    repeat
      Inc(porownanie);
      if tabLiczb[j] < tabLiczb[j - 1] then
        begin
          zamien(tabLiczb[j], tabLiczb[j - 1]);
          Inc(zamiana);
          j := j - 1;
        end
      else koniec := True;
    until (j = 1) or koniec;
  end;
  kopiujLS();
  wyswietlPosortowane();
  Edit_Zamiany.Text := IntToStr(zamiana);
  Edit_Porownania.Text := IntToStr(porownanie);
end;

// Sortowanie przez proste wybieranie
procedure TForm1.Button_sPPWybClick(Sender: TObject);
var
  porownanie, zamiana, i, j, iMin : Integer;
begin
  porownanie := 0;
  zamiana := 0;
  for i := 1 to ROZMIAR_TABLICY-1 do
  begin
    iMin := i;
    for j := i to ROZMIAR_TABLICY do
    begin
      Inc(porownanie);
      if tabLiczb[iMin] > tabLiczb[j] then iMin := j;
    end;
    zamien(tabLiczb[i], tabLiczb[iMin]);
    Inc(zamiana);
  end;
  kopiujLS();
  wyswietlPosortowane();
  Edit_Zamiany.Text := IntToStr(zamiana);
  Edit_Porownania.Text := IntToStr(porownanie);
end;

// Sortowanie przez proste wstawianie ze znacznikiem
procedure TForm1.Button_sPPWzSClick(Sender: TObject);
var
  porownanie, zamiana, nowy, i, j : Integer;
begin
  porownanie := 0;
  zamiana := 0;
  for i := 2 to ROZMIAR_TABLICY do
  begin
    nowy := tabLiczb[i];
    tabLiczb[0] := nowy;
    j := i - 1;
    Inc(porownanie);
    while nowy < tabLiczb[j] do
    begin
      tabLiczb[j+1] := tabLiczb[j];
      j := j - 1;
      Inc(zamiana);
    end;
    tabLiczb[j+1] := nowy;
  end;
  kopiujLS();
  wyswietlPosortowane();
  Edit_Zamiany.Text := IntToStr(zamiana);
  Edit_Porownania.Text := IntToStr(porownanie);
  tabLiczb[0] := 0;
  tabSort[0] := 0;
end;

// Sortowanie szybkie
procedure TForm1.Button_sSClick(Sender: TObject);
begin
  gPorownanie := 0;
  gZamiana := 0;
  ssRekurencja(1, ROZMIAR_TABLICY);
  kopiujLS();
  wyswietlPosortowane();
  Edit_Zamiany.Text := IntToStr(gZamiana);
  Edit_Porownania.Text := IntToStr(gPorownanie);
end;

// Sortowanie Shella
procedure TForm1.Button_sShellClick(Sender: TObject);
var
  i, j, krok, tmp, zamiana, porownanie : Integer;
begin
  zamiana := 0;
  porownanie := 0;
  krok := ROZMIAR_TABLICY div 2;
  while krok > 0 do
  begin
    for i := krok to ROZMIAR_TABLICY do
    begin
      tmp := tabLiczb[i];
      j := i;
      Inc(porownanie);
      while (j >= krok) and (tabLiczb[j - krok] > tmp) do
      begin
        Inc(porownanie);
        tabLiczb[j] := tabLiczb[j - krok];
        Inc(zamiana);
        Dec(j, krok);
      end;
      tabLiczb[j] := tmp;
    end;
    krok := krok div 2;
  end;
  kopiujLS();
  wyswietlPosortowane();
  Edit_Zamiany.Text := IntToStr(zamiana);
  Edit_Porownania.Text := IntToStr(porownanie);
end;

end.























