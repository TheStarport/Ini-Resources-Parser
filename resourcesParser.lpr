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
  SysUtils,
  Forms,
  UMainForm;

{$R *.res}

begin
  DefaultFormatSettings.DecimalSeparator := '.';      
  DefaultFormatSettings.ThousandSeparator := ',';
  RequireDerivedFormResource := True;
  Application.Title := 'Resources Parser';
  Application.Scaled := True;
  Application.Initialize;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
