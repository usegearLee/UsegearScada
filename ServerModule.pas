unit ServerModule;

interface

uses
  Classes, SysUtils, uniGUIServer, uniGUIMainModule, uniGUIApplication, uIdCustomHTTPServer,
  uniGUITypes,
  Winapi.ShellAPI,
  FMX.Dialogs;

type
  TUniServerModule = class(TUniGUIServerModule)
    procedure UniGUIServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure FirstInit; override;
  public
    { Public declarations }
  end;

function UniServerModule: TUniServerModule;

implementation

{$R *.dfm}

uses
  UniGUIVars;

function UniServerModule: TUniServerModule;
begin
  Result := TUniServerModule(UniGUIServerInstance);
end;

procedure TUniServerModule.UniGUIServerModuleCreate(Sender: TObject);
procedure ExploreWeb(page:PChar);
var Returnvalue: Integer;
begin
  Returnvalue := ShellExecute(0,'open',page, nil, nil, 1);
  if Returnvalue <= 32  then
    begin
      case Returnvalue of
         0 : ShowMessage('错误，内存不足！');
         2 : ShowMessage('错误，文件名错误！');
         3 : ShowMessage('错误，路径名错误！');
         11 : ShowMessage('错误，EXE 文件无效！');
         else
           ShowMessage(PChar('错误代码:'+IntToStr(Returnvalue)+',请检查错误。'));
      end;
   end;
end;
begin
//  uniGUIServerForm.ServerForm.Caption :='应用服务器';
//  ExploreWeb(PWideChar('http://127.0.0.1:'+Self.Port.ToString));
ExploreWeb(PWideChar('http://127.0.0.1:8090'));
end;

procedure TUniServerModule.FirstInit;
begin
  InitServerModule(Self);
end;

initialization
  RegisterServerModuleClass(TUniServerModule);
end.
