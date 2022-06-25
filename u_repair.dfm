object f_repair: Tf_repair
  Left = 398
  Top = 318
  BorderStyle = bsToolWindow
  Caption = 'Repair'
  ClientHeight = 77
  ClientWidth = 256
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
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 152
    Height = 13
    Caption = 'Country(Unavailable Media File):'
  end
  object bRepair: TJvTransparentButton
    Left = 7
    Top = 48
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
    Left = 131
    Top = 48
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
  object ComboBox1: TComboBox
    Left = 4
    Top = 20
    Width = 245
    Height = 21
    Style = csDropDownList
    DropDownCount = 20
    ItemHeight = 13
    TabOrder = 0
    Items.Strings = (
      '0:UK(United Kindom)'
      '1:IT(Italy)'
      '2:HK(Hong-Kong)'
      '3:SW(Sweden)'
      '4:DU(Australia)'
      '5:AU(Austria)'
      '6:DE(Denmark)'
      '7:IR(Ireland)'
      '8:ID(Indonesia)')
  end
end
