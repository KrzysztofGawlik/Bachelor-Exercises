{
 AiSD_2 Gawlik Krzysztof 147762 20/21 Informatyka 1 v.01
}

unit aisd2;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button_Oblicz: TButton;
    Button_Info: TButton;
    Button_Koniec: TButton;
    Edit_Liczba: TEdit;
    Edit_Powtorzenia: TEdit;
    Edit_Iteracja_Wynik: TEdit;
    Edit_Rekurencja_Wynik: TEdit;
    Edit_Iteracja_Czas: TEdit;
    Edit_Rekurencja_Czas: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    procedure Button_InfoClick(Sender: TObject);
    procedure Button_KoniecClick(Sender: TObject);
    procedure Button_ObliczClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

function Silnia(n : Int64) : Int64;
begin
  if n > 1 then
    Silnia := n * Silnia(n - 1)
  else
    Silnia := 1;
end;

// Done, przycisk INFO
procedure TForm1.Button_InfoClick(Sender: TObject);
  var Message : string;
begin
  Message := 'AiSD_2 Gawlik Krzysztof 147762 20/21 Informatyka 1 v.01' ;
  Application.MessageBox(PChar(Message),'Informacja');
end;

// Done, przycisk KONIEC
procedure TForm1.Button_KoniecClick(Sender: TObject);
begin
  Application.Terminate;
end;

// Done, przycisk OBLICZ
procedure TForm1.Button_ObliczClick(Sender: TObject);
var Podstawa, Silnia_Iteracja, Silnia_Rekurencja, Powtorzenia, Iteracja, i : Int64;
    Czas_Start, Czas_Stop, Czas : TDateTime;
begin
  Podstawa := StrToInt64(Edit_Liczba.Text);
  i := 1;
  Silnia_Iteracja := 1;
  Powtorzenia := StrToInt64(Edit_Powtorzenia.Text);

  // Start ITERACJA
  Czas_Start := Time;
    for Iteracja := 1 to Powtorzenia do
      begin
        i := 1;
        Silnia_Iteracja := 1;
        while i <= Podstawa do
          begin
            Silnia_Iteracja := Silnia_Iteracja * i;
            inc(i);
          end;
      end;
  Czas_Stop := Time;
  Czas := 24 * 60 * 60 * 1000 * (Czas_Stop - Czas_Start);
  Edit_Iteracja_Czas.Text := FloatToStr(Czas);
  Edit_Iteracja_Wynik.Text := FloatToStr(Silnia_Iteracja);

  // Start REKURENCJA
  Czas_Start := Time;
    for Iteracja := 1 to Powtorzenia do
      begin
        Silnia_Rekurencja := Silnia(Podstawa);
      end;
  Czas_Stop := Time;
  Czas := 24 * 60 * 60 * 1000 * (Czas_Stop - Czas_Start);
  Edit_Rekurencja_Czas.Text := FloatToStr(Czas);
  Edit_Rekurencja_Wynik.Text := FloatToStr(Silnia_Rekurencja);

end;

end.

