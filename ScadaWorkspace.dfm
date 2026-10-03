object ScadaWorkspaceFrame: TScadaWorkspaceFrame
  Left = 0
  Top = 0
  Width = 1000
  Height = 600
  Align = alClient
  TabOrder = 0
  object TitlePanel: TUniPanel
    Left = 0
    Top = 0
    Width = 1000
    Height = 130
    Align = alTop
    Caption = ''
    object ModuleTitle: TUniLabel
      Left = 24
      Top = 22
      Width = 920
      Height = 32
      AutoSize = False
      Caption = #24037#31243#27010#35272
      Anchors = [akLeft, akTop, akRight]
      Font.Height = -24
      Font.Style = [fsBold]
    end
    object ModuleDescription: TUniLabel
      Left = 24
      Top = 65
      Width = 920
      Height = 48
      AutoSize = False
      Caption = #24037#31243#37197#32622#12289#37319#38598#36816#34892#19982#30011#38754#21576#29616
      Anchors = [akLeft, akTop, akRight]
    end
  end
  object ScopePanel: TUniPanel
    Left = 0
    Top = 130
    Width = 1000
    Height = 170
    Align = alTop
    Caption = ''
    object ScopeTitle: TUniLabel
      Left = 24
      Top = 16
      Caption = #27169#22359#32844#36131
      Font.Style = [fsBold]
    end
    object ScopeText: TUniLabel
      Left = 24
      Top = 48
      Width = 920
      Height = 104
      AutoSize = False
      Caption = #24037#31243#23545#35937#30001#26412#20135#21697#31649#29702#12290
      Anchors = [akLeft, akTop, akRight]
    end
  end
  object StatePanel: TUniPanel
    Left = 0
    Top = 300
    Width = 1000
    Height = 110
    Align = alTop
    Caption = ''
    object StateTitle: TUniLabel
      Left = 24
      Top = 16
      Caption = #24403#21069#29366#24577
      Font.Style = [fsBold]
    end
    object StateText: TUniLabel
      Left = 24
      Top = 48
      Width = 920
      Height = 48
      AutoSize = False
      Caption = #24453#25509#20837
      Anchors = [akLeft, akTop, akRight]
    end
  end
  object NextPanel: TUniPanel
    Left = 0
    Top = 410
    Width = 1000
    Height = 140
    Align = alTop
    Caption = ''
    object NextTitle: TUniLabel
      Left = 24
      Top = 16
      Caption = #19979#19968#27493
      Font.Style = [fsBold]
    end
    object NextText: TUniLabel
      Left = 24
      Top = 48
      Width = 920
      Height = 76
      AutoSize = False
      Caption = #26680#23454#25509#21475#32422#26463#21518#24314#31435#24037#31243#27169#22411#12290
      Anchors = [akLeft, akTop, akRight]
    end
  end
end