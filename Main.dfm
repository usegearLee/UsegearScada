object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 760
  ClientWidth = 1280
  Caption = 'Usegear '#32452#24577#24037#31243#24037#20316#21488
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Font.Name = 'Microsoft YaHei UI'
  OnCreate = UniFormCreate
  TextHeight = 17
  object HeaderPanel: TUniPanel
    Left = 0
    Top = 0
    Width = 1280
    Height = 72
    Hint = ''
    Align = alTop
    TabOrder = 0
    Caption = ''
    Color = 3153938
    DesignSize = (
      1280
      72)
    object ProductLabel: TUniLabel
      Left = 24
      Top = 13
      Width = 256
      Height = 27
      Hint = ''
      Caption = 'Usegear  /  '#32452#24577#24037#31243#24037#20316#21488
      ParentFont = False
      Font.Color = clWhite
      Font.Height = -20
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = [fsBold]
      TabOrder = 1
    end
    object ProjectLabel: TUniLabel
      Left = 24
      Top = 44
      Width = 88
      Height = 16
      Hint = ''
      Caption = #24403#21069#24037#31243#65306#26410#25171#24320
      ParentFont = False
      Font.Color = 15132390
      Font.Name = 'Microsoft YaHei UI'
      TabOrder = 2
    end
    object ThemeLabel: TUniLabel
      Left = 965
      Top = 29
      Width = 26
      Height = 13
      Hint = ''
      Caption = #20027#39064
      Anchors = [akTop, akRight]
      ParentFont = False
      Font.Color = clWhite
      TabOrder = 4
    end
    object ThemeComboBox: TUniComboBox
      Left = 1024
      Top = 24
      Width = 232
      Height = 28
      Hint = ''
      Style = csDropDownList
      Text = ''
      Anchors = [akTop, akRight]
      TabOrder = 3
      IconItems = <>
      OnChange = ThemeComboBoxChange
    end
  end
  object StatusPanel: TUniPanel
    Left = 0
    Top = 724
    Width = 1280
    Height = 36
    Hint = ''
    Align = alBottom
    TabOrder = 1
    Caption = ''
    Color = 16185078
    object StatusLabel: TUniLabel
      Left = 18
      Top = 10
      Width = 44
      Height = 16
      Hint = ''
      Caption = #26694#26550#21407#22411
      TabOrder = 1
    end
  end
  object NavigationPanel: TUniPanel
    Left = 0
    Top = 72
    Width = 220
    Height = 652
    Hint = ''
    Align = alLeft
    TabOrder = 2
    Caption = ''
    Collapsible = True
    CollapseDirection = cdLeft
    object NavigationTitle: TUniLabel
      Left = 1
      Top = 1
      Width = 218
      Height = 48
      Hint = ''
      AutoSize = False
      Caption = '   '#24037#20316#31354#38388
      Align = alTop
      ParentFont = False
      Font.Color = 7432033
      Font.Height = -14
      Font.Name = 'Microsoft YaHei UI'
      Font.Style = [fsBold]
      TabOrder = 1
    end
    object NavigationTree: TUniTreeView
      Left = 1
      Top = 49
      Width = 218
      Height = 602
      Hint = ''
      Items.FontData = {0100000000}
      Align = alClient
      TabOrder = 2
      Color = clWindow
      OnClick = NavigationTreeClick
    end
  end
  object NavigationSplitter: TUniSplitter
    Left = 220
    Top = 72
    Width = 6
    Height = 652
    Hint = ''
    Align = alLeft
    ParentColor = False
    Color = clBtnFace
  end
  object WorkspacePages: TUniPageControl
    Left = 226
    Top = 72
    Width = 1054
    Height = 652
    Hint = ''
    Align = alClient
    TabOrder = 4
    OnChange = WorkspacePagesChange
  end
end
