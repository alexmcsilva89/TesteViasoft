unit uNetwork;

interface
type 
  iNetwork = interface
  ['{460FB4BA-93E0-4D18-91F6-5B5D88AAA321}']
    procedure Conectar(aNumElement1: Integer; aNumElement2: Integer);
    function Consultar(aNumElement1: Integer; aNumElement2: Integer): Boolean;
    function ExibirConjunto: String;
  end;
  
  TFactoryNetwork = class
    class function NewNewtork(aNumElement: Integer): iNetwork;
  end;

implementation

uses
  System.SysUtils, System.Generics.Collections;
type
  TConexoes = class
  private
    FElement1: Integer;
    FElement2: Integer;
  public
    constructor Create(aConexao1 : Integer; aConexao2: Integer);
  end;

  TNetwork = class(TInterfacedObject,iNetwork)
  private
    FCountConections: Integer;
    FNumElement: Integer;
    FListNums: TList<Integer>;
    FListConections: TDictionary<Integer,TConexoes>;
    function BuscaNaLista(aNumElement1: Integer; aNumElement2: Integer): Boolean;
  public
    constructor Create(aNumElement: Integer);
    procedure Conectar(aNumElement1: Integer; aNumElement2: Integer);
    function Consultar(aNumElement1: Integer; aNumElement2: Integer): Boolean;
    function ExibirConjunto: String;
  end;

{ TNetwork }

function TNetwork.BuscaNaLista(aNumElement1: Integer; aNumElement2: Integer): Boolean;
var
  LCon: TConexoes;
  I: Integer;
begin
  Result := False;

  for I := 1 to FListConections.Count do
  begin
    LCon := FListConections.Items[I];
    if LCon.FElement1 = aNumElement1 then
    begin
      if LCon.FElement2 = aNumElement2 then
        Exit(True)
      else
        Result := BuscaNaLista(LCon.FElement2,aNumElement2);
    end
    else if LCon.FElement2 = aNumElement2 then
    begin
      if LCon.FElement1 = aNumElement1 then
        Exit(True)
      else
        Result := BuscaNaLista(LCon.FElement1,aNumElement1);
    end
    else if LCon.FElement1 = aNumElement2 then
    begin
      if LCon.FElement2 = aNumElement1 then
        Exit(True)
      else
        Result := BuscaNalista(LCon.FElement1,aNumElement2);
    end;
  end;
end;

procedure TNetwork.Conectar(aNumElement1: Integer; aNumElement2: Integer);
var
  LCon: TConexoes;
begin
  if aNumElement1 <= 0 then
    raise Exception.Create('Elemento 1 inválido, informe um valor maior que 0!');

  if aNumElement2 <= 0 then
    raise Exception.Create('Elemento 2 inválido, informe um valor maior que 0!');

  for LCon in FListConections.Values do
  begin
    if (LCon.FElement1 = aNumElement1) and (LCon.FElement2 = aNumElement1) then
      raise Exception.Create('Conexão de elemento 1 com elemento 2 já existe!');
    if (LCon.FElement2 = aNumElement1) and (LCon.FElement1 = aNumElement2) then
      raise Exception.Create('Conexão de elemento 2 com elemento 1 já existe!');
  end;
  Inc(FCountConections);
  FListConections.Add(FCountConections,TConexoes.Create(aNumElement1,aNumElement2));
end;

function TNetwork.Consultar(aNumElement1, aNumElement2: Integer): Boolean;
var
  LElement: TConexoes;
begin
  if aNumElement1 <= 0 then
    raise Exception.Create('Elemento 1 inválido, informe um valor maior que 0!');

  if aNumElement2 <= 0 then
    raise Exception.Create('Elemento 2 inválido, informe um valor maior que 0!');

  for LElement in FListConections.Values do
  begin
    if (LElement.FElement1 = aNumElement1) and (LElement.FElement2 = aNumElement2) then
       Exit(True);

    if (LElement.FElement2 = aNumElement1) and (LElement.FElement1 = aNumElement2) then
       Exit(True);
  end;
  Result := BuscaNaLista(aNumElement1,aNumElement2);
end;

constructor TNetwork.Create(aNumElement: Integer);
var
  I: Integer;
begin
  FListNums := TList<Integer>.Create;
  FListConections := TDictionary<Integer,TConexoes>.Create;
  try
   if aNumElement <= 0 then
    raise Exception.Create('Informe um valor válido!');

    FNumElement := aNumElement;

    for I := 1 to FNumElement do
      FListNums.Add(I);
  except
    FListNums.Destroy;
    FListConections.Destroy;
  end;
end;

function TNetwork.ExibirConjunto: String;
var
  I: Integer;
  LArray : TArray<Integer>;
  LConjunto : String;
begin
  LConjunto := '';
  LArray := FListNums.ToArray;
  TArray.Sort<Integer>(LArray);

  for I in LArray do
    LConjunto := LConjunto+IntToStr(I)+#10#13;
  Result :=LConjunto;
end;

{ TConexoes }
constructor TConexoes.Create(aConexao1, aConexao2: Integer);
begin
  FElement1 := aConexao1;
  FElement2 := aConexao2;
end;

{ TFactoryNetwork }

class function TFactoryNetwork.NewNewtork(aNumElement: Integer): iNetwork;
begin
  Result := TNetwork.Create(aNumElement);
end;

end.
