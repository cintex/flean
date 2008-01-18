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
    tabLayouts: TTabSheet;
    lnlAlignment: TLabel;
    cmbAlignment: TComboBox;
    lblShow: TLabel;
    cmbShow: TComboBox;
    lblAuthors: TLabel;
    memAuthors: TMemo;
    procedure tbTransparencyChange(Sender: TObject);
    procedure cbTransparencyClick(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbAlignmentChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cmbShowChange(Sender: TObject);
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
  ConfigFile.WriteInteger('settings','transparency',tbTransparency.Position);
  frIndicator.AlphaBlendValue := tbTransparency.Position;
end;

procedure TfrSettings.FormShow(Sender: TObject);
begin
  // Ставим галочки ;)
  cbTransparency.Checked := frIndicator.AlphaBlend;
  tbTransparency.Enabled := frIndicator.AlphaBlend;
  tbTransparency.Position := frIndicator.AlphaBlendValue;
  cmbAlignment.ItemIndex := VAlign-1+3*(HAlign-1);
  cmbShow.ItemIndex := IndType;
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
begin
  frSettings.memAuthors.Lines.LoadFromFile('docs\authors.txt');
end;

procedure TfrSettings.cmbShowChange(Sender: TObject);
begin
  ConfigFile.WriteInteger('settings','type',cmbShow.ItemIndex);
  IndType := cmbShow.ItemIndex;
end;

end.
