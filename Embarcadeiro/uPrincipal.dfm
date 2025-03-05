object FrmPrincipal: TFrmPrincipal
  Left = 0
  Top = 0
  Caption = 'Menu Principal'
  ClientHeight = 680
  ClientWidth = 1191
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  TextHeight = 15
  object MainMenu: TMainMenu
    Left = 1144
    object Cadastro1: TMenuItem
      Caption = 'Cadastros'
      object CadastrodoProduto1: TMenuItem
        Caption = 'Cadastro de Produto'
        OnClick = CadastrodoProduto1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object CadastrodeCliente1: TMenuItem
        Caption = 'Cadastro de Cliente'
        OnClick = CadastrodeCliente1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object EditorSQL1: TMenuItem
        Caption = 'Editor SQL'
        OnClick = EditorSQL1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object mnuFechar: TMenuItem
        Caption = 'Fechar'
        Default = True
        OnClick = mnuFecharClick
      end
    end
  end
end
