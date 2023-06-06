unit UPowerPlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetPowerPlaceholderReplacers: TPlaceholderReplacerArray;        
function GetPowerClassHandle(const PowerHardpointType: String): String;

implementation

uses
  UBlockParsing;

function GetPowerClassHandle(const PowerHardpointType: String): String;
begin
  case PowerHardpointType.ToLower of
    'hp_fighter_power_special_1': Result := 'L';
    'hp_fighter_power_special_2': Result := 'M';
    'hp_fighter_power_special_3': Result := 'H';
    'hp_fighter_power_special_4': Result := 'X';
    'hp_freighter_power_special_1': Result := 'L';
    'hp_freighter_power_special_2': Result := 'M';
    'hp_freighter_power_special_3': Result := 'H';
    'hp_freighter_power_special_8': Result := 'L';
    'hp_freighter_power_special_9': Result := 'M';
    'hp_freighter_power_special_10': Result := 'H';
    else
      Result := '';
  end;
end;

function ShortClassReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := GetPowerClassHandle(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'hp_type'));
end;

function LongClassReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  case FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'hp_type') of
    'hp_fighter_power_special_1': Result := 'Light';
    'hp_fighter_power_special_2': Result := 'Medium';
    'hp_fighter_power_special_3': Result := 'Heavy';
    'hp_fighter_power_special_4': Result := 'Super Heavy';
    'hp_freighter_power_special_1': Result := 'Light';
    'hp_freighter_power_special_2': Result := 'Medium';
    'hp_freighter_power_special_3': Result := 'Heavy';
    'hp_freighter_power_special_8': Result := 'Light';
    'hp_freighter_power_special_9': Result := 'Medium';
    'hp_freighter_power_special_10': Result := 'Heavy';
    else
      Result := '';
  end;
end;

function CapacityReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'capacity'));
end;

function ChargeRateReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'charge_rate'));
end;

function ThrustCapacityReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'thrust_capacity'));
end;
             
function ThrustChargeRateReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'thrust_charge_rate'));
end;

function GetPowerPlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 8);

  Result[0].Placeholder := '$classLong';
  Result[0].Replacer := @LongClassReplacer;

  Result[1].Placeholder := '$class';
  Result[1].Replacer := @ShortClassReplacer;

  Result[2].Placeholder := '$capacity';
  Result[2].Replacer := @CapacityReplacer;

  Result[3].Placeholder := '$chargeRate';
  Result[3].Replacer := @ChargeRateReplacer;

  Result[4].Placeholder := '$thrustCapacity';
  Result[4].Replacer := @ThrustCapacityReplacer;

  Result[5].Placeholder := '$thrustChargeRate';
  Result[5].Replacer := @ThrustChargeRateReplacer;

  Result[6] := GetMassReplacer;
  Result[7] := GetVolumeReplacer;
end;

end.
