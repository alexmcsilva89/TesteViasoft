unit uMaquina;

interface

uses
  uIMaquina, Classes, uTroco;

type

  TMaquina = class(TInterfacedObject, IMaquina)
  private
    FTrocoControl: Double;
  public
    function MontarTroco(Troco: Double): TList;
    function ExibirTroco(aTroco: TList): string;
    constructor Create;
  end;

implementation

uses math, System.Generics.Collections, System.SysUtils;

constructor TMaquina.Create;
begin
  FTrocoControl := 0;
end;

function TMaquina.ExibirTroco(aTroco: TList): string;
var
  LCedula: TTroco;
begin
  Result := '';
  for LCedula in aTroco do
  begin
    case TCedula(LCedula.GetTipo) of
      ceNota100  : Result := Result + IntToStr(LCedula.GetQuantidade)+' nota(s) de '+FloatToStr(CValorCedula[TCedula.ceNota100])+#10#13;
      ceNota50   : Result := Result + IntToStr(LCedula.GetQuantidade)+' nota(s) de '+FloatToStr(CValorCedula[TCedula.ceNota50])+#10#13;
      ceNota20   : Result := Result + IntToStr(LCedula.GetQuantidade)+' nota(s) de '+FloatToStr(CValorCedula[TCedula.ceNota20])+#10#13;
      ceNota10   : Result := Result + IntToStr(LCedula.GetQuantidade)+' nota(s) de '+FloatToStr(CValorCedula[TCedula.ceNota10])+#10#13;
      ceNota5    : Result := Result + IntToStr(LCedula.GetQuantidade)+' nota(s) de '+FloatToStr(CValorCedula[TCedula.ceNota5])+#10#13;
      ceNota2    : Result := Result + IntToStr(LCedula.GetQuantidade)+' nota(s) de '+FloatToStr(CValorCedula[TCedula.ceNota2])+#10#13;
      ceMoeda100 : Result := Result + IntToStr(LCedula.GetQuantidade)+' moeda(s) de '+FloatToStr(CValorCedula[TCedula.ceMoeda100])+#10#13;
      ceMoeda50  : Result := Result + IntToStr(LCedula.GetQuantidade)+' moeda(s) de '+FloatToStr(CValorCedula[TCedula.ceMoeda50])+#10#13;
      ceMoeda25  : Result := Result + IntToStr(LCedula.GetQuantidade)+' moeda(s) de '+FloatToStr(CValorCedula[TCedula.ceMoeda25])+#10#13;
      ceMoeda10  : Result := Result + IntToStr(LCedula.GetQuantidade)+' moeda(s) de '+FloatToStr(CValorCedula[TCedula.ceMoeda10])+#10#13;
      ceMoeda5   : Result := Result + IntToStr(LCedula.GetQuantidade)+' moeda(s) de '+FloatToStr(CValorCedula[TCedula.ceMoeda5])+#10#13;
      ceMoeda1   : Result := Result + IntToStr(LCedula.GetQuantidade)+' moeda(s) de '+FloatToStr(CValorCedula[TCedula.ceMoeda1])+#10#13;
    end;
  end;
end;

function TMaquina.MontarTroco(Troco: Double): TList;
var
  LLista: TList;
  LCedula: TTroco;
  LDic: TDictionary<Double,TTroco>;

  procedure AdicionarTroco(aCedula: TCedula; aTroco: Double);
  var
    LQtde: Integer;
  begin
    repeat
      if FTrocoControl >= CValorCedula[aCedula] then
      begin
        LDic.TryGetValue(CValorCedula[aCedula],LCedula);
        if not Assigned(LCedula) then
        begin
          LCedula := TTroco.Create(aCedula,1);
          LDic.Add(CValorCedula[aCedula],LCedula);
        end
        else
        begin
          LQtde := LCedula.GetQuantidade;
          Inc(LQtde);
          LCedula.SetQuantidade(LQtde);
        end;

        FTrocoControl := FTrocoControl - CValorCedula[aCedula];
        FTrocoControl := RoundTo(FTrocoControl,-2);
      end;
    until FTrocoControl < CValorCedula[aCedula];
  end;
begin
  FTrocoControl := Troco;
  LLista := TList.Create;
  LDic  := TDictionary<Double,TTroco>.Create;

  try
    AdicionarTroco(TCedula.ceNota100,FTrocoControl);
    AdicionarTroco(TCedula.ceNota50,FTrocoControl);
    AdicionarTroco(TCedula.ceNota20,FTrocoControl);
    AdicionarTroco(TCedula.ceNota10,FTrocoControl);
    AdicionarTroco(TCedula.ceNota5,FTrocoControl);
    AdicionarTroco(TCedula.ceNota2,FTrocoControl);
    AdicionarTroco(TCedula.ceMoeda100,FTrocoControl);
    AdicionarTroco(TCedula.ceMoeda50,FTrocoControl);
    AdicionarTroco(TCedula.ceMoeda25,FTrocoControl);
    AdicionarTroco(TCedula.ceMoeda10,FTrocoControl);
    AdicionarTroco(TCedula.ceMoeda5,FTrocoControl);
    AdicionarTroco(TCedula.ceMoeda1,FTrocoControl);
  finally
    for LCedula in LDic.Values do
      LLista.Add(LCedula);
    LDic.Destroy;
    Result := LLista;
  end;
end;

end.

