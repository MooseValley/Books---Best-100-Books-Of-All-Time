object Form1: TForm1
  Left = 373
  Top = 107
  Width = 973
  Height = 560
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object All_Books_Label: TLabel
    Left = 680
    Top = 8
    Width = 79
    Height = 13
    Caption = 'All_Books_Label'
  end
  object Book_Label: TLabel
    Left = 8
    Top = 8
    Width = 57
    Height = 13
    Caption = 'Book_Label'
  end
  object Progress_Label: TLabel
    Left = 464
    Top = 280
    Width = 73
    Height = 13
    Caption = 'Progress_Label'
  end
  object Resulting_Book_File_Names_Label: TLabel
    Left = 240
    Top = 8
    Width = 168
    Height = 13
    Caption = 'Resulting_Book_File_Names_Label'
  end
  object Missing_Books_Label: TLabel
    Left = 8
    Top = 240
    Width = 103
    Height = 13
    Caption = 'Missing_Books_Label'
  end
  object All_Missing_Books_Label: TLabel
    Left = 232
    Top = 240
    Width = 120
    Height = 13
    Caption = 'All_Missing_Books_Label'
  end
  object All_Found_Books_Label: TLabel
    Left = 456
    Top = 8
    Width = 115
    Height = 13
    Caption = 'All_Found_Books_Label'
  end
  object Books_To_Search_For_ListBox: TListBox
    Left = 8
    Top = 24
    Width = 217
    Height = 177
    ItemHeight = 13
    TabOrder = 0
  end
  object Resulting_Book_File_Names_ListBox: TListBox
    Left = 240
    Top = 24
    Width = 209
    Height = 177
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = Resulting_Book_File_Names_ListBoxDblClick
  end
  object BitBtn1: TBitBtn
    Left = 8
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Paste'
    TabOrder = 2
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 256
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Search'
    TabOrder = 3
    OnClick = BitBtn2Click
  end
  object All_Books_ListBox: TListBox
    Left = 672
    Top = 24
    Width = 281
    Height = 169
    ItemHeight = 13
    TabOrder = 4
    OnDblClick = All_Books_ListBoxDblClick
  end
  object BitBtn3: TBitBtn
    Left = 736
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 5
    OnClick = BitBtn3Click
  end
  object Temp_Memo: TMemo
    Left = 728
    Top = 248
    Width = 169
    Height = 185
    Lines.Strings = (
      'Temp_Memo')
    TabOrder = 6
  end
  object Current_Book_ProgressBar: TProgressBar
    Left = 464
    Top = 296
    Width = 250
    Height = 15
    Min = 0
    Max = 100
    TabOrder = 7
  end
  object Books_ProgressBar: TProgressBar
    Left = 464
    Top = 312
    Width = 250
    Height = 15
    Min = 0
    Max = 100
    TabOrder = 8
  end
  object BitBtn4: TBitBtn
    Left = 376
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Copy'
    TabOrder = 9
    OnClick = BitBtn4Click
  end
  object BitBtn5: TBitBtn
    Left = 880
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 10
    OnClick = BitBtn5Click
  end
  object BitBtn6: TBitBtn
    Left = 816
    Top = 200
    Width = 75
    Height = 25
    Caption = 'Process'
    TabOrder = 11
    OnClick = BitBtn6Click
  end
  object Missing_Books_ListBox: TListBox
    Left = 8
    Top = 256
    Width = 217
    Height = 177
    ItemHeight = 13
    TabOrder = 12
  end
  object BitBtn7: TBitBtn
    Left = 8
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Copy'
    TabOrder = 13
    OnClick = BitBtn7Click
  end
  object All_Missing_Books_ListBox: TListBox
    Left = 232
    Top = 256
    Width = 209
    Height = 177
    ItemHeight = 13
    TabOrder = 14
  end
  object BitBtn8: TBitBtn
    Left = 240
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 15
    OnClick = BitBtn8Click
  end
  object BitBtn9: TBitBtn
    Left = 328
    Top = 440
    Width = 75
    Height = 25
    Caption = 'Copy'
    TabOrder = 16
    OnClick = BitBtn9Click
  end
  object All_Found_Books_ListBox: TListBox
    Left = 456
    Top = 24
    Width = 209
    Height = 177
    ItemHeight = 13
    TabOrder = 17
  end
  object BitBtn10: TBitBtn
    Left = 464
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Reset'
    TabOrder = 18
    OnClick = BitBtn10Click
  end
  object BitBtn11: TBitBtn
    Left = 552
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Copy'
    TabOrder = 19
    OnClick = BitBtn11Click
  end
  object BitBtn12: TBitBtn
    Left = 512
    Top = 376
    Width = 97
    Height = 41
    Caption = 'STOP'
    TabOrder = 20
    OnClick = BitBtn12Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
      33333337777FF377FF3333993370739993333377FF373F377FF3399993000339
      993337777F777F3377F3393999707333993337F77737333337FF993399933333
      399377F3777FF333377F993339903333399377F33737FF33377F993333707333
      399377F333377FF3377F993333101933399377F333777FFF377F993333000993
      399377FF3377737FF7733993330009993933373FF3777377F7F3399933000399
      99333773FF777F777733339993707339933333773FF7FFF77333333999999999
      3333333777333777333333333999993333333333377777333333}
    NumGlyphs = 2
  end
  object Halt_Processing_CheckBox: TCheckBox
    Left = 480
    Top = 344
    Width = 201
    Height = 17
    Caption = 'Halt_Processing_CheckBox'
    TabOrder = 21
    Visible = False
  end
  object BitBtn13: TBitBtn
    Left = 512
    Top = 424
    Width = 97
    Height = 41
    Caption = 'Exit'
    TabOrder = 22
    OnClick = BitBtn13Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
      03333377777777777F333301BBBBBBBB033333773F3333337F3333011BBBBBBB
      0333337F73F333337F33330111BBBBBB0333337F373F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F337F33337F333301110BBBBB0333337F337FF3337F33330111B0BBBB
      0333337F337733337F333301110BBBBB0333337F337F33337F333301110BBBBB
      0333337F3F7F33337F333301E10BBBBB0333337F7F7F33337F333301EE0BBBBB
      0333337F777FFFFF7F3333000000000003333377777777777333}
    NumGlyphs = 2
  end
  object All_Books_Processed_Names_ListBox: TListBox
    Left = 632
    Top = 168
    Width = 121
    Height = 169
    ItemHeight = 13
    TabOrder = 23
    Visible = False
  end
  object BitBtn14: TBitBtn
    Left = 168
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 24
    OnClick = BitBtn14Click
  end
  object BitBtn15: TBitBtn
    Left = 88
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 25
    OnClick = BitBtn15Click
  end
end
