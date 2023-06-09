object ServerMethods1: TServerMethods1
  Height = 750
  Width = 1000
  PixelsPerInch = 120
  object PythonInputOutput: TPythonInputOutput
    OnSendUniData = PythonInputOutputSendUniData
    UnicodeIO = True
    RawOutput = True
    Left = 508
    Top = 248
  end
  object PythonEngine: TPythonEngine
    IO = PythonInputOutput
    Left = 652
    Top = 248
  end
end
