object dtmPrincipal: TdtmPrincipal
  Height = 480
  Width = 640
  object ConexaoDB: TFDConnection
    Params.Strings = (
      'Database=C:\ProjetoSisplan-main\BASE\BASE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Port=3050'
      'DriverID=FB')
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object dtmFBLink: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files\Firebird\Firebird_3_0\fbclient.dll'
    Left = 120
    Top = 32
  end
end
