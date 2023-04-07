unit URepairPlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetRepairPlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function GetRepairPlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 3);

  Result[0] := GetHitpointsReplacer;
  Result[1] := GetMassReplacer;
  Result[2] := GetVolumeReplacer;
end;

end.
