unit UCounterMeasureFlarePlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetCounterMeasureFlarePlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function RangeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'range'));
end;

function DiversionReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'diversion_pctg'));
end;

function LifetimeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'lifetime'));
end;

function GetCounterMeasureFlarePlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 6);

  Result[0].Placeholder := '$range';
  Result[0].Replacer := @RangeReplacer;

  Result[1].Placeholder := '$diversion';
  Result[1].Replacer := @DiversionReplacer;

  Result[2].Placeholder := '$lifetime';
  Result[2].Replacer := @LifetimeReplacer;

  Result[3] := GetHitpointsReplacer;
  Result[4] := GetMassReplacer;
  Result[5] := GetVolumeReplacer;
end;

end.
