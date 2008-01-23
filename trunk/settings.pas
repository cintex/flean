unit settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, ShellAPI, Menus, ExtDlgs;

type
  TfrSettings = class(TForm)
    pnlBottom: TPanel;
    Tabs: TPageControl;
    tabSettings: TTabSheet;
    tabAbout: TTabSheet;
    lblAppName: TLabel;
    lblLanguage: TLabel;
    cmbLanguage: TComboBox;
    cbTransparency: TCheckBox;
    tbTransparency: TTrackBar;
    btnClose: TBitBtn;
    lblAppVersion: TLabel;
    tabLayouts: TTabSheet;
    lblAlignment: TLabel;
    cmbAlignment: TComboBox;
    lblShow: TLabel;
    cmbShow: TComboBox;
    lblAuthors: TLabel;
    memAuthors: TMemo;
    pnlLayouts: TPanel;
    lbLayouts: TListBox;
    lblSite: TLabel;
    pmLayouts: TPopupMenu;
    LayoutDelete: TMenuItem;
    lblId: TLabel;
    edId: TEdit;
    btnIdDetect: TButton;
    lblIcon: TLabel;
    edIcon: TEdit;
    btnIconBrowse: TButton;
    dlgIconBrowse: TOpenPictureDialog;
    lblLicense: TLabel;
    imgLogo: TImage;
    cbShowAlways: TCheckBox;
    procedure LoadSettings;
    procedure tbTransparencyChange(Sender: TObject);
    procedure cbTransparencyClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbAlignmentChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbShowChange(Sender: TObject);
    procedure lbLayoutsDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure lblSiteClick(Sender: TObject);
    procedure lbLayoutsContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure lbLayoutsClick(Sender: TObject);
    procedure btnIdDetectClick(Sender: TObject);
    procedure LayoutDeleteClick(Sender: TObject);
    procedure btnIconBrowseClick(Sender: TObject);
    procedure cmbLanguageChange(Sender: TObject);
    procedure cbShowAlwaysClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frSettings: TfrSettings;

implementation

uses main;

{$R *.dfm}


procedure TfrSettings.LoadSettings;
begin
  cmbLanguage.ItemIndex := cmbLanguage.Items.IndexOf(ConfigFile.ReadString('settings','language','U.S. English'));
  cbTransparency.Checked := frIndicator.AlphaBlend;
  tbTransparency.Enabled := frIndicator.AlphaBlend;
  tbTransparency.Position := frIndicator.AlphaBlendValue;
  cmbAlignment.ItemIndex := VAlign-1+3*(HAlign-1);
  cmbShow.ItemIndex := IndType;
  lbLayouts.ItemIndex := lbLayouts.Items.Count-1;
  cbShowAlways.Checked := ShowAlways;
end;

procedure TfrSettings.tbTransparencyChange(Sender: TObject);
begin
  ConfigFile.WriteInteger('settings','transparency',tbTransparency.Position);
  frIndicator.AlphaBlendValue := tbTransparency.Position;
end;

procedure TfrSettings.FormShow(Sender: TObject);
begin
  LoadSettings;
end;

procedure TfrSettings.cbTransparencyClick(Sender: TObject);
begin
  ConfigFile.WriteBool('settings','transparent',cbTransparency.Checked);
  tbTransparency.Enabled := cbTransparency.Checked;
  frIndicator.AlphaBlend := tbTransparency.Enabled;
end;

procedure TfrSettings.btnCloseClick(Sender: TObject);
begin
  Hide;
end;

procedure TfrSettings.cmbAlignmentChange(Sender: TObject);
begin
  with cmbAlignment do begin
    case ItemIndex of
      0..2: HAlign := 1;
      3..5: HAlign := 2;
    end;
    case ItemIndex of
      0, 3: VAlign := 1;
      1, 4: VAlign := 2;
      2, 5: VAlign := 3;
    end;
  end;
  ConfigFile.WriteInteger('settings','halign',HAlign);
  ConfigFile.WriteInteger('settings','valign',VAlign);
end;

procedure TfrSettings.FormCreate(Sender: TObject);
var
  SR : TSearchRec;
begin
  frSettings.memAuthors.Lines.LoadFromFile('docs\authors.txt');
  lblSite.Caption := app_site;
  lbLayouts.Items.Clear;
  ConfigFile.ReadSection('Flags',lbLayouts.Items);
  lbLayouts.Items.Add('Add');
  imgLogo.Picture.Icon := Application.Icon;
  if FindFirst('langs\*.ini', faAnyFile, SR) = 0 then begin
    repeat
      if (SR.Attr <> faDirectory) then
        cmbLanguage.Items.Add(Copy(SR.Name,0,Length(SR.Name)-4));
    until FindNext(SR) <> 0;
    FindClose(SR);
  end;
end;

procedure TfrSettings.cmbShowChange(Sender: TObject);
begin
  ConfigFile.WriteInteger('settings','type',cmbShow.ItemIndex);
  IndType := cmbShow.ItemIndex;
end;

procedure TfrSettings.lbLayoutsDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  Text : string;
  Pic : TPicture;
begin
  Pic := TPicture.Create;
  with lbLayouts.Canvas do begin
  if Index = lbLayouts.Items.Count-1 then begin
      Font.Style := [fsBold];
      frIndicator.imlMain.GetBitmap(4,Pic.Bitmap);
      Pic.Bitmap.Transparent := true;
    end else begin
      Font.Style := [];
      if (lbLayouts.Items.Strings[Index]<>'') and (FileExists(ConfigFile.ReadString('flags',lbLayouts.Items.Strings[Index],'flags\undef.bmp'))) then
        Pic.LoadFromFile(ConfigFile.ReadString('flags',lbLayouts.Items.Strings[Index],'flags\undef.bmp'))
      else
        Pic.LoadFromFile('flags\undef.bmp');

    end;
    FillRect(Rect);
    text := lbLayouts.Items.Strings[Index];
    TextOut(Rect.Left+lbLayouts.ItemHeight+4,Rect.Top+(lbLayouts.ItemHeight-TextHeight(text)) div 2, text);
    Draw(Rect.Left+(lbLayouts.ItemHeight-Pic.Width) div 2,Rect.Top+(lbLayouts.ItemHeight-Pic.Height) div 2,Pic.Graphic);
  end;
  Pic.Destroy;
end;

procedure TfrSettings.lblSiteClick(Sender: TObject);
begin
  ShellExecute(Handle,'open',PChar(app_site),nil,nil,SW_SHOW);
end;

procedure TfrSettings.lbLayoutsContextPopup(Sender: TObject;
  MousePos: TPoint; var Handled: Boolean);
var
  IAP : integer;
begin
  with lbLayouts do begin
    IAP := ItemAtPos(MousePos,true);
    if (IAP = Count-1) or (IAP = -1) then
      Handled := true
    else begin
      ItemIndex := IAP;
      lbLayoutsClick(self);
      Handled := false;
    end;
  end;
end;

procedure TfrSettings.lbLayoutsClick(Sender: TObject);
begin
  if lbLayouts.ItemIndex <> lbLayouts.Items.Count - 1 then begin
    edId.Text := lbLayouts.Items.Strings[lbLayouts.ItemIndex];
    edIcon.Text := ConfigFile.ReadString('flags',edId.Text,'flags\undef.bmp');
  end else begin
    edId.Text := '';
    edIcon.Text := '';
  end;
end;

procedure TfrSettings.btnIdDetectClick(Sender: TObject);
begin
  edId.Text := IntToStr(GetKeyboardLayout(GetCurrentThreadId) shr $10);
  with lbLayouts do begin
    if ItemIndex <> Items.Count - 1 then begin
      ConfigFile.DeleteKey('flags',Items.Strings[ItemIndex]);
      Items.Strings[ItemIndex] := edId.Text;
      ConfigFile.WriteString('flags',edId.Text,edIcon.Text);
    end else begin
      if Items.IndexOf(edId.Text) = -1 then begin
        Items.Insert(Items.Count - 1,edId.Text);
        ItemIndex := Items.Count - 2;
        ConfigFile.WriteString('flags',edId.Text,edIcon.text);
      end else
        ItemIndex := Items.IndexOf(edId.Text);
    end;
  end;
end;

procedure TfrSettings.LayoutDeleteClick(Sender: TObject);
begin
  with lbLayouts do begin
    ConfigFile.DeleteKey('flags',Items.Strings[ItemIndex]);
    Items.Delete(ItemIndex);
  end;
end;

procedure TfrSettings.btnIconBrowseClick(Sender: TObject);
begin
  if dlgIconBrowse.Execute then begin
    edIcon.Text := dlgIconBrowse.FileName;
    if edId.Text <> '' then begin
      ConfigFile.WriteString('flags',edId.Text,edIcon.Text);
      lbLayoutsDrawItem(lbLayouts,lbLayouts.ItemIndex,lbLayouts.ItemRect(lbLayouts.ItemIndex),[odSelected]);
    end;
  end;
end;

procedure TfrSettings.cmbLanguageChange(Sender: TObject);
begin
  LangFile.Create(ExtractFilePath(Application.ExeName)+'langs\'+cmbLanguage.Items.Strings[cmbLanguage.ItemIndex]+'.ini');
  ConfigFile.WriteString('settings','language',cmbLanguage.Items.Strings[cmbLanguage.ItemIndex]);
  LoadLanguageApp;
  LoadSettings;
end;

procedure TfrSettings.cbShowAlwaysClick(Sender: TObject);
begin
  ShowAlways := cbShowAlways.Checked;
  ConfigFile.WriteBool('settings','showalways',ShowAlways);
end;

end.
