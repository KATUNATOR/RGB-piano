unit Unit2;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, SHELLAPI, jpeg;

type
  TAboutBox = class(TForm)
    pnl1: TPanel;
    lblProductName: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    imgProgramIcon: TImage;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    procedure lbl2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AboutBox: TAboutBox;

implementation

{$R *.dfm}

procedure TAboutBox.lbl2Click(Sender: TObject);
begin
If (Sender is TLabel) then
with (Sender as Tlabel) do
ShellExecute(Application.Handle,PChar('open'),
PChar(Hint),
PChar(0),
nil,
SW_NORMAL);
end;

end.
 
