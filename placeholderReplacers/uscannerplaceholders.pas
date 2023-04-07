unit UScannerPlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetScannerPlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function RangeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'range'));
end;

function CargoRangeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'cargo_scan_range'));
end;

function GetScannerPlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 4);

  Result[0].Placeholder := '$range';
  Result[0].Replacer := @RangeReplacer;

  Result[1].Placeholder := '$cargoRange';
  Result[1].Replacer := @CargoRangeReplacer;

  Result[2] := GetMassReplacer;
  Result[3] := GetVolumeReplacer;
end;

end.
