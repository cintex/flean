unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ExtCtrls, StdCtrls, CoolTrayIcon, Menus, settings,
  XPMan, TypInfo, IniFiles;

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
  procedure LoadLanguageApp();

var
  frIndicator: TfrIndicator;
  ConfigFile, LangFile : TIniFile; // Configuration file
  lid : integer; // Current layout's id
  HAlign, IndType, VAlign : byte;
  LangLoaded : Boolean;

const app_name = 'Flean';
    app_version = '0.10';
    app_manufacturer = 'Flean developers';
    app_years = '2007-2008';
    app_site = 'http://flean.googlecode.com/';


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

procedure LoadLanguageApp();
begin
  LoadLanguageMenu('traymenu',frIndicator.TrayPopup.Items);
  LoadLanguageForm('settings',frSettings);
  LoadLanguageMenu('settings',frSettings.pmLayouts.Items);
  // ƒальше пошли вс€кие мелочи в настройках
  with frSettings do begin
    lbLayouts.Items.Strings[lbLayouts.Items.Count-1] := LangFile.ReadString('settings','LayoutAdd',lbLayouts.Items.Strings[lbLayouts.Items.Count-1]);
    // это у нас список с вариантами расположени€ индикатора
    LoadLanguageCombobox('settings',cmbAlignment);
    LoadLanguageCombobox('settings',cmbShow);
    lblAppName.Caption := app_name;
    lblAppVersion.Caption := lblAppVersion.Caption+' '+app_version;
  end;
end;

procedure TfrIndicator.Timer1Timer(Sender: TObject);
var
  hWindow,hEdit : THandle;
  newlid : integer;
  r : TRect;
  oid : DWORD;
  p : TPoint;
  Result : longbool;
  gti : TGUIThreadInfo;
begin
  gti.cbSize := SizeOf(TGUIThreadInfo);
  hWindow := GetForegroundWindow;
  oid := GetWindowThreadProcessId(hWindow,nil);
  // Getting id of current layout
  newlid := GetKeyboardLayout(oid) shr $10;
  if newlid <> lid then begin
    lid := newlid;
    pic.Picture.LoadFromFile(ConfigFile.ReadString('flags',IntToStr(newlid),'flags\undef.bmp'));
    Width := pic.Picture.Bitmap.Width;
    Height := pic.Picture.Bitmap.Height;
  end;
  if IsWindow(hWindow) then begin
    if GetGUIThreadInfo(oid,gti) and (true) then
      case IndType of
        { --- Near current input --- }
        0: begin
          if GetWindowRect(gti.hwndFocus,r) then begin
            if not(Visible) then
              ShowWindow(Handle, SW_SHOWNOACTIVATE);
            case HAlign of
              1 : Left := r.Left - Width;
              2 : Left := r.Right;
            end;
            case VAlign of
              1 : Top := r.Top;
              2 : Top := r.Top + (r.Bottom - r.Top - Height) div 2;
              3 : Top := r.Bottom - Height;
            end;
          end;
        end;
        { --- Near text caret --- }
        1: begin
          p.X := 0;
          p.Y := 0;
          if Windows.ClientToScreen(gti.hwndCaret,p) then begin
            if not(Visible) then
              ShowWindow(Handle, SW_SHOWNOACTIVATE);
            case HAlign of
              1 : Left := p.X + gti.rcCaret.Left - Width;
              2 : Left := p.X + gti.rcCaret.Right;
            end;
            case VAlign of
              1 : Top := p.Y + gti.rcCaret.Top - Height;
              2 : Top := p.Y + gti.rcCaret.Top + (gti.rcCaret.Bottom - gti.rcCaret.Top - Height) div 2;
              3 : Top := p.Y + gti.rcCaret.Bottom;
            end;
          end;
        end;
      end else
        Hide;
    end else
      Hide;
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
    LoadLanguageApp;
    LangLoaded := false;
  end;
end;

end.
