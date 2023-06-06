unit UProjectileReplacers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UBlockParsing;

function FindProjectileArch(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): TBlockPositions;
function LifetimeReplacer(const ProjectileArch: TBlockPositions): String;
function RangeReplacer(const ProjectileArch: TBlockPositions): String;
function DiversionReplacer(const ProjectileArch: TBlockPositions): String;
function TopSpeedReplacer(const ProjectileArch: TBlockPositions): String;
function AccelerationReplacer(const ProjectileArch: TBlockPositions): String;
function SeekRangeReplacer(const ProjectileArch: TBlockPositions): String;
function DetonationDistanceReplacer(const ProjectileArch: TBlockPositions): String;
function SafeTimeReplacer(const ProjectileArch: TBlockPositions): String;
function HullDamageReplacer(const ProjectileArch: TBlockPositions): String;
function EnergyDamageReplacer(const ProjectileArch: TBlockPositions): String;
function ImpulseReplacer(const ProjectileArch: TBlockPositions): String;
function ExplosionRadiusReplacer(const ProjectileArch: TBlockPositions): String;

implementation

uses
  UPlaceholderReplacerCommons,
  UExplosionReplacers;

const
  ShieldDamageFactor = 0.5;

function FindProjectileArch(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): TBlockPositions;
var
  ProjectileNickname: String;
begin
  Result.Strings := FileStrings;
  Result.BeginLineNumber := -1;
  Result.EndLineNumber := -1;
  ProjectileNickname := FindKeyValue(FileStrings, BlockBeginLineNumber, BlockEndLineNumber, 'projectile_archetype');
  if ProjectileNickname.Length > 0 then
  begin
    Result.BeginLineNumber := FindBlockBeginByNickname(FileStrings, ProjectileNickname) + 1;
    Result.EndLineNumber := FindBlockEnd(FileStrings, Result.BeginLineNumber);
  end;
end;

function LifetimeReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber, 'lifetime'));
end;

function RangeReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber, 'range'));
end;

function DiversionReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber, 'diversion_pctg'));
end;

function TopSpeedReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber, 'top_speed'));
end;

function AccelerationReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber, 'acceleration'));
end;

function SeekRangeReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber, 'seek_dist'));
end;

function DetonationDistanceReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber, 'detonation_dist'));
end;

function SafeTimeReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := ParseFloatStringToNumberString(FindKeyValue(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber, 'owner_safe_time'));
end;

function HullDamageReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := UExplosionReplacers.HullDamageReplacer(FindExplosionArch(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber));
end;

function EnergyDamageReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := UExplosionReplacers.EnergyDamageReplacer(FindExplosionArch(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber));
end;

function ImpulseReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := UExplosionReplacers.ImpulseReplacer(FindExplosionArch(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber));
end;

function ExplosionRadiusReplacer(const ProjectileArch: TBlockPositions): String;
begin
  Result := '';
  if (ProjectileArch.BeginLineNumber >= 0) and (ProjectileArch.EndLineNumber > ProjectileArch.BeginLineNumber) then
    Result := UExplosionReplacers.ExplosionRadiusReplacer(FindExplosionArch(ProjectileArch.Strings, ProjectileArch.BeginLineNumber, ProjectileArch.EndLineNumber));
end;

end.
