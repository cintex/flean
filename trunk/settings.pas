unit settings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, ImgList;

type
  TfrSettings = class(TForm)
    pnlBottom: TPanel;
    btnClose: TButton;
    Tabs: TPageControl;
    tabSettings: TTabSheet;
    tabAbout: TTabSheet;
    lblFlean: TLabel;
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frSettings: TfrSettings;

implementation

{$R *.dfm}

procedure TfrSettings.btnCloseClick(Sender: TObject);
begin
  Hide;
end;

end.
