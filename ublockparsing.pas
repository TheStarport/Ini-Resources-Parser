unit UBlockParsing;

{$mode ObjFPC}{$H+}

interface

uses
  Classes,
  SysUtils;

function FindBlockBegin(const Strings: TStringList; LineNumber: ValSInt): ValSInt;
function FindBlockEnd(const Strings: TStringList; LineNumber: ValSInt): ValSInt;
function FindBlockType(const Strings: TStringList; LineNumber: ValSInt): String;
function FindKeyValue(const Strings: TStrings; const StartLineNumber: ValSInt; const EndLineNumber: ValSInt; const Key: String): String;

implementation

function FindBlockBegin(const Strings: TStringList; LineNumber: ValSInt): ValSInt;
var
  Line: String;
begin
  Result := -1;
  for LineNumber := LineNumber downto 0 do
  begin
    Line := Strings.Strings[LineNumber].Trim;
    if Line.StartsWith('[') and Line.EndsWith(']') then
    begin
      Result := LineNumber;
      Break;
    end;
  end;
end;

function FindBlockEnd(const Strings: TStringList; LineNumber: ValSInt): ValSInt;
var
  Line: String;
begin
  Result := Strings.Count - 1;
  for LineNumber := LineNumber to Strings.Count - 1 do
  begin
    Line := Strings.Strings[LineNumber].Trim;
    if Line.StartsWith('[') and Line.EndsWith(']') then
    begin
      Result := LineNumber - 1;
      Break;
    end;
  end;
end;

function FindBlockType(const Strings: TStringList; LineNumber: ValSInt): String;
var
  Line: String;
begin
  Result := '';
  LineNumber := FindBlockBegin(Strings, LineNumber);
  if LineNumber >= 0 then
  begin
    Line := Strings.Strings[LineNumber].Trim;
    if Line.StartsWith('[') and Line.EndsWith(']') then
    begin
      Result := Line.Substring(1, Line.Length - 2);
    end;
  end;
end;

function FindKeyValue(const Strings: TStrings; const StartLineNumber: ValSInt; const EndLineNumber: ValSInt; const Key: String): String;
var
  LineNumber: ValSInt;
  Line: String;
begin
  Result := '';
  for LineNumber := StartLineNumber to EndLineNumber do
  begin
    Line := Strings.Strings[LineNumber].Trim.ToLower;
    if Line.StartsWith(Key) then
      Result := Line.Substring(Line.IndexOf('=') + 1).Trim;
  end;
end;

end.