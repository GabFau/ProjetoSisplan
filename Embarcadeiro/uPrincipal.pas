unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, uDTMConexao, Enter;

type
  TFrmPrincipal = class(TForm)
    MainMenu: TMainMenu;
    Cadastro1: TMenuItem;
    N1: TMenuItem;
    mnuFechar: TMenuItem;
    CadastrodoProduto1: TMenuItem;
    N2: TMenuItem;
    CadastrodeCliente1: TMenuItem;
    N3: TMenuItem;
    EditorSQL1: TMenuItem;
    procedure mnuFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CadProdutoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CadastrodoProduto1Click(Sender: TObject);
    procedure CadastrodeCliente1Click(Sender: TObject);
    procedure EditorSQL1Click(Sender: TObject);
  private
    { Private declarations }
    TeclaEnter: TMREnter;
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uCadCategorias, uCadProduto, uCliente, uEditorSQL;

procedure TFrmPrincipal.CadastrodeCliente1Click(Sender: TObject);
begin
frmCadCliente:=TfrmCadCliente.Create(Self);
frmCadCliente.ShowModal;
frmCadCliente.Release;
end;

procedure TFrmPrincipal.CadastrodoProduto1Click(Sender: TObject);
begin
frmCadProduto:=TfrmCadProduto.Create(Self);
frmCadProduto.ShowModal;
frmCadProduto.Release;
end;

procedure TFrmPrincipal.CadProdutoClick(Sender: TObject);
begin
frmCadCategorias:=TfrmCadCategorias.Create(Self);
frmCadCategorias.ShowModal;
frmCadCategorias.Release;
end;

procedure TFrmPrincipal.EditorSQL1Click(Sender: TObject);
begin
frmEditorSQL:=TfrmEditorSQL.Create(Self);
frmEditorSQL.ShowModal;
frmEditorSQL.Release;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
FreeAndNil(TeclaEnter);
FreeAndNil(dtmPrincipal);
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
dtmPrincipal := TdtmPrincipal.Create(Self);
dtmPrincipal.ConexaoDB.Connected:=true;
TeclaEnter:= TMREnter.Create(Self);
TeclaEnter.FocusEnabled:=True;
TeclaEnter.FocusColor:=clInfoBk;
end;

procedure TFrmPrincipal.mnuFecharClick(Sender: TObject);
begin
Close;
end;

end.
