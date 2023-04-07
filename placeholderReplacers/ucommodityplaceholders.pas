unit UCommodityPlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetCommodityPlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function DecayReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
var
  Hitpoints: String;
  Decay: String;
  ParsedHitpoints: Single;
  ParsedDecay: Single;
begin
  Result := '';
  Hitpoints := FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'hit_pts');
  Decay := FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'decay_per_second');
  if TryStrToFloat(Hitpoints, ParsedHitpoints) and TryStrToFloat(Decay, ParsedDecay) then
    Result := ParseFloatStringToNumberString(((ParsedDecay * 60) / ParsedHitpoints).ToString); // Decayed Commodity Units per Minute
end;

function GetCommodityPlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 3);

  Result[0].Placeholder := '$decay';
  Result[0].Replacer := @DecayReplacer;

  Result[1] := GetMassReplacer;
  Result[2] := GetVolumeReplacer;
end;

end.
