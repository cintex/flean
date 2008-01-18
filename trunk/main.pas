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
  procedure LoadLanguageForm(Section:string;Control:TWinControl);
  procedure LoadLanguageMenu(Section:string;MenuItems:TMenuItem);
  procedure LoadLanguageCombobox(Section:string;cmb:TCombobox);

var
  frIndicator: TfrIndicator;
  ConfigFile, LangFile : TIniFile; // Configuration file
  lid : integer; // Current layout's id
  HAlign, IndType, VAlign : byte;
  LangLoaded : Boolean;
  oid, tid : DWORD;

const app_name = 'Flean';
    app_version = '0.07';
    app_manufacturer = 'Flean developers';
    app_years = '2007-2008';
    app_site = 'http://code.google.com/p/flean/';


implementation

{$R *.dfm}

procedure LoadLanguageForm(Section:string;Control:TWinControl);
  procedure LoadLanguageFor(Section:string;Control:TControl);
  var
    Caption : string;
    PropInfo : PPRopInfo;
  begin
    PropInfo := GetPropInfo(Control.ClassInfo,'Caption');
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
      then LoadLanguageForm(Section,TWinControl(Control.Controls[i]))
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

procedure LoadLanguageCombobox(Section:string;cmb:TCombobox);
var
  i : integer;
begin
  with cmb.Items do
    for i:=0 to Count-1 do
      Strings[i] := LangFile.ReadString(Section,cmb.Name+'.'+IntToStr(i),Strings[i]);
end;

procedure TfrIndicator.Timer1Timer(Sender: TObject);
var
  hWindow,hEdit : THandle;
  newlid : integer;
  r : TRect;
  p : TPoint;
  newoid : DWORD;
  Result : longbool;
begin
  // Это для будущего определения раскладки
  hWindow := GetForegroundWindow;
  newoid := GetWindowThreadProcessId(hWindow,nil);
  // Подключаемся к процессу
  if newoid <> oid then begin
    AttachThreadInput(tid,oid,false);
    oid := newoid;
    if oid<>tid then
      AttachThreadInput(tid,oid,true);
  end;
  // Получаем координаты активного поля
  hEdit := GetFocus;
   GetWindowRect(hEdit,r);
  case IndType of
    0 : begin
      // Перемещаем индикатор
      if (top<>r.Right) and (left<>r.Left) then begin
        if not(visible) then
          ShowWindow(Handle, SW_SHOWNOACTIVATE);
        case VAlign of
          1 : top := r.Top;
          2 : top := r.Top + (r.Bottom - r.Top - Height) div 2;
          3 : top := r.Bottom - Height;
        end;
        case HAlign of
          1 : left := r.Left-Width;
          2 : left := r.Right;
        end;
      end
      else if visible
        then hide;
      if hEdit=null
        then hide;
    end;
    1 : begin
      if GetCaretPos(p) and (top<>r.Right) and (left<>r.Left) then begin
          if not(visible) then
            ShowWindow(Handle, SW_SHOWNOACTIVATE);
        Windows.ClientToScreen(hEdit,p);
        case VAlign of
          1 : top := p.Y - Height;
          2 : top := p.Y;
          3 : top := p.Y + 15;
        end;
        case HAlign of
          1 : left := p.X - Width - 2;
          2 : left := p.X + 2;
        end;
      end else if visible then
        Hide;
      if hEdit=null
        then hide;
    end;
  end;
  // Getting id of current layout
  newlid := GetKeyboardLayout(oid) shr $10;
  if newlid <> lid then begin
    lid := newlid;
    pic.Picture.LoadFromFile(ConfigFile.ReadString('flags',IntToStr(newlid),'flags\undef.bmp'));
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
  tid := GetCurrentThreadId;
  // Loading configuration
  ConfigFile := TIniFile.Create(ExtractFilePath(application.ExeName)+'flean.ini');
  // Resizing window
  Height:=11;
  Width:=16;
  AlphaBlend := ConfigFile.ReadBool('settings','transparent',true);
  AlphaBlendValue := ConfigFile.ReadInteger('settings','transparency',220);
  HAlign := ConfigFile.ReadInteger('settings','halign',1);
  VAlign := ConfigFile.ReadInteger('settings','valign',1);
  IndType := ConfigFile.ReadInteger('settings','type',0);
  LangFile := TIniFile.Create(ExtractFilePath(application.ExeName)+'langs\'+ConfigFile.ReadString('settings','language','us')+'.ini');
  LangLoaded := false;
end;

procedure TfrIndicator.MenuExitClick(Sender: TObject);
begin
  Halt;
end;

procedure TfrIndicator.MenuAboutClick(Sender: TObject);
begin
  frSettings.Tabs.ActivePageIndex := 2;
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
var
  i : byte;
begin
  if not(LangLoaded) then begin
    LoadLanguageMenu('traymenu',TrayPopup.Items);
    LoadLanguageForm('settings',frSettings);
    // Дальше пошли всякие мелочи в настройках
    with frSettings do begin
      // это у нас список с вариантами расположения индикатора
      LoadLanguageCombobox('Settings',cmbAlignment);
      LoadLanguageCombobox('Settings',cmbShow);
      lblAppName.Caption := app_name;
      lblAppVersion.Caption := lblAppVersion.Caption+' '+app_version;
    end;
    LangLoaded := false;
  end;
end;

end.
