unit UPlaceholderReplacing;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils;
                        
procedure ReplaceResourcePlaceholders(const FileStrings: TStringList; const FileStringsLineNumber: ValSInt; const Resource: TStringList);

implementation

uses
  UBlockParsing,
  UPlaceholderReplacerCommons,
  UPowerPlaceholders;

procedure ReplacePlaceholders(const FileStrings: TStringList; const FileStringsLineNumber: ValSInt; const Resource: TStringList; const PlaceholderReplacers: TPlaceholderReplacerArray);
var
  BlockLineNumber: ValSInt;
  BlockEndLineNumber: ValSInt;
  ResourceLineNumber: ValSInt;
  PlaceholderReplacer: TPlaceholderReplacer;
begin
  BlockLineNumber := FindBlockBegin(FileStrings, FileStringsLineNumber);
  if BlockLineNumber < 0 then
    Exit;

  BlockEndLineNumber := FindBlockEnd(FileStrings, FileStringsLineNumber);

  for ResourceLineNumber := 0 to Resource.Count - 1 do
    for PlaceholderReplacer in PlaceholderReplacers do
      if Resource.Strings[ResourceLineNumber].Contains(PlaceholderReplacer.Placeholder) then
        Resource.Strings[ResourceLineNumber] := Resource.Strings[ResourceLineNumber].Replace(PlaceholderReplacer.Placeholder, PlaceholderReplacer.Replacer(FileStrings, BlockLineNumber + 1, BlockEndLineNumber));
end;

procedure ReplaceResourcePlaceholders(const FileStrings: TStringList; const FileStringsLineNumber: ValSInt; const Resource: TStringList);
var
  BlockType: String;
begin
  BlockType := FindBlockType(FileStrings, FileStringsLineNumber).Trim.ToLower;
  case BlockType of
    'power': ReplacePlaceholders(FileStrings, FileStringsLineNumber, Resource, GetPowerPlaceholderReplacers);
  end;
end;

end.

