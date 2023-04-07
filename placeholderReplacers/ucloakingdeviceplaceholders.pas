unit UCloakingDevicePlaceholders;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils,
  UPlaceholderReplacerCommons;

function GetCloakingDevicePlaceholderReplacers: TPlaceholderReplacerArray;

implementation

uses
  UBlockParsing;

function GetCloakingDevicePlaceholderReplacers: TPlaceholderReplacerArray;
begin
  Result := nil;
  SetLength(Result, 3);

  Result[0] := GetHitpointsReplacer;
  Result[1] := GetMassReplacer;
  Result[2] := GetVolumeReplacer;
end;

end.
