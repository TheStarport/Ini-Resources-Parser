unit UExplosionReplacers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UBlockParsing;

function FindExplosionArch(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): TBlockPositions;
function HullDamageReplacer(const ExplosionArch: TBlockPositions): String;
function EnergyDamageReplacer(const ExplosionArch: TBlockPositions): String;
function ImpulseReplacer(const ExplosionArch: TBlockPositions): String;
function ExplosionRadiusReplacer(const ExplosionArch: TBlockPositions): String;

implementation

uses
  UPlaceholderReplacerCommons;

const
  ShieldDamageFactor = 0.5;

function FindExplosionArch(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): TBlockPositions;
var
  ExplosionNickname: String;
begin
  Result.Strings := FileStrings;
  Result.BeginLineNumber := -1;
  Result.EndLineNumber := -1;
  ExplosionNickname := FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'explosion_arch');
  if ExplosionNickname.Length > 0 then
  begin
    Result.BeginLineNumber := FindBlockBeginByNickname(FileStrings, ExplosionNickname) + 1;
    Result.EndLineNumber := FindBlockEnd(FileStrings, Result.BeginLineNumber);
  end;
end;

function HullDamageReplacer(const ExplosionArch: TBlockPositions): String;
begin
  Result := '';
  if (ExplosionArch.BeginLineNumber >= 0) and (ExplosionArch.EndLineNumber > ExplosionArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ExplosionArch.Strings, ExplosionArch.BeginLineNumber, ExplosionArch.EndLineNumber, 'hull_damage'));
end;

function EnergyDamageReplacer(const ExplosionArch: TBlockPositions): String;
var
  HullDamage: String;
  EnergyDamage: String;
  ParsedHullDamage: Single;
  ParsedEnergyDamage: Single;
begin
  Result := '';
  if (ExplosionArch.BeginLineNumber >= 0) and (ExplosionArch.EndLineNumber > ExplosionArch.BeginLineNumber) then
  begin
    HullDamage := FindKeyValue(ExplosionArch.Strings, ExplosionArch.BeginLineNumber, ExplosionArch.EndLineNumber, 'hull_damage');
    EnergyDamage := FindKeyValue(ExplosionArch.Strings, ExplosionArch.BeginLineNumber, ExplosionArch.EndLineNumber, 'energy_damage');
    if TryStrToFloat(HullDamage, ParsedHullDamage) and TryStrToFloat(EnergyDamage, ParsedEnergyDamage) then
      Result := ParseFloatStringToNumberString((ParsedHullDamage * ShieldDamageFactor + ParsedEnergyDamage).ToString);
  end;
end;

function ImpulseReplacer(const ExplosionArch: TBlockPositions): String;
begin
  Result := '';
  if (ExplosionArch.BeginLineNumber >= 0) and (ExplosionArch.EndLineNumber > ExplosionArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ExplosionArch.Strings, ExplosionArch.BeginLineNumber, ExplosionArch.EndLineNumber, 'impulse'));
end;

function ExplosionRadiusReplacer(const ExplosionArch: TBlockPositions): String;
begin
  Result := '';
  if (ExplosionArch.BeginLineNumber >= 0) and (ExplosionArch.EndLineNumber > ExplosionArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ExplosionArch.Strings, ExplosionArch.BeginLineNumber, ExplosionArch.EndLineNumber, 'radius'));
end;

end.
