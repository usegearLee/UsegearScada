unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses,
  uniPanel, uniLabel, uniTreeView, uniSplitter, uniPageControl,
  ScadaWorkspace, uniMultiItem, uniComboBox,
  uniStrUtils;

type
  TMainForm = class(TUniForm)
    HeaderPanel: TUniPanel;
    ProductLabel: TUniLabel;
    ProjectLabel: TUniLabel;
    NavigationPanel: TUniPanel;
    NavigationTitle: TUniLabel;
    NavigationTree: TUniTreeView;
    NavigationSplitter: TUniSplitter;
    WorkspacePages: TUniPageControl;
    StatusPanel: TUniPanel;
    StatusLabel: TUniLabel;
    ThemeLabel: TUniLabel;
    ThemeComboBox: TUniComboBox;
    procedure UniFormCreate(Sender: TObject);
    procedure NavigationTreeClick(Sender: TObject);
    procedure WorkspacePagesChange(Sender: TObject);
    procedure ThemeComboBoxChange(Sender: TObject);
  private
    FLoadingThemes: Boolean;
    FPages: array[TScadaModule] of TUniTabSheet;
    procedure LoadThemes;
    procedure OpenModule(AModule: TScadaModule);
    procedure UpdateLocation;
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, ServerModule, uniGUITheme;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.UniFormCreate(Sender: TObject);
var
  Module: TScadaModule;
  Node: TUniTreeNode;
begin
  for Module := Low(TScadaModule) to High(TScadaModule) do
  begin
    FPages[Module] := nil;
    Node := NavigationTree.Items.Add(nil, ScadaModuleTitle(Module));
    Node.Data := Pointer(NativeInt(Ord(Module) + 1));
  end;
  LoadThemes;
  OpenModule(smOverview);
  NavigationTree.Selected := NavigationTree.Items[0];
end;

procedure TMainForm.OpenModule(AModule: TScadaModule);
var
  Page: TUniTabSheet;
  Frame: TScadaWorkspaceFrame;
begin
  Page := FPages[AModule];
  if not Assigned(Page) then
  begin
    Page := TUniTabSheet.Create(Self);
    try
      Page.Caption := ScadaModuleTitle(AModule);
      Page.Tag := Ord(AModule);
      Page.PageControl := WorkspacePages;
      Frame := TScadaWorkspaceFrame.Create(Page);
      Frame.Parent := Page;
      Frame.Align := alClient;
      Frame.LoadModule(AModule);
      FPages[AModule] := Page;
    except
      Page.Free;
      raise;
    end;
  end;
  WorkspacePages.ActivePage := Page;
  UpdateLocation;
end;

procedure TMainForm.NavigationTreeClick(Sender: TObject);
var
  ModuleIndex: NativeInt;
begin
  if not Assigned(NavigationTree.Selected) then
    Exit;
  ModuleIndex := NativeInt(NavigationTree.Selected.Data) - 1;
  if (ModuleIndex < Ord(Low(TScadaModule))) or
     (ModuleIndex > Ord(High(TScadaModule))) then
    Exit;
  try
    OpenModule(TScadaModule(ModuleIndex));
  except
    on E: Exception do
    begin
      StatusLabel.Caption := '页面加载失败：' + E.Message;
      ShowMessage('页面加载失败，请重试。' + #13#10 + E.Message);
    end;
  end;
end;

procedure TMainForm.UpdateLocation;
var
  Module: TScadaModule;
begin
  if not Assigned(WorkspacePages.ActivePage) then
    Exit;
  Module := TScadaModule(WorkspacePages.ActivePage.Tag);
  ProjectLabel.Caption := '当前工程：未打开  /  ' + ScadaModuleTitle(Module);
  StatusLabel.Caption := '框架原型  |  当前模块：' +
    ScadaModuleTitle(Module) + '  |  数据库、Node-RED、FUXA：未接入 ';
  NavigationTree.Selected := NavigationTree.Items[Ord(Module)];
end;

procedure TMainForm.WorkspacePagesChange(Sender: TObject);
begin
  UpdateLocation;
end;

procedure TMainForm.LoadThemes;
var
  Themes: TUniStringArray;
  I: Integer;
begin
  FLoadingThemes := True;
  try
    Themes := UniServerModule.ThemeManager.AllThemes;
    ThemeComboBox.Items.Clear;
    for I := Low(Themes) to High(Themes) do
      ThemeComboBox.Items.Add(Themes[I]);
    ThemeComboBox.Text := UniMainModule.Theme;
    ThemeComboBox.Enabled := ThemeComboBox.Items.Count > 0;
  finally
    FLoadingThemes := False;
  end;
end;

procedure TMainForm.ThemeComboBoxChange(Sender: TObject);
begin
  if FLoadingThemes or (ThemeComboBox.Text = '') then
    Exit;
  try
    UniMainModule.Theme := ThemeComboBox.Text;
  except
    on E: Exception do
    begin
      LoadThemes;
      ShowMessage('主题切换失败：' + E.Message);
    end;
  end;
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
