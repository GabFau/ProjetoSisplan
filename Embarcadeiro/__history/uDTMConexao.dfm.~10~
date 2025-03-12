object dtmPrincipal: TdtmPrincipal
  OnCreate = DataModuleCreate
  Height = 480
  Width = 640
  object ConexaoDB: TFDConnection
    Params.Strings = (
      'Database=C:\ProjetoSisplan\BASE\BASE.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Server=127.0.0.1'
      'Port=3050'
      'DriverID=FB')
    UpdateOptions.AssignedValues = [uvAutoCommitUpdates]
    UpdateOptions.AutoCommitUpdates = True
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 32
  end
  object dtmFBLink: TFDPhysFBDriverLink
    VendorLib = 'C:\ProjetoSisplan\fbclient32\fbclient.dll'
    Left = 120
    Top = 32
  end
end
