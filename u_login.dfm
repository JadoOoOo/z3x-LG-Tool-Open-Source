object f_login: Tf_login
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Warning!'
  ClientHeight = 159
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object bCancel: TJvTransparentButton
    Left = 158
    Top = 130
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
    Left = 34
    Top = 130
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
  object Label1: TLabel
    Left = 8
    Top = 69
    Width = 29
    Height = 13
    Caption = 'Login:'
  end
  object Label2: TLabel
    Left = 162
    Top = 69
    Width = 50
    Height = 13
    Caption = 'Password:'
  end
  object Label3: TLabel
    Left = 80
    Top = 52
    Width = 152
    Height = 13
    Cursor = crHandPoint
    Caption = '>>> http://easy-rpl.com/ <<<'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clHotLight
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsUnderline]
    ParentFont = False
    OnClick = Label3Click
  end
  object Label4: TLabel
    Left = 8
    Top = 8
    Width = 302
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Caption = 'For buy credits:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -27
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 8
    Top = 84
    Width = 148
    Height = 21
    TabOrder = 0
  end
  object MaskEdit1: TMaskEdit
    Left = 162
    Top = 84
    Width = 149
    Height = 21
    PasswordChar = '*'
    TabOrder = 1
  end
  object CheckBox1: TCheckBox
    Left = 8
    Top = 106
    Width = 198
    Height = 17
    Caption = 'Save login && password'
    TabOrder = 2
  end
end
