unit UShieldGeneratorPlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetShieldGeneratorPlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function ShortClassReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  case FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'hp_type') of
    'hp_fighter_shield_special_1': Result := 'L';
    'hp_fighter_shield_special_2': Result := 'M';
    'hp_fighter_shield_special_3': Result := 'H';           
    'hp_freighter_shield_special_1': Result := 'X';
    else
      Result := '';
  end;
end;

function LongClassReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  case FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'hp_type') of
    'hp_fighter_shield_special_1': Result := 'Light';
    'hp_fighter_shield_special_2': Result := 'Medium';
    'hp_fighter_shield_special_3': Result := 'Heavy';
    'hp_freighter_shield_special_1': Result := 'Super Heavy';
    else
      Result := '';
  end;
end;

function RegenerationReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'regeneration_rate'));
end;

function CapacityReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'max_capacity'));
end;         

function ConstantPowerUsageReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'constant_power_draw'));
end;

function RebuildTimeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'offline_rebuild_time'));
end;

function RebuildThresholdReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
var
  Threshold: String;
  ParsedThreshold: Single;
begin
  Result := '';
  Threshold := FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'offline_threshold');
  if TryStrToFloat(Threshold, ParsedThreshold) then
    Result := ParseFloatStringToNumberString((ParsedThreshold * 100).ToString);
end;
            
function RebuildPowerUsageReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'rebuild_power_draw'));
end;       

function TypeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  case FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'shield_type') of
    's_molecular': Result := 'Molecular';
    's_graviton': Result := 'Graviton';
    's_positron': Result := 'Positron';
    's_neutrino': Result := 'Neutrino';
    else
      Result := '';
  end;
end;

function GetShieldGeneratorPlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 12);

  Result[0].Placeholder := '$classLong';
  Result[0].Replacer := @LongClassReplacer;

  Result[1].Placeholder := '$class';
  Result[1].Replacer := @ShortClassReplacer;

  Result[2].Placeholder := '$regeneration';
  Result[2].Replacer := @RegenerationReplacer;

  Result[3].Placeholder := '$capacity';
  Result[3].Replacer := @CapacityReplacer;  

  Result[4].Placeholder := '$constantPowerUsage';
  Result[4].Replacer := @ConstantPowerUsageReplacer;

  Result[5].Placeholder := '$rebuildTime';
  Result[5].Replacer := @RebuildTimeReplacer;   

  Result[6].Placeholder := '$rebuildThreshold';
  Result[6].Replacer := @RebuildTimeReplacer;

  Result[7].Placeholder := '$rebuildPowerUsage';
  Result[7].Replacer := @RebuildPowerUsageReplacer;
                                                         
  Result[8].Placeholder := '$type';
  Result[8].Replacer := @TypeReplacer;
                              
  Result[9] := GetHitpointsReplacer;
  Result[10] := GetMassReplacer;
  Result[11] := GetVolumeReplacer;
end;

end.
