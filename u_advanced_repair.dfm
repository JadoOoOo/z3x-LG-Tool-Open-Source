object f_advanced_repair: Tf_advanced_repair
  Left = 552
  Top = 191
  BorderStyle = bsToolWindow
  Caption = 'Repair'
  ClientHeight = 175
  ClientWidth = 253
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object bRepair: TJvTransparentButton
    Left = 7
    Top = 146
    Width = 117
    Height = 25
    AllowAllUp = True
    AutoGray = False
    Caption = 'Repair'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'MS Sans Serif'
    HotTrackFont.Style = []
    FrameStyle = fsIndent
    ParentFont = False
    Spacing = 5
    Transparent = False
    OnClick = bRepairClick
  end
  object bCancel: TJvTransparentButton
    Left = 132
    Top = 146
    Width = 117
    Height = 25
    AllowAllUp = True
    AutoGray = False
    Caption = 'Cancel'
    HotTrackFont.Charset = DEFAULT_CHARSET
    HotTrackFont.Color = clWindowText
    HotTrackFont.Height = -11
    HotTrackFont.Name = 'Tahoma'
    HotTrackFont.Style = []
    FrameStyle = fsIndent
    Spacing = 5
    Transparent = False
    OnClick = bCancelClick
  end
  object lComPort: TLabel
    Left = 8
    Top = 8
    Width = 22
    Height = 13
    Caption = 'Port:'
  end
  object lbKS20repairmanual: TLabel
    Left = 8
    Top = 112
    Width = 92
    Height = 13
    Cursor = crHandPoint
    Caption = 'KS20 repair manual'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = lbKS20repairmanualClick
  end
  object lbKS20repairphoto: TLabel
    Left = 8
    Top = 128
    Width = 85
    Height = 13
    Cursor = crHandPoint
    Caption = 'KS20 repair photo'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlue
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = lbKS20repairphotoClick
  end
  object cbWriteNVM: TCheckBox
    Left = 8
    Top = 39
    Width = 153
    Height = 17
    Caption = 'Write NVM'
    TabOrder = 0
    OnClick = cbWriteNVMClick
  end
  object cbRepairIMEI: TCheckBox
    Left = 8
    Top = 63
    Width = 129
    Height = 17
    Caption = 'Repair IMEI'
    TabOrder = 1
    OnClick = cbRepairIMEIClick
  end
  object MaskEdit1: TMaskEdit
    Left = 143
    Top = 59
    Width = 98
    Height = 21
    AutoSize = False
    Enabled = False
    EditMask = '000000\-00\-000000;1;_'
    MaxLength = 16
    TabOrder = 2
    Text = '      -  -      '
  end
  object cbRepairBT: TCheckBox
    Left = 8
    Top = 87
    Width = 209
    Height = 17
    Caption = 'Repair BT address'
    TabOrder = 3
  end
  object cbPortList: TComboBox
    Left = 46
    Top = 5
    Width = 195
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 4
  end
end
