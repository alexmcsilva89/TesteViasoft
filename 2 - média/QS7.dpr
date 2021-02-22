program QS7;

uses
  uTroco in 'uTroco.pas',
  uIMaquina in 'uIMaquina.pas',
  uMaquina in 'uMaquina.pas', System.Classes, System.SysUtils;

{$R *.RES}
{$APPTYPE CONSOLE}
var
  LValorTroco: Double;
  LMaquina: IMaquina;
  LTroco: TList;
  LCedula: TTroco;
begin
  Writeln('Informe o valor do troco: ');
  Readln(LValorTroco);

  LMaquina := TMaquina.Create;
  LTroco := LMaquina.MontarTroco(LValorTroco);
  try
     Writeln('A entrada é '+FloatToStr(LValorTroco)+' e a saída é ');
     Writeln(LMaquina.ExibirTroco(LTroco));
     WriteLn('Pressione Enter para sair');
     ReadLn;
  finally
    for LCedula in LTroco do
      LCedula.Destroy;
    LTroco.Destroy;
  end;
end.

