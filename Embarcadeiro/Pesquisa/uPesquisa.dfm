object frmPesquisa: TfrmPesquisa
  Left = 0
  Top = 0
  Caption = 'Pesquisa'
  ClientHeight = 391
  ClientWidth = 611
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object grdPesquisa: TDBGrid
    Left = 0
    Top = 57
    Width = 611
    Height = 280
    Align = alClient
    DataSource = dtPesquisa
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = grdPesquisaDblClick
    OnTitleClick = grdPesquisaTitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'COR'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DESCRICAO'
        Width = 292
        Visible = True
      end>
  end
  object pnlPesquisa2: TPanel
    Left = 0
    Top = 337
    Width = 611
    Height = 54
    Align = alBottom
    TabOrder = 1
    object btnConfirmar: TBitBtn
      Left = 14
      Top = 14
      Width = 80
      Height = 30
      Caption = 'Confirmar'
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TBitBtn
      Left = 110
      Top = 14
      Width = 80
      Height = 30
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object pnlPesquisa1: TPanel
    Left = 0
    Top = 0
    Width = 611
    Height = 57
    Align = alTop
    TabOrder = 2
    object lblIndice: TLabel
      Left = 90
      Top = 21
      Width = 64
      Height = 15
      Caption = #39'Ordena'#231#227'o'#39
    end
    object Label1: TLabel
      Left = 10
      Top = 21
      Width = 74
      Height = 15
      Caption = 'Pesquisar por:'
    end
  end
  object mskPesquisa: TMaskEdit
    Left = 168
    Top = 18
    Width = 297
    Height = 23
    ParentShowHint = False
    ShowHint = False
    TabOrder = 3
    Text = ''
    TextHint = 'Digite sua Pesquisa'
    OnChange = mskPesquisaChange
  end
  object dtPesquisa: TDataSource
    DataSet = QryPesquisa
    Left = 560
    Top = 8
  end
  object QryPesquisa: TFDQuery
    Active = True
    Connection = dtmPrincipal.ConexaoDB
    SQL.Strings = (
      'SELECT * FROM COR_001')
    Left = 512
    Top = 8
  end
end
