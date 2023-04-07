unit UThrusterPlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetThrusterPlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function ForceReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
var
  Force: String;
  ParsedForce: Single;
begin
  Result := '';
  Force := FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'max_force');
  if TryStrToFloat(Force, ParsedForce) then
    Result := ParseFloatStringToNumberString((ParsedForce / 600).ToString); // 600 being the default Fighter/Freighter linear drag.
end;

function GetThrusterPlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 4);

  Result[0].Placeholder := '$speed';
  Result[0].Replacer := @ForceReplacer;

  Result[1] := GetPowerUsageReplacer;

  Result[2] := GetMassReplacer;
  Result[3] := GetVolumeReplacer;
end;

end.
