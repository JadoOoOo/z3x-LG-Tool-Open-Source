object f_select_modem_port: Tf_select_modem_port
  Left = 388
  Top = 283
  BorderStyle = bsToolWindow
  Caption = 'Port Select'
  ClientHeight = 82
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object bRepair: TJvTransparentButton
    Left = 4
    Top = 53
    Width = 117
    Height = 25
    AllowAllUp = True
    AutoGray = False
    Caption = 'Ok'
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
    Left = 128
    Top = 53
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
  object Label1: TLabel
    Left = 4
    Top = 4
    Width = 22
    Height = 13
    Caption = 'Port:'
  end
  object cbPortList: TComboBox
    Left = 4
    Top = 20
    Width = 241
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 0
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 10
    OnTimer = Timer1Timer
    Left = 48
    Top = 8
  end
end
