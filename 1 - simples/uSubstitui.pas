unit uSubstitui;

interface

uses
  uISubstitui,strutils;

type
   TSubstitui = class(TInterfacedObject,ISubstitui)
   public
     function Substituir(Str: string; Velho: string; Novo: string): string;
   end;

implementation
{ TSubstitui }

function TSubstitui.Substituir(Str, Velho, Novo: string): string;
var
  LStrNova : String;
  LTamStr: Integer;
  LTamVelho: Integer;
  LIndiceInicial: Integer;

  LStrIni: String;
  LStrFim: String;
begin
  LStrNova := '';
  repeat
    LTamVelho := Length(Velho);
    LTamStr   := Length(Str);
    LIndiceInicial := Pos(Velho,Str);
    if LIndiceInicial <> 0 then
    begin
     LStrIni := Copy(Str,0,LIndiceInicial-1);
     LStrFim := Copy(Str,LIndiceInicial+LTamVelho,LTamStr);
     LStrNova := LStrIni+Novo+LStrFim;
     Str := LStrNova;
    end;
  until (LIndiceInicial = 0);
  Result := Str;
end;

end.

