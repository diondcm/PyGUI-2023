unit ServerMethodsUnit1;

interface

uses System.SysUtils, System.Classes, System.Json,
    DataSnap.DSProviderDataModuleAdapter, System.SyncObjs,
    Datasnap.DSServer, Datasnap.DSAuth, PythonEngine, PythonSource;

type
  TServerMethods1 = class(TDSServerModule)
    PythonInputOutput: TPythonInputOutput;
    PythonEngine: TPythonEngine;
    procedure PythonInputOutputSendUniData(Sender: TObject; const Data: string);
  private
    FOutputStream: TMemoryStream;
    FCriticalSection : TCriticalSection;
    FResult: TStringList;
  public
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    function AskChatGPTFromPython(text: string): string;
  end;

implementation


{$R *.dfm}


uses System.StrUtils;

function TServerMethods1.AskChatGPTFromPython(text: string): string;
begin
  FOutputStream := TMemoryStream.Create;
  FCriticalSection := TCriticalSection.Create;
  FResult := TStringList.Create;
  try
    var script: string := MY_SIMPLE_PY_APP;
    script := StringReplace(script, API_KEY_CONST, API_SECRET_KEY, [rfIgnoreCase]);
    PythonEngine.ExecString(UTF8Encode(script));

    Result := FResult.Text;

  finally
    FResult.Free;
    FOutputStream.Free;
    FCriticalSection.Free;
  end;
end;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

procedure TServerMethods1.PythonInputOutputSendUniData(Sender: TObject;
  const Data: string);
{
  This is not the Idial use for a productions enviroment
  consider this source as just an sample

  For production, we suggest you to request by one method and
  run this python in back-gound async from the original request
}
var
  ScheduleWrite: Boolean;
begin
  if Data = '' then Exit;

  fCriticalSection.Enter;
  try
    ScheduleWrite := FOutputStream.Size = 0;
    FOutputStream.Write(Data[1], Length (Data) * 2);

    if ScheduleWrite then

    TThread.ForceQueue(nil, procedure
      var
        WS: string;
      begin
        fCriticalSection.Enter;
        try
          if fOutputStream.Size > 0 then begin
            SetLength(WS, fOutputStream.Size div 2);
            fOutputStream.Position := 0;
            fOutputStream.Read(WS[1], Length(WS) * 2);
            fOutputStream.Size := 0;
            if (FResult.Count > 0) and (FResult[FResult.Count -1] <> '') then
            FResult.BeginUpdate;
            try
              FResult.Add('');
              FResult.Text := FResult.Text + WS;
            finally
              FResult.EndUpdate;
            end;
          end;
        finally
          fCriticalSection.Leave;
        end;
      end);
  finally
    fCriticalSection.Leave;
  end;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.

