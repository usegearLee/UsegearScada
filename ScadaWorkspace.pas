unit ScadaWorkspace;

interface

uses
  Classes, Controls, uniGUIBaseClasses, uniGUIClasses, uniGUIFrame,
  uniPanel, uniLabel;

type
  TScadaModule = (smOverview, smEngineering, smDevices, smNodeRed,
    smFuxa, smSettings);

  TScadaWorkspaceFrame = class(TUniFrame)
    TitlePanel: TUniPanel;
    ModuleTitle: TUniLabel;
    ModuleDescription: TUniLabel;
    ScopePanel: TUniPanel;
    ScopeTitle: TUniLabel;
    ScopeText: TUniLabel;
    StatePanel: TUniPanel;
    StateTitle: TUniLabel;
    StateText: TUniLabel;
    NextPanel: TUniPanel;
    NextTitle: TUniLabel;
    NextText: TUniLabel;
  public
    procedure LoadModule(AModule: TScadaModule);
  end;

function ScadaModuleTitle(AModule: TScadaModule): string;

implementation

{$R *.dfm}

const
  ModuleTitles: array[TScadaModule] of string = (
    '工程概览', '工程配置', '设备与 Tag', 'Node-RED 配置与运行',
    'FUXA 组态与运行', '系统设置');
  ModuleDescriptions: array[TScadaModule] of string = (
    '从工程配置到采集运行，再到画面呈现，在一个工作台中组织工程。',
    '管理工程、配置单元和配置版本，形成部署前可核对的工程配置。',
    '管理设备、协议和 Tag，作为自动生成配置的统一数据来源。',
    '将工程配置生成并部署为受管 Flow，核对采集、缓存与转存状态。',
    '同步设备和 Tag，并由 FUXA Editor 维护人工画面布局与交互。',
    '管理开发环境、连接参数及后续权限设置。');
  ModuleTasks: array[TScadaModule] of string = (
    '先完成可运行的工作台，再核实接口约束并建立 SQLite 工程模型。',
    '下一步：确定配置单元及版本规则，再实现新建、打开和保存工程。',
    '下一步：结合 Node-RED P0 和 FUXA ID 约束建立设备及 Tag 模型。',
    '下一步：核实当前运行实例，打通校验、生成、部署、核对和回滚。',
    '下一步：核实项目读写接口，验证同步差异及画面引用保护。',
    '下一步：明确本地开发和运行部署的环境配置。');

function ScadaModuleTitle(AModule: TScadaModule): string;
begin
  Result := ModuleTitles[AModule];
end;

procedure TScadaWorkspaceFrame.LoadModule(AModule: TScadaModule);
begin
  ModuleTitle.Caption := ScadaModuleTitle(AModule);
  ModuleDescription.Caption := ModuleDescriptions[AModule];
  ScopeText.Caption := ModuleDescriptions[AModule];
  StateText.Caption := '待实现；当前工程未打开，业务数据库和外部服务未接入。';
  NextText.Caption := ModuleTasks[AModule];

  case AModule of
    smOverview:
      begin
        ScopeText.Caption :=
          'SQLite：管理工程对象和可生成配置。' + #13#10 +
          'Node-RED：承载采集运行、缓存及可选转存。' + #13#10 +
          'FUXA：维护人工画面并呈现运行数据。';
        StateText.Caption := '主框架已建立；SQLite、Node-RED、FUXA 尚未接入。';
      end;
    smNodeRed:
      ScopeText.Caption := ModuleDescriptions[AModule] + #13#10 +
        '仅部署平台受管 Flow，部署前校验和备份，部署后核对运行。' + #13#10 +
        'PLC 保留最终控制及安全联锁职责。';
    smFuxa:
      ScopeText.Caption := ModuleDescriptions[AModule] + #13#10 +
        '再次同步时比较上次快照、当前 FUXA 数据和新配置，提示人工修改及冲突。' + #13#10 +
        '删除或重命名 Tag 时检查画面引用，保护人工布局及样式。';
  end;
end;

end.
