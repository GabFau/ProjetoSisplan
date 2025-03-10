unit uCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uCadCategorias, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.Grids, Vcl.DBGrids,
  Vcl.ComCtrls, uDTMConexao, uEnum, Vcl.Menus, cCliente, MaskUtils;

type
  TEstadoDoCadastro = (ecIncluir, ecAlterar, ecVisualizar);

  TfrmCadCliente = class(TfrmCadCategorias)
    Panel1: TPanel;
    gbEndereco: TGroupBox;
    gbContato: TGroupBox;
    edtCEP: TLabeledEdit;
    edtEstado: TLabeledEdit;
    edtCidade: TLabeledEdit;
    edtRua: TLabeledEdit;
    edtBairro: TLabeledEdit;
    edtComplemento: TLabeledEdit;
    edtNumero: TLabeledEdit;
    edtTelefone: TLabeledEdit;
    edtEmail: TLabeledEdit;
    edtObservacao: TLabeledEdit;
    gbGeral: TGroupBox;
    edtNome: TLabeledEdit;
    edtCodcli: TLabeledEdit;
    edtIE: TLabeledEdit;
    gbCategoria: TGroupBox;
    cbCliente: TCheckBox;
    cbFuncionario: TCheckBox;
    cbRepresentante: TCheckBox;
    cbTerceiro: TCheckBox;
    gbStatus: TGroupBox;
    cbAtivo: TCheckBox;
    cbSuspenso: TCheckBox;
    lblClass: TLabel;
    cbClass: TComboBox;
    edtCPF_CNPJ: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure grdListagemCellClick(Column: TColumn);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    oCadCliente: TCadCliente;
    EstadoDoCadastro: TEstadoDoCadastro;
    procedure ExibirCliente;
    function GravarCliente(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
    procedure BloquearEdicaoCodCli(EstadoDoCadastro: TEstadoDoCadastro);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure LimparCampos;
  public
    { Public declarations }
  end;

var
  frmCadCliente: TfrmCadCliente;

implementation

{$R *.dfm}

{$region 'Utilit�rios'}
procedure SetEditControlsEnabled(frmCadCliente: TfrmCadCliente; Enabled: Boolean);
var
  I: Integer;
begin
  for I := 0 to frmCadCliente.ComponentCount - 1 do
  begin
    if frmCadCliente.Components[I] is TWinControl then
    begin
      if (frmCadCliente.Components[I] as TWinControl).Tag = 5 then
      begin
        (frmCadCliente.Components[I] as TWinControl).Enabled := Enabled;
        if frmCadCliente.Components[I] = frmCadCliente.cbClass then
        begin
          if not Enabled then
            frmCadCliente.lblClass.Font.Color := clGray
          else
            frmCadCliente.lblClass.Font.Color := clBlack;
        end;
      end;
    end;
  end;
end;

procedure TfrmCadCliente.ExibirCliente;
begin
  edtCodCli.Text          := IntToStr(oCadCliente.CodCli);
  edtNome.Text            := oCadCliente.Nome;
  edtCPF_CNPJ.Text        := oCadCliente.CPF_CNPJ;
  edtIE.Text              := oCadCliente.IE;
  cbClass.Text            := oCadCliente.Classificacao;
  edtCEP.Text             := oCadCliente.CEP;
  edtCidade.Text          := oCadCliente.Cidade;
  edtEstado.Text          := oCadCliente.Estado;
  edtRua.Text             := oCadCliente.Rua;
  edtBairro.Text          := oCadCliente.Bairro;
  edtNumero.Text          := oCadCliente.Numero;
  edtComplemento.Text     := oCadCliente.Complemento;
  edtEmail.Text           := oCadCliente.Email;
  edtTelefone.Text        := oCadCliente.Telefone;
  edtObservacao.Text      := oCadCliente.Observacao;
  cbCliente.Checked       := oCadCliente.Cliente = 'S';
  cbFuncionario.Checked   := oCadCliente.Funcionario = 'S';
  cbTerceiro.Checked      := oCadCliente.Terceiro = 'S';
  cbRepresentante.Checked := oCadCliente.Representante = 'S';
  cbAtivo.Checked         := oCadCliente.Ativo = 'S';
  cbSuspenso.Checked      := oCadCliente.Suspenso = 'S';
end;

procedure TfrmCadCliente.BloquearEdicaoCodcli(EstadoDoCadastro: TEstadoDoCadastro);
begin
  if EstadoDoCadastro = ecIncluir then
    edtCodcli.Enabled := True
  else
    edtCodcli.Enabled := False;
end;

procedure TfrmCadCliente.LimparCampos;
begin
  edtCodCli.Text          := '';
  edtNome.Text            := '';
  edtCPF_CNPJ.Text        := '';
  edtIE.Text              := '';
  cbClass.Text            := '';
  edtCEP.Text             := '';
  edtCidade.Text          := '';
  edtEstado.Text          := '';
  edtRua.Text             := '';
  edtBairro.Text          := '';
  edtNumero.Text          := '';
  edtComplemento.Text     := '';
  edtEmail.Text           := '';
  edtTelefone.Text        := '';
  edtObservacao.Text      := '';
  cbCliente.Checked       := False;
  cbFuncionario.Checked   := False;
  cbTerceiro.Checked      := False;
  cbRepresentante.Checked := False;
  cbAtivo.Checked         := False;
  cbSuspenso.Checked      := False;
  btnAlterar.Enabled      := False;
  btnExcluir.Enabled      := False;
end;
{$endregion 'Utilit�rios'}

{$region 'Bot�es'}
procedure TfrmCadCliente.btnIncluirClick(Sender: TObject);
begin
SetEditControlsEnabled(Self, True);
  inherited;

end;

procedure TfrmCadCliente.btnAlterarClick(Sender: TObject);
begin
  if (oCadCliente.Selecionar(QryListagem.FieldByName('CODIGO').AsInteger)) then
  begin
    ExibirCliente;
    BloquearEdicaoCodcli(ecAlterar);
    SetEditControlsEnabled(Self, True);
    EstadoDoCadastro := ecAlterar;
    edtCodcli.Enabled := False;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;

procedure TfrmCadCliente.btnCancelarClick(Sender: TObject);
begin
  SetEditControlsEnabled(Self, False);
  inherited;
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
end;

procedure TfrmCadCliente.btnExcluirClick(Sender: TObject);
var
  ClientCode: Integer;
begin
  if (QryListagem.Active) and (QryListagem.RecNo > 0) then
  begin
    ClientCode := QryListagem.FieldByName('CODIGO').AsInteger;
    oCadCliente.Selecionar(ClientCode);

    if MessageDlg('Tem certeza que deseja excluir este cliente?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try
        if oCadCliente.Excluir then
        begin
          ShowMessage('Cliente exclu�do com sucesso.');
          QryListagem.Refresh;
          LimparCampos;
        end
        else
          ShowMessage('Erro ao excluir o cliente. Tente novamente mais tarde.');
      except
        on E: Exception do
          ShowMessage('Erro ao excluir o cliente: ' + E.Message);
      end;
    end;
  end
  else
    ShowMessage('Selecione um cliente para excluir.');
end;

procedure TfrmCadCliente.btnGravarClick(Sender: TObject);
var
  CampoVazio: Boolean;
begin
  CampoVazio := False;

  if (edtCodcli.Text = '') or (edtNome.Text = '') or (edtCPF_CNPJ.Text = '') or
     (edtIE.Text = '') or (cbClass.Text = '') or (edtCEP.Text = '') or
     (edtEstado.Text = '') or (edtCidade.Text = '') or (edtRua.Text = '') or
     (edtBairro.Text = '') or (edtNumero.Text = '') or (edtEmail.Text = '') or
     (edtTelefone.Text = '') then
  begin
    CampoVazio := True;
  end;

  if CampoVazio then
  begin
    ShowMessage('Todos os campos devem ser preenchidos!');
    Exit;
  end;

  SetEditControlsEnabled(Self, False);

  if EstadoDoCadastro = ecIncluir then
  begin
    if GravarCliente(ecIncluir) then
    begin
      oCadCliente.Selecionar(oCadCliente.Codcli);
      ExibirCliente;
    end;
  end
  else if EstadoDoCadastro = ecAlterar then
  begin
    if GravarCliente(ecAlterar) then
    begin
      oCadCliente.Selecionar(oCadCliente.Codcli);
      ExibirCliente;
    end;
  end;

  inherited;
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
end;
{$endregion 'Bot�es'}

{$region 'Eventos de Formul�rio e Grid'}

procedure TfrmCadCliente.FormCreate(Sender: TObject);
begin
  SetEditControlsEnabled(Self, False);
  oCadCliente := TCadCliente.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'CODIGO';
  BloquearEdicaoCodcli(ecAlterar);
  inherited;
end;

procedure TfrmCadCliente.FormShow(Sender: TObject);
begin
  if edtCodcli.Text = '' then
  begin
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
    btnCancelar.Enabled := False;
    btnGravar.Enabled := False;
    Exit;
  end
  else
  begin
    btnAlterar.Enabled := True;
    btnExcluir.Enabled := True;
  end;
  inherited;
end;

procedure TfrmCadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCadCliente) then
    FreeAndNil(oCadCliente);
end;

{$endregion 'Eventos de Formul�rio e Grid'}

{$region 'Eventos de Edi��o e Controles'}
procedure TfrmCadCliente.grdListagemCellClick(Column: TColumn);
begin
  if (QryListagem.Active) and (QryListagem.RecNo > 0) then
  begin
    oCadCliente.Selecionar(QryListagem.FieldByName('CODIGO').AsInteger);
    ExibirCliente;
    BloquearEdicaoCodCli(ecAlterar);
  end;

  if edtCodcli.Text = '' then
  begin
    btnAlterar.Enabled := False;
    btnExcluir.Enabled := False;
    btnCancelar.Enabled := False;
    btnGravar.Enabled  := False;
    Exit;
  end
  else
  begin
    btnAlterar.Enabled := True;
    btnExcluir.Enabled := True;
  end;
  inherited;
end;

procedure TfrmCadCliente.grdListagemDblClick(Sender: TObject);
begin
  if (oCadCliente.Selecionar(QryListagem.FieldByName('CODIGO').AsInteger)) then
  begin
    ExibirCliente;
    pgcPrincipal.ActivePage := tabManutencao;
    SetEditControlsEnabled(Self, False);
  end;
end;
{$endregion 'Eventos de Edi��o e Controles'}

{$region 'Override'}
function TfrmCadCliente.GravarCliente(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
var
  FS: TFormatSettings;
begin
  FS := TFormatSettings.Create;
  FS.DecimalSeparator := '.';

  if edtCodcli.Text <> '' then
    oCadCliente.Codcli := StrToInt(edtCodcli.Text)
  else
    oCadCliente.Codcli := 0;
    oCadCliente.Nome  := edtNome.Text;
    oCadCliente.CPF_CNPJ  := edtCPF_CNPJ.Text;
    oCadCliente.IE  := edtIE.Text;
    oCadCliente.CLASSIFICACAO  := cbCLASS.Text;
    oCadCliente.CEP  := edtCEP.Text;
    oCadCliente.ESTADO  := edtESTADO.Text;
    oCadCliente.CIDADE  := edtCIDADE.Text;
    oCadCliente.RUA  := edtRUA.Text;
    oCadCliente.BAIRRO  := edtBAIRRO.Text;
    oCadCliente.NUMERO  := edtNUMERO.Text;
    oCadCliente.COMPLEMENTO  := edtCOMPLEMENTO.Text;
    oCadCliente.EMAIL  := edtEMAIL.Text;
    oCadCliente.TELEFONE  := edtTELEFONE.Text;
    oCadCliente.OBSERVACAO  := edtOBSERVACAO.Text;
  if cbCLIENTE.Checked then
    oCadCliente.CLIENTE := 'S'
  else
    oCadCliente.CLIENTE := 'N';

      if cbFUNCIONARIO.Checked then
    oCadCliente.FUNCIONARIO := 'S'
  else
    oCadCliente.FUNCIONARIO := 'N';

      if cbTERCEIRO.Checked then
    oCadCliente.TERCEIRO := 'S'
  else
    oCadCliente.TERCEIRO := 'N';

      if cbREPRESENTANTE.Checked then
    oCadCliente.REPRESENTANTE := 'S'
  else
    oCadCliente.REPRESENTANTE := 'N';

      if cbATIVO.Checked then
    oCadCliente.Ativo := 'S'
  else
    oCadCliente.Ativo := 'N';

      if cbSUSPENSO.Checked then
    oCadCliente.Suspenso := 'S'
  else
    oCadCliente.Suspenso := 'N';

  if EstadoDoCadastro = ecIncluir then
    Result := oCadCliente.Incluir
  else if EstadoDoCadastro = ecAlterar then
    Result := oCadCliente.Alterar
  else
    Result := False;
end;
{$endregion 'Override'}

end.

