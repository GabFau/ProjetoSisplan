unit uCadProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics,Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uTelaHeranca, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, Vcl.ExtCtrls,
  Vcl.ComCtrls, cCadProduto, uDTMConexao, uEnum, uPesquisa, uPesquisa2, Vcl.ExtDlgs,
  Vcl.Imaging.Jpeg, System.IOUtils;

type
  TfrmCadProduto = class(TfrmTelaHeranca)
    GroupBox1: TGroupBox;
    edtCor: TLabeledEdit;
    edtCodigo: TLabeledEdit;
    edtDescricao: TLabeledEdit;
    edtTam: TLabeledEdit;
    btnCor: TBitBtn;
    btnTam: TBitBtn;
    edtCusto: TLabeledEdit;
    opdImagem: TOpenPictureDialog;
    Image1: TImage;
    cbUN: TComboBox;
    GroupBox3: TGroupBox;
    edtObs: TLabeledEdit;
    Image2: TImage;
    gbImagem: TGroupBox;
    btnAnexar: TBitBtn;
    btnExpandir: TBitBtn;
    btnExcImg: TBitBtn;
    gbStatus: TGroupBox;
    cbAtivo: TCheckBox;
    cbSuspenso: TCheckBox;
    edtPreco: TLabeledEdit;
    lblUN: TLabel;
    pnlImagem: TPanel;
    Img: TImage;
    procedure btnCorClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure grdListagemDblClick(Sender: TObject);
    procedure grdListagemCellClick(Column: TColumn);
    procedure btnTamClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtCustoExit(Sender: TObject);
    procedure btnAnexarClick(Sender: TObject);
    procedure btnExcImgClick(Sender: TObject);
    procedure btnExpandirClick(Sender: TObject);
    procedure edtCustoKeyPress(Sender: TObject; var Key: Char);
    procedure edtPrecoExit(Sender: TObject);
    procedure edtPrecoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    oCadProduto: TCadProduto;
    frmImagemExpandida: TForm;
    function GravarProduto(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BloquearEdicaoCodigo(EstadoDoCadastro: TEstadoDoCadastro);
    procedure ExibirProduto;
    procedure ImgExpandidaDblClick(Sender: TObject);
    procedure LimparCampos;
  public
    { Public declarations }
  end;

var
  frmCadProduto: TfrmCadProduto;

implementation

{$R *.dfm}

{$region 'Utilitários'}
procedure SetEditControlsEnabled(frmCadProduto: TfrmCadProduto; Enabled: Boolean);
var
  I: Integer;
begin
  for I := 0 to frmCadProduto.ComponentCount - 1 do
  begin
    if frmCadProduto.Components[I] is TWinControl then
    begin
      if (frmCadProduto.Components[I] as TWinControl).Tag = 5 then
      begin
        (frmCadProduto.Components[I] as TWinControl).Enabled := Enabled;
        if frmCadProduto.Components[I] = frmCadProduto.cbUN then
        begin
          if not Enabled then
            frmCadProduto.lblUN.Font.Color := clGray
          else
            frmCadProduto.lblUN.Font.Color := clBlack;
        end;
      end;
    end;
  end;
end;

procedure TfrmCadProduto.ExibirProduto;
var
  imgClone: TGraphic;
begin
  edtCodigo.Text    := IntToStr(oCadProduto.Codigo);
  edtDescricao.Text := oCadProduto.Descricao;
  edtCor.Text       := oCadProduto.Cor;
  edtTam.Text       := oCadProduto.Tam;
  edtCusto.Text     := FloatToStr(oCadProduto.Custo);
  edtPreco.Text     := FloatToStr(oCadProduto.Preco);
  cbAtivo.Checked   := oCadProduto.Ativo = 'S';
  cbSuspenso.Checked:= oCadProduto.Suspenso = 'S';
  edtObs.Text       := oCadProduto.Observacao;
  cbUN.Text         := oCadProduto.Unidade;

  if Assigned(oCadProduto.Imagem) then
  begin
    imgClone := TGraphic(oCadProduto.Imagem.ClassType.Create);
    try
      imgClone.Assign(oCadProduto.Imagem);
      Img.Picture.Graphic := imgClone;
    except
      imgClone.Free;
      raise;
    end;
  end
  else
    Img.Picture := nil;
end;

procedure TfrmCadProduto.LimparCampos;
begin
  edtCodigo.Text    := '';
  edtDescricao.Text := '';
  edtCor.Text       := '';
  edtTam.Text       := '';
  edtCusto.Text     := '';
  edtPreco.Text     := '';
  edtObs.Text       := '';
  cbAtivo.Checked   := False;
  cbSuspenso.Checked:= False;
  btnAlterar.Enabled:= False;
  btnExcluir.Enabled:= False;
  Img.Picture := nil;
end;

procedure TfrmCadProduto.BloquearEdicaoCodigo(EstadoDoCadastro: TEstadoDoCadastro);
begin
  if EstadoDoCadastro = ecIncluir then
    edtCodigo.Enabled := True
  else
    edtCodigo.Enabled := False;
end;
{$endregion 'Utilitários'}

{$region 'Botões'}
procedure TfrmCadProduto.btnCorClick(Sender: TObject);
var
  frmPesquisa2: TfrmPesquisa;
begin
  frmPesquisa := TfrmPesquisa.Create(Self);
  try
    if frmPesquisa.ShowModal = mrOk then
      edtCor.Text := frmPesquisa.ValorSelecionado;
  finally
    frmPesquisa.Free;
  end;
  inherited;
end;




procedure TfrmCadProduto.btnAlterarClick(Sender: TObject);
begin
  if (oCadProduto.Selecionar(QryListagem.FieldByName('CODIGO').AsInteger)) then
  begin
    ExibirProduto;
    BloquearEdicaoCodigo(ecAlterar);
    SetEditControlsEnabled(Self, True);
    EstadoDoCadastro := ecAlterar;
    edtCodigo.Enabled := False;
  end
  else
  begin
    btnCancelar.Click;
    Abort;
  end;
  inherited;
end;




procedure TfrmCadProduto.btnAnexarClick(Sender: TObject);
var
  JpegImage: TJpegImage;
begin
  opdImagem.Filter := 'Imagens JPG (*.jpg;*.jpeg)|*.jpg;*.jpeg';
  if opdImagem.Execute then
  begin
    try
      JpegImage := TJpegImage.Create;
      try
        JpegImage.LoadFromFile(opdImagem.FileName);
        Img.Picture.Assign(JpegImage);
      finally
        JpegImage.Free;
      end;
    except
      on E: Exception do
        ShowMessage('Erro ao carregar a imagem: ' + E.Message);
    end;
  end;
end;

procedure TfrmCadProduto.btnCancelarClick(Sender: TObject);
begin
  SetEditControlsEnabled(Self, False);
  inherited;
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
end;

procedure TfrmCadProduto.btnGravarClick(Sender: TObject);
begin
  SetEditControlsEnabled(Self, False);

  if EstadoDoCadastro = ecIncluir then
  begin
    if GravarProduto(ecIncluir) then
    begin
      oCadProduto.Selecionar(oCadProduto.Codigo);
      ExibirProduto;
    end;
  end
  else if EstadoDoCadastro = ecAlterar then
  begin
    if GravarProduto(ecAlterar) then
    begin
      oCadProduto.Selecionar(oCadProduto.Codigo);
      ExibirProduto;
      Img.Picture := nil;
    end;
  end;

  inherited;
  btnAlterar.Enabled := False;
  btnExcluir.Enabled := False;
end;

procedure TfrmCadProduto.btnIncluirClick(Sender: TObject);
begin
  SetEditControlsEnabled(Self, True);
  BloquearEdicaoCodigo(ecIncluir);
  EstadoDoCadastro := ecIncluir;
  Img.Picture := nil;
  cbAtivo.Checked := False;
  cbSuspenso.Checked := False;
  inherited;
end;

procedure TfrmCadProduto.btnTamClick(Sender: TObject);
var
  frmPesquisa2: TfrmPesquisa2;
begin
  frmPesquisa2 := TfrmPesquisa2.Create(Self);
  try
    if frmPesquisa2.ShowModal = mrOk then
      edtTam.Text := frmPesquisa2.ValorSelecionado;
  finally
    frmPesquisa2.Free;
  end;
  inherited;
end;

procedure TfrmCadProduto.btnExcImgClick(Sender: TObject);
begin
  if Img.Picture.Graphic = nil then
  begin
    ShowMessage('Nenhuma imagem anexada para exclusão.');
  end
  else
  begin
    if MessageDlg('Tem certeza que deseja excluir esta imagem?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      Img.Picture := nil;
  end;
end;

procedure TfrmCadProduto.btnExcluirClick(Sender: TObject);
begin
  if (QryListagem.Active) and (QryListagem.RecNo > 0) then
  begin
    oCadProduto.Selecionar(QryListagem.FieldByName('CODIGO').AsInteger);
    if MessageDlg('Tem certeza que deseja excluir este produto?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try
        if oCadProduto.Excluir then
        begin
          ShowMessage('Produto excluído com sucesso.');
          QryListagem.Refresh;
          LimparCampos;
        end
        else
          ShowMessage('Erro ao excluir o produto. Tente novamente mais tarde.');
      except
        on E: Exception do
          ShowMessage('Erro ao excluir o produto: ' + E.Message);
      end;
    end;
  end
  else
    ShowMessage('Selecione um produto para excluir.');
end;

procedure TfrmCadProduto.btnExpandirClick(Sender: TObject);
var
  imgExpandida: TImage;
begin
  if frmImagemExpandida <> nil then
  begin
    frmImagemExpandida.Close;
    FreeAndNil(frmImagemExpandida);
    Exit;
  end;

  if Img.Picture.Graphic <> nil then
  begin
    frmImagemExpandida := TForm.Create(Self);
    try
      frmImagemExpandida.BorderStyle := bsSizeable;
      frmImagemExpandida.Position := poScreenCenter;
      frmImagemExpandida.Width := 800;
      frmImagemExpandida.Height := 600;
      frmImagemExpandida.Caption := 'Imagem Expandida';

      imgExpandida := TImage.Create(frmImagemExpandida);
      imgExpandida.Parent := frmImagemExpandida;
      imgExpandida.Align := alClient;
      imgExpandida.Stretch := True;
      imgExpandida.Picture.Assign(Img.Picture);

      frmImagemExpandida.ShowModal;
    finally
      FreeAndNil(frmImagemExpandida);
    end;
  end
  else
    ShowMessage('Nenhuma imagem anexada.');
end;
{$endregion 'Botões'}

{$region 'Eventos de Formulário e Grid'}
procedure TfrmCadProduto.FormCreate(Sender: TObject);
begin
  SetEditControlsEnabled(Self, False);
  oCadProduto := TCadProduto.Create(dtmPrincipal.ConexaoDB);
  IndiceAtual := 'CODIGO';
  BloquearEdicaoCodigo(ecAlterar);
  Img := TImage.Create(Self);
  Img.Parent := pnlImagem;
  Img.Align := alClient;
  Img.Stretch := True;
  inherited;
end;

procedure TfrmCadProduto.FormShow(Sender: TObject);
begin
  if edtCodigo.Text = '' then
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

procedure TfrmCadProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  if Assigned(oCadProduto) then
    FreeAndNil(oCadProduto);
end;

procedure TfrmCadProduto.grdListagemCellClick(Column: TColumn);
begin
  if (QryListagem.Active) and (QryListagem.RecNo > 0) then
  begin
    oCadProduto.Selecionar(QryListagem.FieldByName('CODIGO').AsInteger);
    ExibirProduto;
    BloquearEdicaoCodigo(ecAlterar);
    if oCadProduto.Imagem <> nil then
      Img.Picture.Assign(oCadProduto.Imagem);
  end;

  if edtCodigo.Text = '' then
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

procedure TfrmCadProduto.grdListagemDblClick(Sender: TObject);
begin
  if (oCadProduto.Selecionar(QryListagem.FieldByName('CODIGO').AsInteger)) then
  begin
    ExibirProduto;
    BloquearEdicaoCodigo(ecAlterar);
    EstadoDoCadastro := ecAlterar;
    pgcPrincipal.ActivePage := tabManutencao;
  end;
end;

{$endregion 'Eventos de Formulário e Grid'}

{$region 'Eventos de Edição e Controles'}
procedure TfrmCadProduto.edtCustoExit(Sender: TObject);
var
  Value: Double;
  Edit: TLabeledEdit;
  FS: TFormatSettings;
begin
  Edit := Sender as TLabeledEdit;
  FS := TFormatSettings.Create;
  FS.DecimalSeparator := '.';
  if TryStrToFloat(StringReplace(Edit.Text, ',', '.', [rfReplaceAll]), Value, FS) then
    Edit.Text := FormatFloat('0.00', Value)
  else
  begin
    ShowMessage('Valor inválido! Digite um número correto.');
    Edit.SetFocus;
  end;
end;

procedure TfrmCadProduto.edtCustoKeyPress(Sender: TObject; var Key: Char);
var
  Edit: TLabeledEdit;
begin
  Edit := Sender as TLabeledEdit;
  if not CharInSet(Key, ['0'..'9', #8, ',', '.']) then
    Key := #0;
  if Key in [',', '.'] then
    if (Pos(',', Edit.Text) > 0) or (Pos('.', Edit.Text) > 0) then
      Key := #0;
end;

procedure TfrmCadProduto.edtPrecoExit(Sender: TObject);
var
  Value: Double;
  Edit: TLabeledEdit;
  FS: TFormatSettings;
begin
  Edit := Sender as TLabeledEdit;
  FS := TFormatSettings.Create;
  FS.DecimalSeparator := '.';
  if TryStrToFloat(StringReplace(Edit.Text, ',', '.', [rfReplaceAll]), Value, FS) then
    Edit.Text := FormatFloat('0.00', Value)
  else
  begin
    ShowMessage('Valor inválido! Digite um número correto.');
    Edit.SetFocus;
  end;
end;

procedure TfrmCadProduto.edtPrecoKeyPress(Sender: TObject; var Key: Char);
var
  Edit: TLabeledEdit;
begin
  Edit := Sender as TLabeledEdit;
  if not CharInSet(Key, ['0'..'9', #8, ',', '.']) then
    Key := #0;
  if Key in [',', '.'] then
    if (Pos(',', Edit.Text) > 0) or (Pos('.', Edit.Text) > 0) then
      Key := #0;
end;

procedure TfrmCadProduto.ImgExpandidaDblClick(Sender: TObject);
begin
  if frmImagemExpandida <> nil then
  begin
    frmImagemExpandida.Close;
    FreeAndNil(frmImagemExpandida);
  end;
end;
{$endregion 'Eventos de Edição e Controles'}

{$region 'Override'}
function TfrmCadProduto.GravarProduto(EstadoDoCadastro: TEstadoDoCadastro): Boolean;
var
  FS: TFormatSettings;
begin
  FS := TFormatSettings.Create;
  FS.DecimalSeparator := '.';

  if edtCodigo.Text <> '' then
    oCadProduto.Codigo := StrToInt(edtCodigo.Text)
  else
    oCadProduto.Codigo := 0;

  oCadProduto.Descricao  := edtDescricao.Text;
  oCadProduto.Cor        := edtCor.Text;
  oCadProduto.Tam        := edtTam.Text;
  oCadProduto.Custo      := StrToFloatDef(StringReplace(edtCusto.Text, ',', '.', [rfReplaceAll]), 0, FS);
  oCadProduto.Preco      := StrToFloatDef(StringReplace(edtPreco.Text, ',', '.', [rfReplaceAll]), 0, FS);
  oCadProduto.Observacao := edtObs.Text;
  oCadProduto.Unidade    := cbUN.Text;

  if cbAtivo.Checked then
    oCadProduto.Ativo := 'S'
  else
    oCadProduto.Ativo := 'N';

  if cbSuspenso.Checked then
    oCadProduto.Suspenso := 'S'
  else
    oCadProduto.Suspenso := 'N';

  if Img.Picture.Graphic <> nil then
  begin
    if Assigned(oCadProduto.Imagem) then
      oCadProduto.Imagem.Free;
    if Img.Picture.Graphic is TJPEGImage then
      oCadProduto.Imagem := TJPEGImage.Create
    else if Img.Picture.Graphic is TBitmap then
      oCadProduto.Imagem := TBitmap.Create
    else
      oCadProduto.Imagem := TGraphic(Img.Picture.Graphic.ClassType.Create);
    oCadProduto.Imagem.Assign(Img.Picture.Graphic);
  end
  else
    oCadProduto.Imagem := nil;

  if EstadoDoCadastro = ecIncluir then
    Result := oCadProduto.Incluir
  else if EstadoDoCadastro = ecAlterar then
    Result := oCadProduto.Alterar
  else
    Result := False;
end;
{$endregion 'Override'}

end.

