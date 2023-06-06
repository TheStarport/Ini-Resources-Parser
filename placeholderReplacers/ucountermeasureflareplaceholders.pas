unit UCounterMeasureFlarePlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetCounterMeasureFlarePlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing,
  UProjectileReplacers;

function RangeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := UProjectileReplacers.RangeReplacer(TBlockPositions.Create(FileStrings, BlockBeginLineNumber, BlockEndLineNumber));
end;

function DiversionReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := UProjectileReplacers.DiversionReplacer(TBlockPositions.Create(FileStrings, BlockBeginLineNumber, BlockEndLineNumber));
end;

function LifetimeReplacer(const FileStrings: TStrings; const BlockBeginLineNumber: ValSInt; const BlockEndLineNumber: ValSInt): String;
begin
  Result := UProjectileReplacers.LifetimeReplacer(TBlockPositions.Create(FileStrings, BlockBeginLineNumber, BlockEndLineNumber));
end;

function GetCounterMeasureFlarePlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 6);

  Result[0].Placeholder := '$range';
  Result[0].Replacer := @RangeReplacer;

  Result[1].Placeholder := '$diversion';
  Result[1].Replacer := @DiversionReplacer;

  Result[2].Placeholder := '$lifetime';
  Result[2].Replacer := @LifetimeReplacer;

  Result[3] := GetHitpointsReplacer;
  Result[4] := GetMassReplacer;
  Result[5] := GetVolumeReplacer;
end;

end.
