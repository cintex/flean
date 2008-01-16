object frSettings: TfrSettings
  Left = 368
  Top = 188
  Width = 599
  Height = 417
  BorderWidth = 5
  Caption = 'Flean'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 337
    Width = 581
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnClose: TButton
      Left = 478
      Top = 10
      Width = 100
      Height = 25
      Cancel = True
      Caption = '&Close'
      TabOrder = 0
      OnClick = btnCloseClick
    end
  end
  object Tabs: TPageControl
    Left = 0
    Top = 0
    Width = 581
    Height = 337
    ActivePage = tabSettings
    Align = alClient
    Images = frIndicator.imlMain
    TabOrder = 1
    object tabSettings: TTabSheet
      Caption = '&Settings'
      ImageIndex = 2
      object lblLanguage: TLabel
        Left = 16
        Top = 16
        Width = 51
        Height = 13
        Caption = '&Language:'
      end
      object cbLanguage: TComboBox
        Left = 16
        Top = 32
        Width = 145
        Height = 21
        ItemHeight = 13
        TabOrder = 0
        Text = 'cbLanguage'
      end
    end
    object tabAbout: TTabSheet
      Caption = '&About'
      object lblFlean: TLabel
        Left = 32
        Top = 32
        Width = 54
        Height = 24
        Caption = 'Flean'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
end
