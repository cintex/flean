unit settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, ImgList, Buttons;

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
    lblInterval: TLabel;
    udInterval: TUpDown;
    edInterval: TEdit;
    tabLayouts: TTabSheet;
    lnlAlignment: TLabel;
    cmbAlignment: TComboBox;
    lblType: TLabel;
    cmbType: TComboBox;
    procedure tbTransparencyChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbTransparencyClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure udIntervalChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure FormShow(Sender: TObject);
    procedure cmbAlignmentChange(Sender: TObject);
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

procedure TfrSettings.tbTransparencyChange(Sender: TObject);
begin
  ConfigFile.WriteInteger('appearance','transparency',tbTransparency.Position);
  frIndicator.AlphaBlendValue := tbTransparency.Position;
end;

procedure TfrSettings.FormCreate(Sender: TObject);
begin
  // —тавим галочки ;)
  //  стати, этот код работает только потому, что форма с индикатором
  // создаЄтс€ раньше, чем форма настроек
  cbTransparency.Checked := frIndicator.AlphaBlend;
  tbTransparency.Enabled := frIndicator.AlphaBlend;
  tbTransparency.Position := frIndicator.AlphaBlendValue;
  udInterval.Position := frIndicator.Timer1.Interval;
end;

procedure TfrSettings.FormShow(Sender: TObject);
begin
{  with cmbAlignment do
    if HAlign = 1 then
      ItemIndex := VAlign - 1;
    else}
  cmbAlignment.ItemIndex := VAlign * HAlign - 1;
end;

procedure TfrSettings.cbTransparencyClick(Sender: TObject);
begin
  ConfigFile.WriteBool('appearance','transparent',cbTransparency.Checked);
  tbTransparency.Enabled := cbTransparency.Checked;
  frIndicator.AlphaBlend := tbTransparency.Enabled;
end;

procedure TfrSettings.btnCloseClick(Sender: TObject);
begin
  Hide;
end;

procedure TfrSettings.udIntervalChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  ConfigFile.WriteInteger('settings','interval',udInterval.Position);
  frIndicator.Timer1.Interval := udInterval.Position;
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
  ConfigFile.WriteInteger('appearance','halign',HAlign);
  ConfigFile.WriteInteger('appearance','valign',VAlign);
end;

end.
