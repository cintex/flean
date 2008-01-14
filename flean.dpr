program flean;

uses
  Forms,
  main in 'main.pas' {Indicator};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Flean';
  Application.CreateForm(TIndicator, Indicator);
  Application.Run;

end.
