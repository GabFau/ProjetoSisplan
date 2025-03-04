unit uPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, uDTMConexao, Vcl.Mask;

type
    TfrmPesquisa = class(TForm)
    grdPesquisa: TDBGrid;
    pnlPesquisa2: TPanel;
    btnConfirmar: TBitBtn;
    btnCancelar: TBitBtn;
    dtPesquisa: TDataSource;
    QryPesquisa: TFDQuery;
    pnlPesquisa1: TPanel;
    lblIndice: TLabel;
    Label1: TLabel;
    mskPesquisa: TMaskEdit;
    procedure btnCancelarClick(Sender: TObject);
    procedure grdPesquisaDblClick(Sender: TObject);
    procedure grdPesquisaTitleClick(Column: TColumn);
    procedure mskPesquisaChange(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
  private
    procedure ExibirLabelIndice(Campo: string; aLabel: TLabel);
    function RetornarCampoTraduzido(Campo: String): String;
    { Private declarations }
  public
    { Public declarations }
    ValorSelecionado: String;
    IndiceAtual:string;
  end;

var
  frmPesquisa: TfrmPesquisa;

implementation

{$R *.dfm}

function TfrmPesquisa.RetornarCampoTraduzido(Campo:String):String;
var I:Integer;
begin

  for I := 0 to QryPesquisa.Fields.Count-1 do begin
    if lowercase(QryPesquisa.Fields[i].FieldName)=lowercase(Campo) then begin
      Result:=QryPesquisa.Fields[i].DisplayLabel;
      Break;
    end;

  end;

end;

procedure TfrmPesquisa.btnConfirmarClick(Sender: TObject);
begin
  if not grdPesquisa.DataSource.DataSet.IsEmpty then
  begin
    ValorSelecionado := grdPesquisa.DataSource.DataSet.FieldByName('DESCRICAO').AsString;
    ModalResult := mrOk;
  end;
end;

procedure TfrmPesquisa.ExibirLabelIndice(Campo:string; aLabel:TLabel);
begin
  aLabel.Caption:=RetornarCampoTraduzido(Campo);
end;


procedure TfrmPesquisa.btnCancelarClick(Sender: TObject);
begin
Close;
end;

procedure TfrmPesquisa.grdPesquisaDblClick(Sender: TObject);
begin
btnConfirmar.Click;
end;

procedure TfrmPesquisa.grdPesquisaTitleClick(Column: TColumn);
begin
  IndiceAtual := Column.FieldName;
  QryPesquisa.IndexFieldNames:=IndiceAtual;
  ExibirLabelIndice(IndiceAtual, lblIndice);
end;

procedure TfrmPesquisa.mskPesquisaChange(Sender: TObject);
begin
QryPesquisa.Locate(IndiceAtual, TMaskEdit(Sender).Text, [loPartialKey]);
end;

end.
