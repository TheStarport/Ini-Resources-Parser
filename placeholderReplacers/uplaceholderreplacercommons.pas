unit UPlaceholderReplacerCommons;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils;

type
  TReplacer = function(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;

  TPlaceholderReplacer = record
    Placeholder: String;
    Replacer: TReplacer;
  end;
  TPlaceholderReplacerArray = array of TPlaceholderReplacer;

function ParseFloatStringToNumberString(const Val: String): String;
function GetMassReplacer: TPlaceholderReplacer;
function GetVolumeReplacer: TPlaceholderReplacer;
function GetHitpointsReplacer: TPlaceholderReplacer;
function GetPowerUsageReplacer: TPlaceholderReplacer;

implementation

uses
  UBlockParsing;

function ParseFloatStringToNumberString(const Val: String): String;
var
  Parsed: Single;
begin
  Result := Val;
  if TryStrToFloat(Result, Parsed) then
    Result := Parsed.ToString(TFloatFormat.ffNumber, 0, 2).TrimRight('0').TrimRight('.');
end;

function MassReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'mass'));
end;

function GetMassReplacer: TPlaceholderReplacer;
begin
  Result.Placeholder := '$mass';
  Result.Replacer := @MassReplacer;
end;

function VolumeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'volume'));
end;

function GetVolumeReplacer: TPlaceholderReplacer;
begin
  Result.Placeholder := '$volume';
  Result.Replacer := @VolumeReplacer;
end;

function HitpointsReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'hit_pts'));
end;

function GetHitpointsReplacer: TPlaceholderReplacer;
begin
  Result.Placeholder := '$hitpoints';
  Result.Replacer := @HitpointsReplacer;
end;

function PowerUsageReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'power_usage'));
end;

function GetPowerUsageReplacer: TPlaceholderReplacer;
begin
  Result.Placeholder := '$powerUsage';
  Result.Replacer := @PowerUsageReplacer;
end;

end.
