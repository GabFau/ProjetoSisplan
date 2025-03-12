unit uDTMConexao;

interface

uses
  System.SysUtils, System.IOUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase,
  Data.DB, FireDAC.Comp.Client;

type
  TdtmPrincipal = class(TDataModule)
    ConexaoDB: TFDConnection;
    dtmFBLink: TFDPhysFBDriverLink;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmPrincipal: TdtmPrincipal;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdtmPrincipal.DataModuleCreate(Sender: TObject);
var
  AppPath: string;
begin
  {$IFDEF WIN64}
    dtmFBLink.VendorLib := TPath.Combine(ExtractFilePath(ParamStr(0)), 'fbclient64\fbclient.dll');
  {$ELSE}
    dtmFBLink.VendorLib := TPath.Combine(ExtractFilePath(ParamStr(0)), 'fbclient32\fbclient.dll');
  {$ENDIF}
end;








end.
