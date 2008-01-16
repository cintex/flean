object frSettings: TfrSettings
  Left = 278
  Top = 144
  Width = 467
  Height = 294
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
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBottom: TPanel
    Left = 0
    Top = 214
    Width = 449
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnClose: TBitBtn
      Left = 344
      Top = 8
      Width = 100
      Height = 25
      Caption = '&Close'
      TabOrder = 0
      OnClick = btnCloseClick
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        080000000000000100000000000000000000000100000000000000000000FFFF
        FF005C5AF7007976FF007875FE006360F8006967F9005350F300807DFF00807D
        FE007370FD00615EF8006E6CFB007D7BFF004946F0007370FE007C79FE008986
        FF007B78FD006B68FB00605DF8006D6BFA007C79FF00605EF7004845F0006D6A
        FC007673FD008581FF007572FC006361F8005F5CF7006C69FA007A78FF004744
        EF006562F9006F6CFB007F7DFF007D7AFF007B78FF007876FF005D5BF7004643
        EF005C59F6007C78FF005D5AFF005A57FF007573FF004542EF007875FF005855
        FF005653FF00716FFF004745F0005B59F6006663FA007371FF00726FFF006F6D
        FF006D6BFF005654F7003E3CEE005A58F6006562FA007370FF005957F6004240
        EE003D3BEC004F4CF4006766FF004F4DF5003533EB005A57F6006461FA00706F
        FF005855F600413FEE003431E9004644F2006261FF004947F4002E2CE9005755
        F5006260FA005754F600403EED002B29E600403EF1004B49F600302EEA004E4B
        F2003F3DED002321E4000000000000000000000000000000000000000000E0BF
        4400000000000000000000000000000000001C24510054B00300000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000B824510054B00300000000000000000000000000000000001CB903000000
        000000000000ECB70300000000000400000001000000FFFFFF00000000000000
        00000000000002000000E8B70300E8B70300FC01000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00808000000100000000000000C891470098B603001CB8
        03001CB80300C8010000D87F4700ECB703000000000000000000010000000000
        0000B8B403002CBB030000000000000000000000000054B8030054B803009001
        0000D87F47002C9E0300000000000000000001000000000000005C8F02000C95
        03000000000000000000000000008CB803008CB8030040000000000000000000
        00000000000000000000CC724300708B0200B0B80300B0B803001C000000B0CE
        410064900300F414FF00780000002B00000098A04100000000008065430098B6
        0300980FFF0000000000080000006000000000000000F4B80300F4B80300F000
        000000000000000000000000000000000000CC72430098B6030018B9030018B9
        0300CC0000000000000084B90300ACB90300CCB9030000000000000000002000
        CC00000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000098B60300000000000000
        0000409B03000C9E03006400000070CE41001CB90300980FFF0054B903000800
        000060000000280000002300000014A241000000000090CE4100C3C3C3C3C3C3
        C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3595AC3
        C3C3C3C3C35B58C3C3C3C3C351525354C3C3C3C355565758C3C3C3C34748494A
        4BC3C34C4D4E4F50C3C3C3C3C33D3E3F40414243444546C3C3C3C3C3C3C33536
        3738393A3B3CC3C3C3C3C3C3C3C3C3023031323334C3C3C3C3C3C3C3C3C3C32A
        2B2C2D2E2FC3C3C3C3C3C3C3C3C32223242526272829C3C3C3C3C3C3C3191A1B
        1C1D1E1F201E21C3C3C3C3C30F10111213C3C31415161718C3C3C3C30308090A
        C3C3C3C30B0C0D0B0EC3C3C3C30304C3C3C3C3C3C3050607C3C3C3C3C3C3C3C3
        C3C3C3C3C3C302C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3C3}
    end
  end
  object Tabs: TPageControl
    Left = 0
    Top = 0
    Width = 449
    Height = 214
    ActivePage = tabSettings
    Align = alClient
    Images = frIndicator.imlMain
    TabOrder = 1
    object tabSettings: TTabSheet
      Caption = '&Settings'
      ImageIndex = 2
      object lblLanguage: TLabel
        Left = 16
        Top = 8
        Width = 51
        Height = 13
        Caption = 'Lan&guage:'
        Enabled = False
        FocusControl = cmbLanguage
      end
      object lblInterval: TLabel
        Left = 248
        Top = 64
        Width = 97
        Height = 13
        Caption = 'Update &interval (ms):'
        FocusControl = edInterval
      end
      object lnlAlignment: TLabel
        Left = 16
        Top = 128
        Width = 92
        Height = 13
        Caption = 'Indicator &alignment:'
        FocusControl = cmbAlignment
      end
      object lblType: TLabel
        Left = 248
        Top = 8
        Width = 27
        Height = 13
        Caption = 'T&ype:'
        Enabled = False
        FocusControl = cmbType
      end
      object cmbLanguage: TComboBox
        Left = 16
        Top = 24
        Width = 170
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        TabOrder = 0
      end
      object cbTransparency: TCheckBox
        Left = 16
        Top = 64
        Width = 97
        Height = 17
        Caption = '&Transparency:'
        TabOrder = 1
        OnClick = cbTransparencyClick
      end
      object tbTransparency: TTrackBar
        Left = 16
        Top = 80
        Width = 170
        Height = 45
        Max = 255
        Frequency = 15
        TabOrder = 2
        OnChange = tbTransparencyChange
      end
      object udInterval: TUpDown
        Left = 401
        Top = 80
        Width = 21
        Height = 21
        Associate = edInterval
        Min = 50
        Max = 5000
        Increment = 50
        Position = 50
        TabOrder = 3
        OnChanging = udIntervalChanging
      end
      object edInterval: TEdit
        Left = 248
        Top = 80
        Width = 153
        Height = 21
        ReadOnly = True
        TabOrder = 4
        Text = '50'
      end
      object cmbAlignment: TComboBox
        Left = 16
        Top = 144
        Width = 170
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 5
        OnChange = cmbAlignmentChange
        Items.Strings = (
          'Top-Left'
          'Middle-Left'
          'Bottom-Left'
          'Top-Right'
          'Middle-Right'
          'Bottom-Right')
      end
      object cmbType: TComboBox
        Left = 248
        Top = 24
        Width = 169
        Height = 21
        Style = csDropDownList
        Enabled = False
        ItemHeight = 13
        TabOrder = 6
      end
    end
    object tabLayouts: TTabSheet
      Caption = '&Layouts'
    end
    object tabAbout: TTabSheet
      Caption = '&About'
      ImageIndex = 3
      object lblAppName: TLabel
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
      object lblAppVersion: TLabel
        Left = 32
        Top = 56
        Width = 34
        Height = 13
        Caption = 'version'
      end
    end
  end
end
