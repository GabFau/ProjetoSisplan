unit uEditorSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids,
  FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Stan.Param, FireDAC.Comp.DataSet, uDTMConexao,
  Vcl.Buttons, FireDAC.Phys.Intf, FireDAC.Stan.Async, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TfrmEditorSQL = class(TForm)
    mmSQL: TMemo;
    dtSQL: TDataSource;
    QrySQL: TFDQuery;
    Panel1: TPanel;
    btnF9: TBitBtn;
    btnExecutar: TBitBtn;
    dbGridSQL: TDBGrid;
    StatusBar: TStatusBar;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    procedure StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
    procedure btnF9Click(Sender: TObject);
    procedure btnExecutarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    procedure ExecuteSQL(const SQLText: string);
    procedure UpdateStatus(const Msg: string; const IsSuccess: Boolean);
    function IsSelectSQL(const SQLText: string): Boolean;
  public
  end;

var
  frmEditorSQL: TfrmEditorSQL;

implementation

{$R *.dfm}

procedure TfrmEditorSQL.btnF9Click(Sender: TObject);
begin
  if IsSelectSQL(mmSQL.Lines.Text) then
  begin
    ExecuteSQL(mmSQL.Lines.Text);
  end
  else
  begin
    ShowMessage('Clique F6 para executar o comando.');
  end;
end;

procedure TfrmEditorSQL.btnExecutarClick(Sender: TObject);
begin
  if not IsSelectSQL(mmSQL.Lines.Text) then
  begin
    ExecuteSQL(mmSQL.Lines.Text);
  end
  else
  begin
    ShowMessage('Clique F9 para consultar a base de dados.');
  end;
end;

procedure TfrmEditorSQL.ExecuteSQL(const SQLText: string);
begin
  try
    dbGridSQL.DataSource := nil;
    QrySQL.SQL.Text := SQLText;

    if IsSelectSQL(SQLText) then
    begin
      QrySQL.Open;

      if QrySQL.IsEmpty then
      begin
        UpdateStatus('Consulta executada, mas sem resultados.', False);
        dbGridSQL.DataSource := nil;
      end
      else
      begin
        dbGridSQL.DataSource := dtSQL;
        UpdateStatus('Consulta executada com sucesso.', True);
      end;
    end
    else
    begin
      QrySQL.ExecSQL;
      UpdateStatus('Comando executado com sucesso.', True);
      dbGridSQL.DataSource := nil;
    end;

  except
    on E: Exception do
    begin
      ShowMessage('Erro ao executar SQL: ' + E.Message);
      UpdateStatus('Erro na execução do SQL: ' + E.Message, False);
    end;
  end;
end;

procedure TfrmEditorSQL.FormCreate(Sender: TObject);
begin
  Caption := 'Editor SQL';
  mmSQL.Lines.Clear;
  dtSQL.DataSet := QrySQL;
  QrySQL.Connection := dtmPrincipal.ConexaoDB;

  if StatusBar.Panels.Count = 0 then
    StatusBar.Panels.Add;

  KeyPreview := True;
end;

procedure TfrmEditorSQL.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F9 then
  begin
    btnF9.Click;
    Key := 0;
  end;

  if Key = VK_F6 then
  begin
    btnExecutar.Click;
    Key := 0;
  end;
end;

procedure TfrmEditorSQL.StatusBarDrawPanel(StatusBar: TStatusBar; Panel: TStatusPanel; const Rect: TRect);
begin
  if Panel.Text = 'Erro' then
    StatusBar.Canvas.Brush.Color := clRed
  else
    StatusBar.Canvas.Brush.Color := clGreen;

  StatusBar.Canvas.FillRect(Rect);
  StatusBar.Canvas.TextOut(Rect.Left + 2, Rect.Top + 2, Panel.Text);
end;

procedure TfrmEditorSQL.UpdateStatus(const Msg: string; const IsSuccess: Boolean);
begin
  StatusBar.Panels[0].Text := Msg;

  if IsSuccess then
    StatusBar.Panels[0].Text := 'Sucesso'
  else
    StatusBar.Panels[0].Text := 'Erro';

  StatusBar.Repaint;
end;

function TfrmEditorSQL.IsSelectSQL(const SQLText: string): Boolean;
begin
  Result := SQLText.Trim.StartsWith('SELECT', True);
end;

end.

