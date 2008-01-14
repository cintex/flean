unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, IniFiles, CoolTrayIcon, Menus;

type
  TIndicator = class(TForm)
    pic: TImage;
    Timer1: TTimer;
    TrayIcon: TCoolTrayIcon;
    TrayPopup: TPopupMenu;
    MenuExit: TMenuItem;
    idl: TLabel;
    MenuAbout: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Indicator: TIndicator;

implementation

{$R *.dfm}

const app_name = 'Flean';
    app_version = '0.06';
    app_manufacturer = 'Flean developers';
    app_years = '2007-2008';
    app_site = 'http://code.google.com/p/flean/';

var
  settings : TIniFile; // Configuration file
  lang : integer; // Current layout's id
  halign : byte;
  valign : byte;

procedure TIndicator.Timer1Timer(Sender: TObject);
var
  hWindow,hEdit : THandle;
  newlang : integer;
  r : TRect;
  p : TPoint;
  oid, tid : DWORD;
  Result : longbool;
begin
  hWindow := GetForegroundWindow;
  // Attaching to process
  oid := GetWindowThreadProcessId(hWindow,nil);
  tid := GetCurrentThreadId;
  if (oid<>tid)
    then Result := AttachThreadInput(tid,oid,true);
  // Getting current control's area
  hEdit := Windows.GetFocus;
  if Result
    then AttachThreadInput(tid,oid,false);
  Windows.GetWindowRect(hEdit,r);
  // Moving indicator
  if (top<>r.Right) and (left<>r.Left)
    then begin
      if not(visible)
        then ShowWindow(Handle, SW_SHOWNOACTIVATE);
      case valign of
        1 : top := r.Top;
        2 : top := r.Top + (r.Bottom - r.Top - Height) div 2;
        3 : top := r.Bottom - Height;
      end;
      case halign of
        1 : left := r.Left-Width;
        2 : left := r.Right;
      end;
  end
  else if visible
    then hide;
  if hEdit=null
    then hide;
  // Getting id of current layout
  newlang := GetKeyboardLayout(oid) shr $10;
  if newlang <> lang
    then begin
      lang := newlang;
      pic.Picture.LoadFromFile(ExtractFilePath(application.ExeName)+settings.ReadString('flags',IntToStr(newlang),'flags\undef.bmp'));
      idl.Caption := IntToStr(newlang);
    end;
end;

procedure TIndicator.FormCreate(Sender: TObject);
begin
  Hide;
  Caption := app_name;
  Application.Title := Caption;
  Icon := Application.Icon;
  TrayIcon.Hint := app_name+' '+app_version;
  // Loading configuration
  Settings := TIniFile.Create(ExtractFilePath(application.ExeName)+'flean.ini');
  // Resizing window
  Height:=11;
  if (ParamStr(1)='-showid') or (Settings.ReadBool('appearance','showid',false))
    then  Width:=100
    else  Width:=16;
  AlphaBlend := settings.ReadBool('appearance','transparent',true);
  AlphaBlendValue := settings.ReadInteger('appearance','transparency',220);
  Timer1.Interval := settings.ReadInteger('settings','interval',500);
  halign := settings.ReadInteger('appearance','halign',1);
  valign := settings.ReadInteger('appearance','valign',1);
end;

procedure TIndicator.MenuExitClick(Sender: TObject);
begin
  Halt;
end;

procedure TIndicator.MenuAboutClick(Sender: TObject);
begin
  ShowMessage(app_name+' '+app_version+#10#13#10#13+'The ultimate keyboard indicator'+#10#13+app_site+#10#13#10#13+'(c) '+app_manufacturer+', '+app_years);
end;

end.
