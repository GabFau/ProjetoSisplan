unit uDTMConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client, IdStack;  // Adicionando IdStack para pegar o IP

type
  TdtmPrincipal = class(TDataModule)
    ConexaoDB: TFDConnection;
    dtmFBLink: TFDPhysFBDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ConexaoDBBeforeConnect(Sender: TObject);
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmPrincipal.ConexaoDBBeforeConnect(Sender: TObject);
var
  LocalIP: string;
begin
  // Obtém o primeiro IP da máquina local
  if GStack.LocalAddresses.Count > 0 then
    LocalIP := GStack.LocalAddresses[0]
  else
    LocalIP := '127.0.0.1'; // Caso não encontre, usa localhost

  // Define o IP no FireDAC
  TFDConnection(Sender).Params.Values['Server'] := LocalIP;
end;

end.

