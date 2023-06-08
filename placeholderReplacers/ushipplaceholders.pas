unit UShipPlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetShipPlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function CargoSpaceReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'hold_size'));
end;

function ShieldBatteriesReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'shield_battery_limit'));
end;

function NanobotsReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := ParseFloatStringToNumberString(FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'nanobot_limit'));
end;
       
//function HpTypesCounter(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt; const HpTypes: array of String): TBytes;
//var
//  LineNumber: ValSInt;
//  Line: String;
//  SplitLine: array of String;
//  Index: ValSInt;
//begin
//  Result := nil;
//  SetLength(Result, Length(HpTypes));
//  for Index := 0 to High(Result) do
//    Result[Index] := 0;
//
//  for LineNumber := BlockBeginLineNumber to BlockEndLineNumber do
//  begin
//    Line := FileStrings.Strings[LineNumber].Trim.ToLower;
//    if Line.StartsWith('hp_type') then
//    begin
//      SplitLine := Line.Substring(Line.IndexOf('=') + 1).Split(',');
//      if (Length(SplitLine) > 1) then
//        for Index := 0 to High(HpTypes) do
//          if SplitLine[0].Trim = HpTypes[Index].ToLower then
//            Result[Index] := Length(SplitLine) - 1;
//    end;
//  end;
//end;
//
//function DroppersReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
//var
//  HpTypesCount: TBytes;
//begin
//  HpTypesCount := HpTypesCounter(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, ['hp_mine_dropper', 'hp_countermeasure_dropper']);
//  Result := IntToStr(HpTypesCount[0]) + ' Mine, ' + IntToStr(HpTypesCount[1]) + ' CM';
//end;
//
//function ThrustersReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
//var
//  HpTypesCount: TBytes;
//begin
//  HpTypesCount := HpTypesCounter(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, ['hp_thruster']);
//  Result := IntToStr(HpTypesCount[0]);
//end;
//
//function PowersReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
//var
//  HpTypesCount: TBytes;
//begin
//  HpTypesCount := HpTypesCounter(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, [ 'hp_fighter_power_special_1',
//                                                                                          'hp_fighter_power_special_2',
//                                                                                          'hp_fighter_power_special_3',
//                                                                                          'hp_fighter_power_special_4',
//                                                                                          'hp_freighter_power_special_1',
//                                                                                          'hp_freighter_power_special_2',
//                                                                                          'hp_freighter_power_special_3',
//                                                                                          'hp_freighter_power_special_8',
//                                                                                          'hp_freighter_power_special_9',
//                                                                                          'hp_freighter_power_special_10'
//                                                                                         ]);
//  Result := IntToStr(HpTypesCount[0]);
//end;

function GetShipPlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 5);

  Result[0].Placeholder := '$cargoSpace';
  Result[0].Replacer := @CargoSpaceReplacer;

  Result[1].Placeholder := '$shieldBatteries';
  Result[1].Replacer := @ShieldBatteriesReplacer;

  Result[2].Placeholder := '$nanobots';
  Result[2].Replacer := @NanobotsReplacer;

  //Result[3].Placeholder := '$turnRatePitch';
  //Result[3].Replacer := @TurnRatePitchReplacer;
  //
  //Result[3].Placeholder := '$turnRateYaw';
  //Result[3].Replacer := @TurnRateYawReplacer;
  //
  //Result[3].Placeholder := '$turnRateRoll';
  //Result[3].Replacer := @TurnRateRollReplacer;
  //
  //Result[4].Placeholder := '$guns';
  //Result[4].Replacer := @GunsReplacer;
  //
  //Result[5].Placeholder := '$turrets';
  //Result[5].Replacer := @TurretsReplacer;
  //
  //Result[5].Placeholder := '$droppers';
  //Result[5].Replacer := @DroppersReplacer;
  //
  //Result[5].Placeholder := '$shields';
  //Result[5].Replacer := @ShieldsReplacer;
  //
  //Result[5].Placeholder := '$thrusters';
  //Result[5].Replacer := @ThrustersReplacer;
  //
  //Result[5].Placeholder := '$powers';
  //Result[5].Replacer := @PowersReplacer;
  //
  //Result[5].Placeholder := '$engines';
  //Result[5].Replacer := @EnginesReplacer;

  Result[3] := GetMassReplacer;
  Result[4] := GetHitpointsReplacer;
end;

end.
