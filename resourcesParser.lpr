program resourcesParser;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  {$IFDEF HASAMIGA}
  athreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms,
  UMainForm,
  UBlockParsing,
  UPowerPlaceholders,
  UPlaceholderReplacing,
  UPlaceholderReplacerCommons,
  UResourceParsing;

{$R *.res}

begin
  RequireDerivedFormResource := True;
  Application.Title := 'Resources Parser';
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
