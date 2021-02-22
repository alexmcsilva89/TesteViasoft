program QS6;

uses
  SysUtils,
  uISubstitui in 'uISubstitui.pas',
  uSubstitui in 'uSubstitui.pas';

{$R *.RES}
{$APPTYPE CONSOLE}
var
  LTexto: String;
  LVelho: String;
  LNovo: String;
  LSubstitui: iSubstitui;
begin
  Writeln('Informe um texto a ser substituído: ');
  ReadLn(LTexto);

  Writeln('Informe o fragmento de texto a ser substituído: ');
  ReadLn(LVelho);

  Writeln('Informe um novo fragmento de texto para ser substituído: ');
  ReadLn(LNovo);

  LSubstitui := TSubstitui.Create;
  Writeln('Texto substituído com o novo fragmento: ');
  Writeln(LSubstitui.Substituir(LTexto,LVelho,LNovo));
  WriteLn('Pressione Enter para sair');
  ReadLn;
end.

