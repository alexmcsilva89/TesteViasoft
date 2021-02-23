program QS8;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  uNetwork in 'uNetwork.pas';
type
  TOpcao = (enConectarElementos =1,enConsultarConexoes=2,enSair=3);
var
  LQtde : Integer;
  LNetWork :iNetwork;
  LElement1: Integer;
  LElement2: Integer;
  LConectado: Boolean;
  LMenu : String;
  LOpcao: Integer;
begin
  Writeln('Informe a quantidade de números do conjunto: ');
  ReadLn(LQtde);
  if LQtde <=0 then
    raise Exception.Create('valor inválido!');
  LNetWork := TFactoryNetwork.NewNewtork(LQtde);
  LMenu := '---------------MENU---------------'+#10#13+
           '1 - Conectar Elementos            '+#10#13+
           '2 - Consultar Conexões            '+#10#13+
           '3 - Sair                          ';
  repeat
    Writeln(LMenu);
    Readln(LOpcao);
    case TOpcao(LOpcao) of
      enConectarElementos:
      begin
        Writeln('Números do conjunto para conexão: ');
        Writeln(LNetWork.ExibirConjunto);
        Writeln('Informe o primeiro elemento para conectar');
        Readln(LElement1);
        Writeln('Informe o segundo elemento para conectar');
        Readln(LElement2);
        LNetWork.Conectar(LElement1,LElement2);
        Writeln(IntToStr(LElement1)+' conectado ao '+IntToStr(LElement2)+'!');
        WriteLn('Pressione qualquer tecla para voltar ao menu principal');
        ReadLn;
      end;
      enConsultarConexoes:
      begin
        Writeln('Informe o primeiro elemento para consultar');
        Readln(LElement1);

        Writeln('Informe o segundo elemento para consultar');
        Readln(LElement2);

        LConectado := LNetWork.Consultar(LElement1,LElement2);
        if LConectado then
          Writeln('O elemento '+IntToStr(LElement1)+' esta conectado com o elemento '+ IntToStr(LElement2))
        else
          Writeln('O elemento '+IntToStr(LElement1)+' não esta conectado com o elemento '+ IntToStr(LElement2));
      end;
    end;
  until (LOpcao = 3);
end.
