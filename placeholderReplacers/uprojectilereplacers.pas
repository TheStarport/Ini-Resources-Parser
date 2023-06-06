unit UProjectileReplacers;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  TBlockPositions = record
    Strings: TStrings;
    BeginLineNumber: ValSInt;
    EndLineNumber: ValSInt;
  end;

function FindProjectileArch(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): TBlockPositions;
function LifetimeReplacer(const ProjectileArch: TBlockPositions): String;         
function RangeReplacer(const ProjectileArch: TBlockPositions): String;
function DiversionReplacer(const ProjectileArch: TBlockPositions): String;

implementation

uses
  UPlaceholderReplacerCommons,
  UBlockParsing;

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

end.
