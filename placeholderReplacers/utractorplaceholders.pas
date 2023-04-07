unit UTractorPlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetTractorPlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function RangeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'max_length'));
end;

function SpeedReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'reach_speed'));
end;

function GetTractorPlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 4);

  Result[0].Placeholder := '$range';
  Result[0].Replacer := @RangeReplacer;

  Result[1].Placeholder := '$speed';
  Result[1].Replacer := @SpeedReplacer;

  Result[2] := GetMassReplacer;
  Result[3] := GetVolumeReplacer;
end;

end.
