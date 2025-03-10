program Sistema;

uses
  Vcl.Forms,
  uPrincipal in 'uPrincipal.pas' {FrmPrincipal},
  uDTMConexao in 'uDTMConexao.pas' {dtmPrincipal: TDataModule},
  uTelaHeranca in 'Heranca\uTelaHeranca.pas' {frmTelaHeranca},
  uCadCategorias in 'Cadastro\uCadCategorias.pas' {frmCadCategorias},
  Enter in 'Enter.pas',
  uEnum in 'Heranca\uEnum.pas',
  cCadCategoria in 'Classes\cCadCategoria.pas',
  uCadProduto in 'CadProduto\uCadProduto.pas' {frmCadProduto},
  uPesquisa in 'Pesquisa\uPesquisa.pas' {frmPesquisa},
  cCadProduto in 'CadProduto\cCadProduto.pas',
  uPesquisa2 in 'Pesquisa\uPesquisa2.pas' {frmPesquisa2},
  uCliente in 'Cliente\uCliente.pas' {frmCadCliente},
  cCliente in 'Cliente\cCliente.pas',
  uEditorSQL in 'EditorSQL\uEditorSQL.pas' {frmEditorSQL};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TfrmCadProduto, frmCadProduto);
  Application.CreateForm(TfrmPesquisa, frmPesquisa);
  Application.CreateForm(TfrmPesquisa2, frmPesquisa2);
  Application.CreateForm(TfrmCadCliente, frmCadCliente);
  Application.CreateForm(TfrmEditorSQL, frmEditorSQL);
  Application.Run;
end.
