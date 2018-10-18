program Project1;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  Unit2 in 'Unit2.pas' {AboutBox},
  Unit3 in 'Unit3.pas' {AboutBox1},
  Unit4 in 'Unit4.pas' {AboutBox2};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TAboutBox1, AboutBox1);
  Application.CreateForm(TAboutBox2, AboutBox2);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
