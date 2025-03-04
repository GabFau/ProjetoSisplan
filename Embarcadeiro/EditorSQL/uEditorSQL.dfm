object frmEditorSQL: TfrmEditorSQL
  Left = 0
  Top = 0
  Caption = 'frmEditorSQL'
  ClientHeight = 656
  ClientWidth = 1186
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object mmSQL: TMemo
    Left = 0
    Top = 81
    Width = 1186
    Height = 103
    Align = alClient
    Lines.Strings = (
      'mmSQL')
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1186
    Height = 81
    Align = alTop
    TabOrder = 1
    object btnF9: TBitBtn
      Left = 424
      Top = 24
      Width = 89
      Height = 35
      Caption = 'Consultar (F9)'
      TabOrder = 0
      OnClick = btnF9Click
    end
    object btnExecutar: TBitBtn
      Left = 296
      Top = 24
      Width = 89
      Height = 35
      Caption = 'Executar (F6)'
      TabOrder = 1
      OnClick = btnExecutarClick
    end
    object GroupBox1: TGroupBox
      Left = 7
      Top = 8
      Width = 258
      Height = 67
      TabOrder = 2
      object Label1: TLabel
        Left = 2
        Top = 11
        Width = 250
        Height = 49
        Align = alCustom
        Caption = 'Editor SQL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -40
        Font.Name = 'Fira Code'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object dbGridSQL: TDBGrid
    Left = 0
    Top = 184
    Width = 1186
    Height = 432
    Align = alBottom
    DataSource = dtSQL
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object StatusBar: TStatusBar
    Left = 0
    Top = 616
    Width = 1186
    Height = 40
    Panels = <>
    OnDrawPanel = StatusBarDrawPanel
  end
  object dtSQL: TDataSource
    DataSet = QrySQL
    Left = 1136
    Top = 72
  end
  object QrySQL: TFDQuery
    Connection = dtmPrincipal.ConexaoDB
    Left = 1136
    Top = 128
  end
end
