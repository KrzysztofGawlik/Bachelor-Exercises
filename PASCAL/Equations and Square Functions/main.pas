{
 AiSD_34 Gawlik Krzysztof 147762 20/21 Informatyka 1 v.01
}
unit Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls, Math;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button_Info: TButton;
    Button_Koniec: TButton;
    Button_Dodawanie: TButton;
    Button_Oblicz_Rownanie: TButton;
    Button_Oblicz_Funkcje: TButton;
    Edit_a: TEdit;
    Edit_b: TEdit;
    Edit_c: TEdit;
    Edit_xmin: TEdit;
    Edit_xmax: TEdit;
    Edit_dokladnosc: TEdit;
    ListBox_Wartosci: TListBox;
    Memo_Wyniki: TMemo;
    PaintBox_Wykres: TPaintBox;
    RadioButton_X: TRadioButton;
    RadioButton_Y: TRadioButton;
    RadioGroup_Skala: TRadioGroup;
    StaticText1: TStaticText;
    StaticText10: TStaticText;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    StaticText4: TStaticText;
    StaticText5: TStaticText;
    StaticText6: TStaticText;
    StaticText7: TStaticText;
    StaticText8: TStaticText;
    StaticText9: TStaticText;
    procedure Button_DodawanieClick(Sender: TObject);
    procedure Button_InfoClick(Sender: TObject);
    procedure Button_KoniecClick(Sender: TObject);
    procedure Button_Oblicz_FunkcjeClick(Sender: TObject);
    procedure Button_Oblicz_RownanieClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;
  i, wx0, wx1, wy0, wy1, scale, hShift, vShift, licznikPowtorzen : Integer;
  a, b, c, delta, x1, x2, xMin, xMax, x, srodek, mz, dokladnosc : Double;
  tabWartosci : Array[0..512,0..1] of Real;

const
  N = 1000000;
  S = 0.123456789;

implementation

{$R *.lfm}

{ TForm1 }

procedure zapiszWyniki(fx : Integer);
begin
  // Zapis wynikow do tablicy
    for i := 0 to 512 do
      begin
        // Skok jest rowny zakresowi xMin do xMax / 512
        x := xMin + i * ((xMax - xMin) / 512);

        // Tablicowanie wartosci
        tabWartosci[i,0] := x;
        if (fx = 0) then
          tabWartosci[i,1] := a * (x ** 2) + b * x + c
        else if (fx = 1) then
          tabWartosci[i,1] := Power(x,3) - 3*Power(x,2) + 2*x - 6;

        Form1.ListBox_Wartosci.Items.Add(IntToStr(i) + ': ' + FloatToStr(tabWartosci[i,0]) +
          ' ' + FloatToStr(tabWartosci[i,1]));

        if (i = 256) then hShift := Round(tabWartosci[i,0])
      end;
end;

procedure rysujWykres(fx : Integer);
begin
  // Rysowanie wykresu
    Form1.PaintBox_Wykres.Canvas.Pen.Color := clBlack;
    Form1.PaintBox_Wykres.Canvas.Rectangle(0, 0, Form1.PaintBox_Wykres.Width, Form1.PaintBox_Wykres.Height);
    // Obliczanie skali
    if (fx = 0) then
    scale := Round( 512 / (Max(tabWartosci[170,0], tabWartosci[340,0]) - Min(tabWartosci[170,0], tabWartosci[340,0])) / 3 )
    else if (fx = 1) then
    scale := 10;

    hShift := Round(256 - (tabWartosci[256,0] * scale));
    vShift := 110;
    for i := 0 to 511 do
      begin
        wx0 := Round(tabWartosci[i, 0] * scale);
        wx1 := Round(tabWartosci[i, 1] * scale);
        wy0 := Round(tabWartosci[i + 1, 0] * scale);
        wy1 := Round(tabWartosci[i + 1, 1] * scale);
        // Rysowanie osi X i Y
        Form1.PaintBox_Wykres.Canvas.Pen.Color := clBlue;
        Form1.PaintBox_Wykres.Canvas.Line(0, 220 - vShift, 512, 220 - vShift);
        Form1.PaintBox_Wykres.Canvas.Line(hShift, 0, hShift, 220);
        // Odbicie pionowe: 220-w_1 (220 = wysokosc PaintBoxa)
        // (0,0) znajduje sie po odbiciu w lewym dolnym (nie gornym - domyslnie) rogu
        Form1.PaintBox_Wykres.Canvas.Pen.Color := clRed;
        Form1.PaintBox_Wykres.Canvas.Line(wx0 + hShift, (220-wx1) - vShift, wy0 + hShift, (220-wy1) - vShift);
      end;
end;

function f(x : Double) : Double;
begin
  f := (Power(x,3)) - (3*Power(x,2)) + (2*x) - 6;
end;

procedure obliczFunkcje();
begin
  if (licznikPowtorzen >= 1000) then
  begin
    Application.MessageBox('Uwaga', PChar('Osiagnieto limit powtorzen! Operacja przerwana.'));
    Exit;
  end;
  Inc(licznikPowtorzen);
  a := xMin;
  b := xMax;
  if (f(a) = 0.0) then
    begin
      mz := a;
      Exit;
    end
  else if (f(b) = 0.0) then
    begin
      mz := b;
      Exit;
    end
  else
    begin
      srodek := (a + b) / 2;
      if (b - a <= dokladnosc) then
        begin
          mz := srodek;
        end
      else if (f(a) * f(srodek) < 0) then
        begin
          xMax := srodek;
          obliczFunkcje();
        end
      else
        begin
          xMin := srodek;
          obliczFunkcje();
        end
    end;
end;

// Przycisk - Info
procedure TForm1.Button_InfoClick(Sender: TObject);
begin
  Application.MessageBox('AiSD_34 Gawlik Krzysztof 147762 20/21 Informatyka 1 v.01',PChar('Informacja'));
end;

// SINGLE - dodawanie
procedure dodawanie();
var
  suma, iloczyn : Single;
begin
  suma := 0.0;
  for i := 1 to N do
    suma := suma + S;
    iloczyn := N * S;
  Form1.Memo_Wyniki.Append('DODAWANIE (SINGLE)');
  Form1.Memo_Wyniki.Append('Suma: ' + FloatToStr(suma));
  Form1.Memo_Wyniki.Append('Iloczyn: ' + FloatToStr(iloczyn));
  Form1.Memo_Wyniki.Append('Roznica (Iloczyn - suma): ' + FloatToStr(iloczyn - suma));
  Form1.Memo_Wyniki.Append('Rozmiar (suma, iloczyn): ' + IntToStr(SizeOf(suma)) + ', ' + IntToStr(SizeOf(Iloczyn)));
end;

// SINGLE - sumowanie parami
procedure sumowanieParami();
var
  suma, sumaA, sumaB, iloczyn : Single;
begin
  suma := 0.0;
  sumaA := 0.0;
  sumaB := 0.0;

  for i := 1 to N do
    begin
      if (i mod 2 = 0) then
      sumaA := sumaA + S;
    end;

  for i := 1 to N do
    begin
      if (i mod 2 <> 0) then
      sumaB := sumaB + S;
    end;

  suma := sumaA + sumaB;
  iloczyn := N * S;
  Form1.Memo_Wyniki.Append('SUMOWANIE PARAMI (SINGLE)');
  Form1.Memo_Wyniki.Append('Suma: ' + FloatToStr(suma));
  Form1.Memo_Wyniki.Append('Iloczyn: ' + FloatToStr(iloczyn));
  Form1.Memo_Wyniki.Append('Roznica (Iloczyn - suma): ' + FloatToStr(iloczyn - suma));
  Form1.Memo_Wyniki.Append('Rozmiar (suma, iloczyn): ' + IntToStr(SizeOf(suma)) + ', ' + IntToStr(SizeOf(Iloczyn)));
end;

// SINGLE - sumowanie z poprawkami
procedure sumowaniePoprawki();
var
  suma, sumaA, poprawka, iloczyn : Single;
begin
  suma := 0.0; poprawka := 0.0;
  for i := 1 to N do
   begin
     sumaA := suma + S;
     poprawka := suma - sumaA + S + poprawka;
     suma := sumaA
   end;
  suma := sumaA + poprawka;
  iloczyn := N * S;
  Form1.Memo_Wyniki.Append('SUMOWANIE Z POPR (SINGLE)');
  Form1.Memo_Wyniki.Append('Suma: ' + FloatToStr(suma));
  Form1.Memo_Wyniki.Append('Iloczyn: ' + FloatToStr(iloczyn));
  Form1.Memo_Wyniki.Append('Roznica (Iloczyn - suma): ' + FloatToStr(iloczyn - suma));
  Form1.Memo_Wyniki.Append('Rozmiar (suma, iloczyn): ' + IntToStr(SizeOf(suma)) + ', ' + IntToStr(SizeOf(Iloczyn)));
end;

// REAL - dodawanie
procedure dodawanie_R();
var
  suma, iloczyn : Real;
begin
  suma := 0.0;
  for i := 1 to N do
    suma := suma + S;
    iloczyn := N * S;
  Form1.Memo_Wyniki.Append('DODAWANIE (REAL)');
  Form1.Memo_Wyniki.Append('Suma: ' + FloatToStr(suma));
  Form1.Memo_Wyniki.Append('Iloczyn: ' + FloatToStr(iloczyn));
  Form1.Memo_Wyniki.Append('Roznica (Iloczyn - suma): ' + FloatToStr(iloczyn - suma));
  Form1.Memo_Wyniki.Append('Rozmiar (suma, iloczyn): ' + IntToStr(SizeOf(suma)) + ', ' + IntToStr(SizeOf(Iloczyn)));
end;

// REAL - sumowanie parami
procedure sumowanieParami_R();
var
  suma, sumaA, sumaB, iloczyn : Real;
begin
  suma := 0.0;
  sumaA := 0.0;
  sumaB := 0.0;

  for i := 1 to N do
    begin
      if (i mod 2 = 0) then
      sumaA := sumaA + S;
    end;

  for i := 1 to N do
    begin
      if (i mod 2 <> 0) then
      sumaB := sumaB + S;
    end;

  suma := sumaA + sumaB;
  iloczyn := N * S;
  Form1.Memo_Wyniki.Append('SUMOWANIE PARAMI (REAL)');
  Form1.Memo_Wyniki.Append('Suma: ' + FloatToStr(suma));
  Form1.Memo_Wyniki.Append('Iloczyn: ' + FloatToStr(iloczyn));
  Form1.Memo_Wyniki.Append('Roznica (Iloczyn - suma): ' + FloatToStr(iloczyn - suma));
  Form1.Memo_Wyniki.Append('Rozmiar (suma, iloczyn): ' + IntToStr(SizeOf(suma)) + ', ' + IntToStr(SizeOf(Iloczyn)));
end;

// REAL - sumowanie z poprawkami
procedure sumowaniePoprawki_R();
var
  suma, sumaA, poprawka, iloczyn : Real;
begin
  suma := 0.0; poprawka := 0.0;
  for i := 1 to N do
   begin
     sumaA := suma + S;
     poprawka := suma - sumaA + S + poprawka;
     suma := sumaA
   end;
  suma := sumaA + poprawka;
  iloczyn := N * S;
  Form1.Memo_Wyniki.Append('SUMOWANIE Z POPR (REAL)');
  Form1.Memo_Wyniki.Append('Suma: ' + FloatToStr(suma));
  Form1.Memo_Wyniki.Append('Iloczyn: ' + FloatToStr(iloczyn));
  Form1.Memo_Wyniki.Append('Roznica (Iloczyn - suma): ' + FloatToStr(iloczyn - suma));
  Form1.Memo_Wyniki.Append('Dlugosc (suma, iloczyn): ' + IntToStr(SizeOf(suma)) + ', ' + IntToStr(SizeOf(Iloczyn)));
end;

// Przycisk - Dodawanie
procedure TForm1.Button_DodawanieClick(Sender: TObject);
begin
  Memo_Wyniki.Clear();
  dodawanie();
  sumowanieParami();
  sumowaniePoprawki();
  dodawanie_R();
  sumowanieParami_R();
  sumowaniePoprawki_R();
end;

// Przycisk - Koniec
procedure TForm1.Button_KoniecClick(Sender: TObject);
begin
  Application.Terminate();
end;

// Przycisk - Oblicz funkcje
procedure TForm1.Button_Oblicz_FunkcjeClick(Sender: TObject);
begin
  Memo_Wyniki.Clear;
  ListBox_Wartosci.Items.Clear;
  licznikPowtorzen := 0;
  // Sprawdzenie bledu konwersji
  try
    xMin := StrToFloat(Edit_xmin.Text);
    xMax := StrToFloat(Edit_xmax.Text);
    dokladnosc := StrToFloat(Edit_dokladnosc.Text);
  except
    Application.MessageBox('Blad konwersji',PChar('Uwaga'));
    Exit;
  end;
  obliczFunkcje();
  Memo_Wyniki.Append('Miejsce zerowe: ' + FloatToStr(mz) + ' / Iteracje: ' + IntToStr(licznikPowtorzen));
  xMin := StrToFloat(Edit_xmin.Text);
  xMax := StrToFloat(Edit_xmax.Text);
  zapiszWyniki(1);
  rysujWykres(1);
end;

// Przycisk - Oblicz rownanie kwadratowe
// Procedura wylicza wartosci funkcji od xMin do xMax
procedure TForm1.Button_Oblicz_RownanieClick(Sender: TObject);
begin
  Memo_Wyniki.Clear;
  ListBox_Wartosci.Items.Clear;
  // Sprawdzenie bledu konwersji
  try
    a := StrToFloat(Edit_A.Text);
    b := StrToFloat(Edit_B.Text);
    c := StrToFloat(Edit_C.Text);
  except
    Application.MessageBox('Blad konwersji',PChar('Uwaga'));
    Exit;
  end;
  // Sprawdzenie bledu a = 0
  if (a = 0) then
    begin
      Application.MessageBox('Wartosc "a" nie moze byc rowna 0!', Pchar('Uwaga'));
      Exit;
    end
  else
  // Obliczenie delty, wyznaczanie miejsc zerowych i zakresu
    begin
      delta := (b ** 2) - 4 * a * c;
      if (delta < 0) then
        begin
          Memo_Wyniki.Append('brak rozwiazan');
          zapiszWyniki(0);
          rysujWykres(0);
          Exit;
        end
      else if (delta = 0) then
        begin
          x1 := -b / (2 * a);
          Memo_Wyniki.Append('x1 = ' + FloatToStr(x1));
          zapiszWyniki(0);
          rysujWykres(0);
          Exit;
        end
      else
        begin
          x1 := (-b - Sqrt(delta)) / (2 * a);
          x2 := (-b + Sqrt(delta)) / (2 * a);
          xMin := Min(x1, x2) - (Max(x1, x2) - Min(x1, x2));
          xMax := Max(x1, x2) + (Max(x1, x2) - Min(x1, x2));
          Memo_Wyniki.Append('x1 = ' + FloatToStr(x1));
          Memo_Wyniki.Append('x2 = ' + FloatToStr(x2));
          zapiszWyniki(0);
          rysujWykres(0);
          Exit();
        end;
    end;
end;

end.

