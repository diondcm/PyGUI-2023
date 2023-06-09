unit Data.Connection;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  TdmdConnection = class(TDataModule)
    MainConnection: TFDConnection;
    FDQuery1: TFDQuery;
    FDMemTable1: TFDMemTable;
    FDMemTable1ID: TIntegerField;
    FDMemTable1NAME: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmdConnection: TdmdConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
