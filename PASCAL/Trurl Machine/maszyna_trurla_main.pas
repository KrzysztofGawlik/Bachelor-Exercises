{
 Maszyna Trurla Gawlik Krzysztof 147762 20/21 Informatyka 1 v.01
}
unit Maszyna_Trurla_Main;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button_Historia: TButton;
    Button_Koniec: TButton;
    Button_Wykonaj: TButton;
    Button_Info: TButton;
    Edit_A: TEdit;
    Edit_B: TEdit;
    Edit_Wynik: TEdit;
    Label_A: TLabel;
    Label_B: TLabel;
    Label_B1: TLabel;
    Memo1: TMemo;
    Pb: TPaintBox;
    Shape2: TShape;
    Shape1: TShape;
    Shape3: TShape;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    procedure Button_HistoriaClick(Sender: TObject);
    procedure Button_InfoClick(Sender: TObject);
    procedure Button_KoniecClick(Sender: TObject);
    procedure Button_WykonajClick(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

// Done, przycisk Koniec
procedure TForm1.Button_KoniecClick(Sender: TObject);
begin
  Application.Terminate;
end;

// Done, przycisk Info
procedure TForm1.Button_InfoClick(Sender: TObject);
var Info : string;
begin
  Info := 'Maszyna Trurla Gawlik Krzysztof 147762 20/21 Informatyka 1 v.01';
  Application.MessageBox(PChar(Info),'Informacja');
end;

// Done, przycisk Wykonaj
procedure TForm1.Button_WykonajClick(Sender: TObject);
  var Plik : TextFile;
  var Losowa : Double;
  var Licznik : integer;
begin
  AssignFile(Plik,'Maszyna_Trurla.txt');

  try
    StrToInt(Edit_A.Text);
    StrToInt(Edit_B.Text);
  except
    ShowMessage('Blad konwersji');
    exit
  end;

  // Tu zaczyna sie "myslenie" i obliczenia
  Licznik := 1;
  repeat
    begin
    Losowa := Random()*10;
    Edit_Wynik.Text := FloatToStr(Losowa);
    Application.ProcessMessages();

    // Kolory kropek
    Shape1.Brush.Color := $00009696;
    Shape2.Brush.Color := $00009696;
    Shape3.Brush.Color := $00009696;
    if (Licznik mod 10 < 3) then
      Shape1.Brush.Color := $0001DEFE
    else if (Licznik mod 10 < 6) then
      Shape2.Brush.Color := $0001DEFE
    else
      Shape3.Brush.Color := $0001DEFE;

    inc(Licznik);
    Sleep(100);
    end;
  until Licznik = 30;

  if (Edit_A.Text = '2') and (Edit_B.Text = '2') then
    Edit_Wynik.Text := '7'
  else if (Edit_A.Text = '2') and (Edit_B.Text = '1') then
    Edit_Wynik.Text := '6'
  else if (Edit_A.Text = '1') and (Edit_B.Text = '1') then
    Edit_Wynik.Text := '0'
  else
  begin
    if (Edit_A.Text <> '') and (Edit_B.Text <> '') then
      case Random(2) of
      0:begin
            Edit_Wynik.Text := FloatToStr( StrToFloat(Edit_A.Text) * StrToFloat(Edit_B.Text) );
        end;
      1:begin
            Edit_Wynik.Text := IntToStr(Random(100));
        end;
  end;
  end;

  Shape1.Brush.Color := clLime;
  Shape2.Brush.Color := clLime;
  Shape3.Brush.Color := clLime;

  try
    Append(Plik);
  except
    Rewrite(Plik);
  end;
  WriteLn(Plik,Edit_A.Text+' '+Edit_B.Text+' '+Edit_Wynik.Text);
  CloseFile(Plik);
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin

end;

// Done, przycisk Historia
procedure TForm1.Button_HistoriaClick(Sender: TObject);
  var Plik : TextFile;
  var someText : String;
begin
  Memo1.Clear;
  AssignFile(Plik,'Maszyna_Trurla.txt');
  try
    Reset(Plik);
  except
    exit
  end;
  while not Eof(Plik) do
  begin
    ReadLn(Plik,someText);
    Memo1.Lines.Add(someText);
  end;
  CloseFile(Plik);
end;

end.

