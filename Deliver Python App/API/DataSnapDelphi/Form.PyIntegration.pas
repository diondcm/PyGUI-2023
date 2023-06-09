unit Form.PyIntegration;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  VCL.Types, VCL.Controls, VCL.Forms, VCL.Graphics, VCL.Dialogs, PythonEngine, System.SyncObjs,
  VCL.Memo.Types, VCL.Controls.Presentation, VCL.ScrollBox, VCL.Memo,
  VCL.Layouts, VCL.StdCtrls, Constants, FMX.Memo.Types, FMX.ScrollBox, FMX.Memo,
  FMX.Controls, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Types, FMX.Layouts;

type
  TfrmPyIntegration = class(TForm)
    PythonEngine: TPythonEngine;
    PythonInputOutput: TPythonInputOutput;
    LayoutControls: TLayout;
    LayoutOutput: TLayout;
    MemoOut: TMemo;
    MemoIn: TMemo;
    ButtonBack: TButton;
    ButtonRequest: TButton;
    procedure PythonInputOutputSendUniData(Sender: TObject; const Data: string);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ButtonRequestClick(Sender: TObject);
  private
    FOutputStream: TMemoryStream;
    FCriticalSection : TCriticalSection;
   public
    { Public declarations }
  end;

var
  frmPyIntegration: TfrmPyIntegration;

implementation

{$R *.fmx}

procedure TfrmPyIntegration.ButtonRequestClick(Sender: TObject);
begin
  var script: string := MemoIn.Text;
  script := StringReplace(script, API_KEY_CONST, API_SECRET_KEY, [rfIgnoreCase]);
  PythonEngine.ExecString(UTF8Encode(script));
end;

procedure TfrmPyIntegration.FormCreate(Sender: TObject);
begin
  FOutputStream := TMemoryStream.Create;
  FCriticalSection := TCriticalSection.Create;
end;

procedure TfrmPyIntegration.FormDestroy(Sender: TObject);
begin
  FOutputStream.Free;
  FCriticalSection.Free;
end;

procedure TfrmPyIntegration.PythonInputOutputSendUniData(Sender: TObject;
  const Data: string);
{
    FMX TMemo is slow when adding many lines one by one.
    To avoid this we accumulate output and print it in one go.
    The critical section allows for multiple threads to print.
    If you use this code then set PythonInputOuput.RawOutput to True

    A simpler solution would be to set RawOuput to False and then do

    MemoOut.Lines.Add(Data);
    MemoOut.GoToTextEnd;

    This should be good enough if python does not produce a massive
    amount of output.
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
            if (MemoOut.Lines.Count > 0) and (MemoOut.Lines[MemoOut.Lines.Count -1] <> '') then
            MemoOut.BeginUpdate;
            try
              MemoOut.Lines.Add('');
              MemoOut.Text := MemoOut.Text + WS;
              MemoOut.GoToTextEnd;
            finally
              MemoOut.EndUpdate;
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

end.
