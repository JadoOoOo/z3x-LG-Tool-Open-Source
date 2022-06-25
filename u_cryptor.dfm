object fConverter: TfConverter
  Left = 143
  Top = 174
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Converter LGQ v1.0'
  ClientHeight = 627
  ClientWidth = 547
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
  object Label3: TLabel
    Left = 8
    Top = 7
    Width = 32
    Height = 13
    Caption = 'Model:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 7
    Top = 45
    Width = 38
    Height = 13
    Caption = 'Modem:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 7
    Top = 82
    Width = 32
    Height = 13
    Caption = 'Media:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 6
    Top = 118
    Width = 38
    Height = 13
    Caption = 'Module:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 6
    Top = 154
    Width = 51
    Height = 13
    Caption = 'Mod.head:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 6
    Top = 191
    Width = 41
    Height = 13
    Caption = 'Partition:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label8: TLabel
    Left = 7
    Top = 465
    Width = 21
    Height = 13
    Caption = 'Info:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label1: TLabel
    Left = 7
    Top = 228
    Width = 45
    Height = 13
    Caption = 'Bootlogo:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label9: TLabel
    Left = 8
    Top = 308
    Width = 38
    Height = 13
    Caption = 'Oemsbl:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label10: TLabel
    Left = 8
    Top = 346
    Width = 50
    Height = 13
    Caption = 'Oemsblhd:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label11: TLabel
    Left = 8
    Top = 268
    Width = 18
    Height = 13
    Caption = 'Pbl:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel
    Left = 8
    Top = 386
    Width = 30
    Height = 13
    Caption = 'Qcsbl:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object Label13: TLabel
    Left = 8
    Top = 425
    Width = 42
    Height = 13
    Caption = 'Qcsblhd:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object cbModel: TComboBox
    Left = 7
    Top = 22
    Width = 534
    Height = 21
    Style = csDropDownList
    DropDownCount = 30
    ItemHeight = 13
    Sorted = True
    TabOrder = 0
    OnChange = cbModelChange
  end
  object b1create: TButton
    Left = 7
    Top = 579
    Width = 534
    Height = 25
    Caption = 'Go'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = b1createClick
  end
  object i1info: TMemo
    Left = 6
    Top = 478
    Width = 535
    Height = 98
    Color = clBtnFace
    ScrollBars = ssVertical
    TabOrder = 2
    WordWrap = False
  end
  object ProgressBar1: TProgressBar
    Left = 23
    Top = 529
    Width = 345
    Height = 21
    TabOrder = 3
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 608
    Width = 547
    Height = 19
    Panels = <>
  end
  object f1modem: TJvFilenameEdit
    Left = 7
    Top = 59
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 5
  end
  object f1media: TJvFilenameEdit
    Left = 7
    Top = 95
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 6
  end
  object f1module: TJvFilenameEdit
    Left = 7
    Top = 131
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 7
  end
  object f1modhead: TJvFilenameEdit
    Left = 7
    Top = 166
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 8
  end
  object f1part: TJvFilenameEdit
    Left = 7
    Top = 203
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 9
  end
  object f1bootlogo: TJvFilenameEdit
    Left = 7
    Top = 242
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 10
  end
  object f1pbl: TJvFilenameEdit
    Left = 7
    Top = 281
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 11
  end
  object f1oemsbl: TJvFilenameEdit
    Left = 7
    Top = 321
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 12
  end
  object f1oemsblhd: TJvFilenameEdit
    Left = 7
    Top = 359
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 13
  end
  object f1qcsbl: TJvFilenameEdit
    Left = 8
    Top = 398
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 14
  end
  object f1qcsblhd: TJvFilenameEdit
    Left = 7
    Top = 440
    Width = 534
    Height = 21
    AddQuotes = False
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    ButtonFlat = True
    DirectInput = False
    TabOrder = 15
  end
  object OpenDialog1: TOpenDialog
    Left = 425
    Top = 539
  end
  object CipherManager2: TCipherManager
    Mode = cmCTS
    Left = 393
    Top = 539
    Cipher = 'TCipher_Blowfish'
  end
  object ZipForge1: TZipForge
    ExtractCorruptedFiles = False
    CompressionLevel = clMax
    CompressionMode = 9
    CurrentVersion = '2.74 '
    Password = '(Its bug, redownload file or f*ck support)'
    SpanningMode = smNone
    SpanningOptions.AdvancedNaming = True
    SpanningOptions.VolumeSize = vsAutoDetect
    Options.Recurse = False
    Options.FlushBuffers = True
    Options.OEMFileNames = True
    InMemory = False
    Zip64Mode = zmDisabled
    Left = 393
    Top = 571
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 425
    Top = 571
  end
end
