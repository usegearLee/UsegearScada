# uniGUI 主框架实施结果

日期：2026-09-30。

最新修订：模块页面已移除 HTML/CSS 拼接，改为设计期 TUniPanel/TUniLabel 组件。通过 Daofy `manage_component` 添加组件并设置属性；`LoadModule` 只更新 Caption。此次修订尚未编译或运行验收，由用户在 Delphi 中检查；下文的成功编译记录对应此前版本。

## 已实现

- `Main.pas / Main.dfm`：产品标题、当前工程位置、左侧导航树、可调整导航宽度的分隔条、中部页签和底部状态区。
- 六个模块：工程概览、工程配置、设备与 Tag、Node-RED 配置与运行、FUXA 组态与运行、系统设置。
- `ScadaWorkspace.pas / ScadaWorkspace.dfm`：模块目录及 Frame 承载；首次访问创建页签，再次访问复用；页签切换同步导航和当前位置。
- 工程概览呈现 SQLite、Node-RED、FUXA 的职责及未接入状态。FUXA 页面说明再次同步差异和人工画面保护；Node-RED 页面说明受管部署范围。
- `ServerModule.dfm` 更新产品标题，沿用开发端口 8090。业务数据库和外部服务尚未连接。
- 参考 uniGUI AllFeaturesDemo 的导航树、页签和 Frame 组织方式。

## 验证证据

通过 Daofy `check_environment` 检测环境，`delphi_file` 读取和修改 Delphi 文件，`delphi_project` 编译主工程。

- 工程：`UsegearScadaServer.dproj`。
- 编译器：Delphi 12 Athens（23.0），Win32 Debug。
- 最后编译结果：`success`；日志为 `265 lines, 1.94 seconds`，无错误、无警告。
- 产物：`Win32/Debug/UsegearScadaServer.exe`、同目录 `.map`。
- 已启动本轮编译产物供本地检查。启动动作成功不等于浏览器界面验收通过。
- 浏览器导航被客户端权限校验阻止，尚未取得页面截图，也未验证六个导航的实际运行效果。

## 工具环境及处理

- 当前项目已配置 Daofy MCP。本轮通过临时 MCP 客户端调用 Daofy 工具；临时请求、脚本和日志已清理，没有用普通文件工具修改主工程源码。
- 已安装的 Daofy 2026.8.20 仅在 Visual Studio 安装位置查找 MSBuild。本轮临时启动适配器补充本机 .NET Framework MSBuild 路径，未修改 Daofy 安装文件；适配器已清理，用户接下来通过 Delphi IDE 自行编译检查。
- Daofy 的编码规则资源缺失，后台知识库索引构建报错；文件操作及最终编译实际成功。未升级 Daofy。
- UTF-8 无 BOM 源码导致字符串转换警告；最终使用 Daofy `encode` 转为 UTF-8 BOM，重新编译无警告。
- 早期独立验证入口未通过直接 DCC 编译（缺少 `RTTI.inc`），已删除；正式验证使用主 `.dproj`。
- 已停止本轮启动的开发服务器，释放可执行文件，由用户自行编译运行检查。

## 待验收与启动

在 Delphi 中打开 `UsegearScadaServer.dproj`，编译并运行；也可运行 `Win32/Debug/UsegearScadaServer.exe`，访问 `http://localhost:8090/`。

检查中文显示、六个模块导航、相同模块不重复创建页签、页签切换后当前位置正确、导航分隔条及内容区布局。实际界面验收完成前，本阶段状态为“源码及编译完成，界面待验证”。

后续业务模块可按 `TScadaModule` 目录扩展，在模块 Frame 内增加工程树、配置表格或 Web 容器；需要独立业务 Frame 时在 `OpenModule` 的创建位置接入，不重建主窗体布局。
