inherited frmPesquisa1: TfrmPesquisa1
  Caption = 'frmPesquisa1'
  StyleElements = [seFont, seClient, seBorder]
  TextHeight = 15
  inherited grdPesquisa: TDBGrid
    Columns = <
      item
        Expanded = False
        FieldName = 'TAMANHO'
        Visible = True
      end>
  end
  inherited pnlPesquisa2: TPanel
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited pnlPesquisa1: TPanel
    StyleElements = [seFont, seClient, seBorder]
    inherited lblIndice: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
    inherited Label1: TLabel
      StyleElements = [seFont, seClient, seBorder]
    end
  end
  inherited mskPesquisa: TMaskEdit
    StyleElements = [seFont, seClient, seBorder]
  end
  inherited QryPesquisa: TFDQuery
    SQL.Strings = (
      'SELECT * FROM TAM_001')
  end
end
