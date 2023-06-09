object dmdConnection: TdmdConnection
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object MainConnection: TFDConnection
    Left = 416
    Top = 224
  end
  object FDQuery1: TFDQuery
    Connection = MainConnection
    SQL.Strings = (
      'SELECT ID, NAME'
      'FROM CURTOMER')
    Left = 304
    Top = 392
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 592
    Top = 336
    object FDMemTable1ID: TIntegerField
      FieldName = 'ID'
    end
    object FDMemTable1NAME: TStringField
      FieldName = 'NAME'
      Size = 300
    end
  end
end
