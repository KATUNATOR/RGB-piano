unit Unit1;
{обучающая программа "Нотный градиент" Хинкель Екатерина 62491}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, XPMan, MMSystem, ExtCtrls, Menus, Grids;

type
  TForm1 = class(TForm)

    //piano keys
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape7: TShape;
    Shape8: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    Shape21: TShape;
    Shape22: TShape;
    Shape23: TShape;
    Shape24: TShape;
    Shape25: TShape;
    Shape26: TShape;
    Shape27: TShape;
    Shape28: TShape;
    Shape29: TShape;
    Shape30: TShape;
    Shape31: TShape;
    Shape32: TShape;
    Shape33: TShape;
    Shape34: TShape;
    Shape35: TShape;
    Shape36: TShape;

    //labels for piano keys
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;

    //menu
    mm1: TMainMenu;
    Nmode: TMenuItem;
    mniPiano: TMenuItem;
    mniSet: TMenuItem;
    mniTrain: TMenuItem;
    mniO1: TMenuItem;
    mniO2: TMenuItem;
    mniO3: TMenuItem;
    N11: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;

    //buttons for COLORNOTES
    btnStop: TButton;
    btnYou: TBitBtn;
    btnComp: TBitBtn;

    //main label
    Label1: TLabel;

    //other...
    xpmnfst1: TXPManifest;
    OpenDialog1: TOpenDialog;

    //main Form
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);

    //menu
    procedure mniTrainClick(Sender: TObject);
    procedure mniPianoClick(Sender: TObject);
    procedure mniO1Click(Sender: TObject);
    procedure mniO2Click(Sender: TObject);
    procedure mniO3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);

    //buttons for COLORNOTES
    procedure btnYouClick(Sender: TObject);
    procedure btnCompClick(Sender: TObject);

    //piano keys by keyboard
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);

    //piano keys by mouse
    procedure Shape1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);

    procedure btnStopClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
  TColor = record
    r: array[1..2] of Byte;
    g: array[1..2] of Byte;
    b: array[1..2] of Byte;
  end;

type
  Tsheet = record
    n: array[1..200] of Integer; //note
    t: array[1..200] of Integer; //time
    a: array[1..200] of Integer; //accord
    si: Integer; //size in i
    sj: Integer; //size in j
    i: Integer; //current t-note
    j: Integer; //current n-note
  end;

type
  Tkey = record
    n: array[1..300] of Integer; //note in keybord-piano
    f: array[1..300] of Boolean; //is pressed?
    o: Integer; //octave
    d: string; //diraction to the note's samples
  end;

var
  k: Tkey; //keys
  c: array[0..36] of TColor; //RGB for notes
  s: Tsheet; //sheets
  note: set of Byte; //notes that should be pushed
  symb: array[1..36] of string;
  fplay: Boolean; //when start plaing
  fstop: Boolean; //when start plaing
  Form1: TForm1;

implementation

uses Unit2, Unit3, Unit4;

{$R *.dfm}

//-----------------------------------------------------------------------------
//  INPUT
//-------------------------------------------------------------------------KEYS

procedure InputKeys();
var
  f: TextFile;
  i, j: Integer;
begin
  AssignFile(f, 'keys.txt');
  Reset(f);
  for i := 1 to 36 do
  begin
    Readln(f, j);
    k.n[j] := i;
    k.f[j] := True;
  end;
  Close(f);
end;
//-----------------------------------------------------------------------SHEETS

procedure InputSheets(filename: string);
var
  f: TextFile;
  i: Integer;
  x: Integer;
  str: string;
begin
  AssignFile(f, filename);
  Reset(f);
  Readln(f, str);
  Form1.Label1.Caption := str;

  s.i := 1;
  s.j := 1;

  i := 0;
  x := 1;
  while x <> 0 do
  begin
    inc(i);
    read(f, x);
    s.n[i] := x;
  end;
  readln(f);

  s.sj := i - 1;

  i := 0;
  x := 1;
  while x <> 0 do
  begin
    inc(i);
    read(f, x);
    s.t[i] := x;
  end;
  readln(f);

  s.si := i - 1;

  i := 0;
  x := 1;
  while x <> 0 do
  begin
    inc(i);
    read(f, x);
    s.a[i] := x;
  end;

  Close(f);
end;
//-----------------------------------------------------------------------COLORS

procedure InputColors();
var
  f: TextFile;
  i: Integer;
begin
  AssignFile(f, 'colors.txt');
  Reset(f);
  for i := 0 to 36 do
  begin
    read(f, c[i].r[2]);
    read(f, c[i].g[2]);
    read(f, c[i].b[2]);
    read(f, c[i].r[1]);
    read(f, c[i].g[1]);
    readln(f, c[i].b[1]);
  end;
  CloseFile(f);
end;

//-----------------------------------------------------------------------------
//  FORM CREATE
//-----------------------------------------------------------------------------

procedure TForm1.FormCreate(Sender: TObject);
var
  i: Integer;
  aTmp: array[0..255] of Char;
begin
  InputColors();
  InputKeys();
  k.o := 24;
  fplay := True;

  for i := 1 to 36 do
    (FindComponent('Shape' + inttostr(i)) as TShape).
      Brush.Color := RGB(c[i].r[1], c[i].g[1], c[i].b[1]);

  mciSendString(PChar('open waveaudio shareable'), nil, 0, 0);
  GetShortPathName(PChar(extractFilePath(paramStr(0))), aTmp, Sizeof(aTmp));
  k.d := StrPas(aTmp);
end;

//-----------------------------------------------------------------------------
//   ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ CLEAN FORM ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~
//-----------------------------------------------------------------------------

procedure CleanForm();
begin
  Form1.Canvas.Pen.Color := RGB(0, 0, 0);
  Form1.Canvas.Brush.Color := RGB(0, 0, 0);
  Form1.Canvas.Rectangle(1, 1, 2000, 100);
end;

//-----------------------------------------------------------------------------
//  ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ RECTANGLE ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~ ~~
//-----------------------------------------------------------------------------

procedure GetRectangle(i, j: integer);
var
  x1, x2, y1, y2, istep, jstep, l, n: Integer;
begin
  CleanForm();

  istep := 256;
  x2 := 27;
  y1 := 20;
  y2 := 80;

  while (x2 < 1200) and (i <= s.si) do
  begin
    x1 := x2;

    Form1.Canvas.Brush.Style := bsSolid;
    jstep := (istep div s.t[i]) div s.a[i];

    for l := 0 to (s.a[i] - 1) do
    begin
      x2 := x2 + jstep;
      if x2 > 1200 then
        x2 := 1200;

      n := s.n[j + l];

      Form1.Canvas.Pen.Color := RGB(c[n].r[2], c[n].g[2], c[n].b[2]);
      Form1.Canvas.Brush.Color := RGB(c[n].r[2], c[n].g[2], c[n].b[2]);
      Form1.Canvas.Rectangle(x1 + (jstep * l), y1, x2, y2);
    end;
    j := j + s.a[i];

    Form1.Canvas.Brush.Style := bsClear;
    Form1.Canvas.Pen.Color := clBlack;
    Form1.Canvas.Rectangle(x1, y1, x2, y2);

    inc(i);
  end;
end;

//-----------------------------------------------------------------------------
//--------------------------------MODES----------------------------------------
//-----------------------------------------------------------------------------
//----------+
//  PLAY
//-----------------------------------------------------------------------------

procedure TForm1.mniPianoClick(Sender: TObject);
var
  i: integer;
begin
  mniPiano.Checked := True;
  btnYou.Visible := False;
  btnComp.Visible := False;
  btnStop.Visible := False;
  fplay := True;

  CleanForm();
  for i := 1 to 36 do
    (FindComponent('Shape' + inttostr(i)) as TShape).
      Brush.Color := RGB(c[i].r[1], c[i].g[1], c[i].b[1]);
end;

//----------+
//  COLORNOTES
//-----------------------------------------------------------------------------

procedure TForm1.mniTrainClick(Sender: TObject);
var
  i: integer;
begin
  mniTrain.Checked := True;
  btnYou.Visible := True;
  btnComp.Visible := True;
  btnStop.Visible := True;
  fplay := False;

  CleanForm();
  for i := 1 to 36 do
    (FindComponent('Shape' + inttostr(i)) as TShape).
      Brush.Color := RGB(c[i].r[1], c[i].g[1], c[i].b[1]);

  Form1.Label1.BringToFront;
  OpenDialog1.InitialDir := k.d + 'songs\';
  if OpenDialog1.Execute then
    InputSheets(OpenDialog1.FileName)
  else
    MessageBox(0, 'Файл не выбран!!!!', 'Ошибка', MB_OK);
end;

//----------+
//  OCTAVE
//------------------------------------------------------------------------FIRST

procedure TForm1.mniO1Click(Sender: TObject);
begin
  mniO1.Checked := True;
  k.o := 0;
end;
//-----------------------------------------------------------------------SECOND

procedure TForm1.mniO2Click(Sender: TObject);
begin
  mniO2.Checked := True;
  k.o := 12;
end;
//------------------------------------------------------------------------THIRD

procedure TForm1.mniO3Click(Sender: TObject);
begin
  mniO3.Checked := True;
  k.o := 24;
end;
//----------+
//  HELP
//------------------------------------------------------------------------AUTOR

procedure TForm1.N1Click(Sender: TObject);
begin
  AboutBox.ShowModal;
end;
//------------------------------------------------------------------HOW TO PLAY

procedure TForm1.N2Click(Sender: TObject);
begin
  AboutBox1.ShowModal;
end;
//-----------------------------------------------------------------HOW TO WRITE

procedure TForm1.N3Click(Sender: TObject);
begin
  AboutBox2.ShowModal;
end;

//----------+
// TRAINING/////////////////////////////////////////////////////////////////////
//----------+

procedure TForm1.btnYouClick(Sender: TObject);
var
  i, l, n: integer;
begin
  mniTrain.Checked := True;
  fplay := True;

  for i := 1 to 36 do
    (FindComponent('Shape' + inttostr(i)) as TShape).
      Brush.Color := RGB(c[i].r[1], c[i].g[1], c[i].b[1]);

  s.i := 1;
  s.j := 1;
  note := [];
  GetRectangle(1, 1);
  for l := 1 to s.a[1] do
  begin
    n := s.n[l];
    Include(note, n);
    (FindComponent('Shape' + inttostr(n)) as TShape).
      Brush.Color := RGB(c[n].r[2], c[n].g[2], c[n].b[2]);
  end;
end;
//----------+
// AUTOPLAING///////////////////////////////////////////////////////////////////
//----------+

procedure TForm1.btnCompClick(Sender: TObject);
var
  i, j, l, n: integer;
begin
  mniTrain.Checked := True;
  fplay := False;
  fstop := False;
  j := 1;
  GetRectangle(1, 1);
  for i := s.i to s.si do
  begin
    for l := 0 to (s.a[i] - 1) do
    begin
      n := s.n[j + l];
      mciSendString(PChar('stop "' + k.d + 'notes\' + inttostr(n + k.o) +
        '.wav"'), nil, 0, 0);
      mciSendString(PChar('play "' + k.d + 'notes\' + inttostr(n + k.o) +
        '.wav"'), nil, 0, 0);
      (FindComponent('Shape' + inttostr(n)) as TShape).
        Brush.Color := RGB(c[n].r[2], c[n].g[2], c[n].b[2]);
    end;
    Application.ProcessMessages;
    for l := 0 to (s.a[i] - 1) do
    begin
      n := s.n[j + l];
      (FindComponent('Shape' + inttostr(n)) as TShape).
        Brush.Color := RGB(c[n].r[1], c[n].g[1], c[n].b[1]);
    end;
    j := j + s.a[i];

    if i = s.si then
      Break;

    GetRectangle(i + 1, j);
    Sleep(1200 div s.t[i]);
    Application.ProcessMessages;

    if fstop then
      Break;
  end;
  CleanForm();
  Form1.Label1.Caption := 'GAME OVER >:D';
end;
//----------+
// STOP AUTOPLAING//////////////////////////////////////////////////////////////
//----------+

procedure TForm1.btnStopClick(Sender: TObject);
begin
  fstop := True;
end;

//-----------------------------------------------------------------------------
//  KEY DOWN
//-----------------------------------------------------------------------------

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  n, i, j, l: Integer;
begin
  n := k.n[Key];
  j := s.j;
  if fplay and k.f[Key] and (n <> 0) and ((n in note) or (mniPiano.Checked))
    then
  begin
    mciSendString(PChar('stop "' + k.d + 'notes\' + inttostr(n + k.o) +
      '.wav"'), nil, 0, 0);
    mciSendString(PChar('play "' + k.d + 'notes\' + inttostr(n + k.o) +
      '.wav"'), nil, 0, 0);

    k.f[Key] := False;

    if mniPiano.Checked then
      (FindComponent('Shape' + inttostr(n)) as TShape).
        Brush.Color := RGB(c[n].r[2], c[n].g[2], c[n].b[2])
    else
    begin
      (FindComponent('Shape' + inttostr(n)) as TShape).
        Brush.Color := RGB(c[n].r[1], c[n].g[1], c[n].b[1]);

      if j = s.sj then
      begin
        CleanForm();
        Form1.Label1.Caption := 'GAME OVER >:D';
        fplay := False;
        for i := 1 to 36 do
          (FindComponent('Shape' + inttostr(i)) as TShape).
            Brush.Color := RGB(c[i].r[1], c[i].g[1], c[i].b[1]);
        exit;
      end;

      inc(s.j);
      Exclude(note, n);

      if note = [] then
      begin
        inc(s.i);
        GetRectangle(s.i, s.j);
        for l := 0 to s.a[s.i] - 1 do
        begin
          n := s.n[s.j + l];
          Include(note, n);
          (FindComponent('Shape' + inttostr(n)) as TShape).
            Brush.Color := RGB(c[n].r[2], c[n].g[2], c[n].b[2]);
        end;
      end;
    end;
  end;
end;

//-----------------------------------------------------------------------------
//  KEY UP
//-----------------------------------------------------------------------------

procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  n: Integer;
begin
  n := k.n[Key];

  if n <> 0 then
  begin
    k.f[Key] := True;
    if (mniPiano.Checked) then
      (FindComponent('Shape' + inttostr(n)) as TShape).
        Brush.Color := RGB(c[n].r[1], c[n].g[1], c[n].b[1]);
  end;
end;

//-----------------------------------------------------------------------------
//  MOUSE DOWN+UP
//-----------------------------------------------------------------------------

procedure TForm1.Shape1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  with (Sender as TShape) do
    case Tag of
      1: keybd_event(Ord('Z'), 0, 0, 0);
      2: keybd_event(Ord('S'), 0, 0, 0);
      3: keybd_event(Ord('X'), 0, 0, 0);
      4: keybd_event(Ord('D'), 0, 0, 0);
      5: keybd_event(Ord('C'), 0, 0, 0);
      6: keybd_event(Ord('V'), 0, 0, 0);
      7: keybd_event(Ord('G'), 0, 0, 0);
      8: keybd_event(Ord('B'), 0, 0, 0);
      9: keybd_event(Ord('H'), 0, 0, 0);
      10: keybd_event(Ord('N'), 0, 0, 0);
      11: keybd_event(Ord('J'), 0, 0, 0);
      12: keybd_event(Ord('M'), 0, 0, 0);
      13: keybd_event(Ord(188), 0, 0, 0);
      14: keybd_event(Ord('L'), 0, 0, 0);
      15: keybd_event(Ord(190), 0, 0, 0);
      16: keybd_event(Ord(186), 0, 0, 0);
      17: keybd_event(Ord(191), 0, 0, 0);
      18: keybd_event(Ord('Q'), 0, 0, 0);
      19: keybd_event(Ord('2'), 0, 0, 0);
      20: keybd_event(Ord('W'), 0, 0, 0);
      21: keybd_event(Ord('3'), 0, 0, 0);
      22: keybd_event(Ord('E'), 0, 0, 0);
      23: keybd_event(Ord('4'), 0, 0, 0);
      24: keybd_event(Ord('R'), 0, 0, 0);
      25: keybd_event(Ord('T'), 0, 0, 0);
      26: keybd_event(Ord('6'), 0, 0, 0);
      27: keybd_event(Ord('Y'), 0, 0, 0);
      28: keybd_event(Ord('7'), 0, 0, 0);
      29: keybd_event(Ord('U'), 0, 0, 0);
      30: keybd_event(Ord('I'), 0, 0, 0);
      31: keybd_event(Ord('9'), 0, 0, 0);
      32: keybd_event(Ord('O'), 0, 0, 0);
      33: keybd_event(Ord('0'), 0, 0, 0);
      34: keybd_event(Ord('P'), 0, 0, 0);
      35: keybd_event(Ord(189), 0, 0, 0);
      36: keybd_event(Ord(219), 0, 0, 0);
    end;
end;

procedure TForm1.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  with (Sender as TShape) do
    case Tag of
      1: keybd_event(Ord('Z'), 0, KEYEVENTF_KEYUP, 0);
      2: keybd_event(Ord('S'), 0, KEYEVENTF_KEYUP, 0);
      3: keybd_event(Ord('X'), 0, KEYEVENTF_KEYUP, 0);
      4: keybd_event(Ord('D'), 0, KEYEVENTF_KEYUP, 0);
      5: keybd_event(Ord('C'), 0, KEYEVENTF_KEYUP, 0);
      6: keybd_event(Ord('V'), 0, KEYEVENTF_KEYUP, 0);
      7: keybd_event(Ord('G'), 0, KEYEVENTF_KEYUP, 0);
      8: keybd_event(Ord('B'), 0, KEYEVENTF_KEYUP, 0);
      9: keybd_event(Ord('H'), 0, KEYEVENTF_KEYUP, 0);
      10: keybd_event(Ord('N'), 0, KEYEVENTF_KEYUP, 0);
      11: keybd_event(Ord('J'), 0, KEYEVENTF_KEYUP, 0);
      12: keybd_event(Ord('M'), 0, KEYEVENTF_KEYUP, 0);
      13: keybd_event(Ord(188), 0, KEYEVENTF_KEYUP, 0);
      14: keybd_event(Ord('L'), 0, KEYEVENTF_KEYUP, 0);
      15: keybd_event(Ord(190), 0, KEYEVENTF_KEYUP, 0);
      16: keybd_event(Ord(186), 0, KEYEVENTF_KEYUP, 0);
      17: keybd_event(Ord(191), 0, KEYEVENTF_KEYUP, 0);
      18: keybd_event(Ord('Q'), 0, KEYEVENTF_KEYUP, 0);
      19: keybd_event(Ord('2'), 0, KEYEVENTF_KEYUP, 0);
      20: keybd_event(Ord('W'), 0, KEYEVENTF_KEYUP, 0);
      21: keybd_event(Ord('3'), 0, KEYEVENTF_KEYUP, 0);
      22: keybd_event(Ord('E'), 0, KEYEVENTF_KEYUP, 0);
      23: keybd_event(Ord('4'), 0, KEYEVENTF_KEYUP, 0);
      24: keybd_event(Ord('R'), 0, KEYEVENTF_KEYUP, 0);
      25: keybd_event(Ord('T'), 0, KEYEVENTF_KEYUP, 0);
      26: keybd_event(Ord('6'), 0, KEYEVENTF_KEYUP, 0);
      27: keybd_event(Ord('Y'), 0, KEYEVENTF_KEYUP, 0);
      28: keybd_event(Ord('7'), 0, KEYEVENTF_KEYUP, 0);
      29: keybd_event(Ord('U'), 0, KEYEVENTF_KEYUP, 0);
      30: keybd_event(Ord('I'), 0, KEYEVENTF_KEYUP, 0);
      31: keybd_event(Ord('9'), 0, KEYEVENTF_KEYUP, 0);
      32: keybd_event(Ord('O'), 0, KEYEVENTF_KEYUP, 0);
      33: keybd_event(Ord('0'), 0, KEYEVENTF_KEYUP, 0);
      34: keybd_event(Ord('P'), 0, KEYEVENTF_KEYUP, 0);
      35: keybd_event(Ord(189), 0, KEYEVENTF_KEYUP, 0);
      36: keybd_event(Ord(219), 0, KEYEVENTF_KEYUP, 0);
    end;
end;

//-----------------------------------------------------------------------------
//  FORM_DESTROY
//-----------------------------------------------------------------------------

procedure TForm1.FormDestroy(Sender: TObject);
begin
  mciSendString(PChar('close waveaudio'), nil, 0, 0);
end;

end.

