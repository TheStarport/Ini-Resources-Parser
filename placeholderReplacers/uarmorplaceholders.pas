unit UArmorPlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetArmorPlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function HitpointsScaleReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
var
  Scale: String;
  ParsedScale: Single;
begin
  Result := '';
  Scale := FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'hit_pts_scale');
  if TryStrToFloat(Scale, ParsedScale) then
    Result := ParseFloatStringToNumberString((ParsedScale * 100).ToString);
end;

function GetArmorPlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 3);

  Result[0].Placeholder := '$scale';
  Result[0].Replacer := @HitpointsScaleReplacer;

  Result[1] := GetMassReplacer;
  Result[2] := GetVolumeReplacer;
end;

end.
