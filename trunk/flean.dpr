program flean;

uses
  Forms,
  main in 'main.pas' {frIndicator},
  settings in 'settings.pas' {frSettings};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Flean';
  Application.CreateForm(TfrIndicator, frIndicator);
  Application.CreateForm(TfrSettings, frSettings);
  Application.Run;

end.
