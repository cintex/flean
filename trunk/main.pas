unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, IniFiles, CoolTrayIcon, Menus, settings,
  XPMan, TypInfo;

type
  TfrIndicator = class(TForm)
    pic: TImage;
    Timer1: TTimer;
    TrayIcon: TCoolTrayIcon;
    TrayPopup: TPopupMenu;
    MenuExit: TMenuItem;
    MenuAbout: TMenuItem;
    XPManifest1: TXPManifest;
    MenuSettings: TMenuItem;
    imlMain: TImageList;
    MenuEnable: TMenuItem;
    MenuDisable: TMenuItem;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MenuExitClick(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
    procedure Config1Click(Sender: TObject);
    procedure MenuSettingsClick(Sender: TObject);
    procedure MenuEnableClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
  procedure LoadLanguage(Section:string;Control:TWinControl);
  procedure LoadLanguageMenu(Section:string;MenuItems:TMenuItem);

var
  frIndicator: TfrIndicator;
  ConfigFile, LangFile : TIniFile; // Configuration file
  lid : integer; // Current layout's id
  HAlign : byte;
  VAlign : byte;
  LangLoaded : Boolean;

const app_name = 'Flean';
    app_version = '0.07';
    app_manufacturer = 'Flean developers';
    app_years = '2007-2008';
    app_site = 'http://code.google.com/p/flean/';


implementation

{$R *.dfm}

procedure LoadLanguage(Section:string;Control:TWinControl);
  procedure LoadLanguageFor(Section:string;Control:TControl);
  var
    Caption : string;
    PropInfo : PPRopInfo;
  begin
    PropInfo := GetPropInfo(Control.ClassInfo,'Caption');
    if PropInfo = nil then
      PropInfo := GetPropInfo(Control.ClassInfo,'Text');
    if PropInfo <> nil then begin
      Caption := GetStrProp(Control,PropInfo);
      Caption := LangFile.ReadString(Section,Control.Name,Caption);
      SetStrProp(Control,PropInfo,Caption);
    end;
  end;
var
  i : integer;
begin
  LoadLanguageFor(Section,Control);
  for i:=0 to Control.ControlCount-1 do
    if Control.Controls[i] is TWinControl
      then LoadLanguage(Section,TWinControl(Control.Controls[i]))
      else LoadLanguageFor(Section,Control.Controls[i]);
end;

procedure LoadLanguageMenu(Section:string;MenuItems:TMenuItem);
var
  i : integer;
begin
  for i := 0 to MenuItems.Count-1 do begin
    if not(MenuItems[i].IsLine) then
      MenuItems[i].Caption := LangFile.ReadString(Section,MenuItems[i].Name,MenuItems[i].Caption);
    LoadLanguageMenu(Section,MenuItems[i]);
  end;
end;

procedure TfrIndicator.Timer1Timer(Sender: TObject);
var
  hWindow,hEdit : THandle;
  newlid : integer;
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
  newlid := GetKeyboardLayout(oid) shr $10;
  if newlid <> lid
    then begin
      lid := newlid;
      pic.Picture.LoadFromFile(ExtractFilePath(application.ExeName)+ConfigFile.ReadString('flags',IntToStr(newlid),'flags\undef.bmp'));
    end;
end;

procedure TfrIndicator.FormCreate(Sender: TObject);
begin
  Hide;
  Caption := app_name;
  Application.Title := Caption;
  frSettings.Caption := Caption;
  Icon := Application.Icon;
  TrayIcon.Hint := app_name+' '+app_version;
  // Loading configuration
  ConfigFile := TIniFile.Create(ExtractFilePath(application.ExeName)+'flean.ini');
  // Resizing window
  Height:=11;
  Width:=16;
  AlphaBlend := ConfigFile.ReadBool('appearance','transparent',true);
  AlphaBlendValue := ConfigFile.ReadInteger('appearance','transparency',220);
  Timer1.Interval := ConfigFile.ReadInteger('settings','interval',500);
  HAlign := ConfigFile.ReadInteger('appearance','halign',1);
  VAlign := ConfigFile.ReadInteger('appearance','valign',1);
  LangFile := TIniFile.Create(ExtractFilePath(application.ExeName)+'langs\'+ConfigFile.ReadString('settings','language','us')+'.ini');
  LangLoaded := false;
end;

procedure TfrIndicator.MenuExitClick(Sender: TObject);
begin
  Halt;
end;

procedure TfrIndicator.MenuAboutClick(Sender: TObject);
begin
  frSettings.Tabs.ActivePageIndex := 1;
  frSettings.Show;
end;

procedure TfrIndicator.Config1Click(Sender: TObject);
begin
  frSettings.Show;
end;

procedure TfrIndicator.MenuSettingsClick(Sender: TObject);
begin
  frSettings.Tabs.ActivePageIndex := 0;
  frSettings.Show;
end;

procedure TfrIndicator.MenuEnableClick(Sender: TObject);
begin
  if Timer1.Enabled then
    TrayIcon.IconIndex := 1
  else
    TrayIcon.IconIndex := 0;
  Timer1.Enabled := not(Timer1.Enabled);
  MenuDisable.Visible := MenuEnable.Visible;
  MenuEnable.Visible := not(MenuDisable.Visible);
  MenuDisable.Default := MenuDisable.Visible;
  MenuEnable.Default := MenuEnable.Visible;
  Hide;
end;

procedure TfrIndicator.FormShow(Sender: TObject);
begin
  if not(LangLoaded) then begin
    LoadLanguageMenu('traymenu',TrayPopup.Items);
    LoadLanguage('settings',frSettings);
    // ƒальше пошли вс€кие мелочи в настройках
    with frSettings do begin
      // это у нас список с вариантами расположени€ индикатора
      with cmbAlignment.Items do begin
        Strings[0] := LangFile.ReadString('settings','cmbAlignment.TopLeft',Strings[0]);
        Strings[1] := LangFile.ReadString('settings','cmbAlignment.MiddleLeft',Strings[1]);
        Strings[2] := LangFile.ReadString('settings','cmbAlignment.BottomLeft',Strings[2]);
        Strings[3] := LangFile.ReadString('settings','cmbAlignment.TopRight',Strings[3]);
        Strings[4] := LangFile.ReadString('settings','cmbAlignment.MiddleRight',Strings[4]);
        Strings[5] := LangFile.ReadString('settings','cmbAlignment.BottomRight',Strings[5]);
      end;
      lblAppName.Caption := app_name;
      lblAppVersion.Caption := lblAppVersion.Caption+' '+app_version;
    end;
    LangLoaded := false;
  end;
end;

end.
