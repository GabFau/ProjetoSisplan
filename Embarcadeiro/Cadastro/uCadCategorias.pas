unit uCadCategorias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, cCadCategoria, uDTMConexao, uEnum;

type
  TfrmCadCategorias = class(TfrmTelaHeranca)
    edtCodigo: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAlterarClick(Sender: TObject);
    procedure grdListagemTitleClick(Column: TColumn);
  private
    { Private declarations }
    oCategoria:TCategoria;
    function Excluir:Boolean; override;
    function Gravar(EstadoDoCadastro:TEstadoDoCadastro):Boolean; override;
  public
    { Public declarations }
  end;

var
  frmCadCategorias: TfrmCadCategorias;

implementation

{$R *.dfm}

{$region 'Override'}
procedure TfrmCadCategorias.btnAlterarClick(Sender: TObject);
begin
    ControlarBotoes(btnIncluir,btnAlterar,btnCancelar,btnGravar, btnExcluir, pgcPrincipal, false);
    EstadoDoCadastro:=ecAlterar;
  inherited;
end;

function TfrmCadCategorias.Excluir: Boolean;
begin
  if (oCategoria.Selecionar(QryListagem.FieldByName('CODIGO').AsInteger)) then begin
  Result:=oCategoria.Excluir;
end;
end;

function TfrmCadCategorias.Gravar(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
begin
if edtCodigo.Text<>EmptySTr then
oCategoria.Codigo:=StrtoInt(edtCodigo.text)
else oCategoria.Codigo:=0;

oCategoria.Descricao:=edtDescricao.Text;


if (EstadoDoCadastro=ecIncluir) then
Result:=oCategoria.Incluir
else if (EstadoDoCadastro=ecAlterar) then
Result:=oCategoria.Alterar;

end;
procedure TfrmCadCategorias.grdListagemTitleClick(Column: TColumn);
begin
  inherited;

end;

{$endregion 'Override'}

procedure TfrmCadCategorias.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCategoria) then
  FreeAndNil(oCategoria);


end;

procedure TfrmCadCategorias.FormCreate(Sender: TObject);
begin
  inherited;
  oCategoria:=TCategoria.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual:='CODIGO';
end;

end.
