object f_unlock_type: Tf_unlock_type
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Unlock type'
  ClientHeight = 166
  ClientWidth = 379
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
  object Button1: TButton
    Left = 8
    Top = 135
    Width = 169
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 0
  end
  object Button2: TButton
    Left = 202
    Top = 135
    Width = 169
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 1
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 363
    Height = 121
    Caption = 'Please select unlock type'
    TabOrder = 2
    object RadioButton1: TRadioButton
      Left = 10
      Top = 22
      Width = 334
      Height = 17
      Caption = 'Old algoritm'
      TabOrder = 0
    end
    object RadioButton2: TRadioButton
      Left = 10
      Top = 45
      Width = 334
      Height = 17
      Caption = 'New algoritm'
      Checked = True
      TabOrder = 1
      TabStop = True
    end
    object RadioButton3: TRadioButton
      Left = 10
      Top = 68
      Width = 334
      Height = 17
      Caption = 'New algoritm - restore from backup'
      TabOrder = 2
    end
    object RadioButton4: TRadioButton
      Left = 10
      Top = 91
      Width = 334
      Height = 17
      Caption = 'New algoritm - show supported version list'
      TabOrder = 3
    end
  end
end
