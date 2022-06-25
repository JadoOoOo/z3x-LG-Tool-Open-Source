object f_repair_imei: Tf_repair_imei
  Left = 417
  Top = 263
  BorderStyle = bsToolWindow
  Caption = 'Repair IMEI'
  ClientHeight = 82
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
  object bCancel: TJvTransparentButton
    Left = 131
    Top = 55
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
  object bRepair: TJvTransparentButton
    Left = 7
    Top = 55
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
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 25
    Height = 13
    Caption = 'IMEI:'
  end
  object MaskEdit1: TMaskEdit
    Left = 4
    Top = 20
    Width = 244
    Height = 21
    AutoSize = False
    EditMask = '000000\-00\-000000;1;_'
    MaxLength = 16
    TabOrder = 0
    Text = '      -  -      '
  end
end
