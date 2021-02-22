unit uIMaquina;

interface

uses
  Classes;

type

  IMaquina = interface
    function MontarTroco(Troco: Double): TList;
    function ExibirTroco(aTroco: TList): String;
  end;

implementation

end.

