object frSettings: TfrSettings
  Left = 243
  Top = 261
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  BorderWidth = 5
  Caption = 'Flean'
  ClientHeight = 327
  ClientWidth = 416
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
    Top = 291
    Width = 416
    Height = 36
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnClose: TBitBtn
      Left = 312
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
    Width = 416
    Height = 291
    ActivePage = tabSettings
    Align = alClient
    Images = frIndicator.imlMain
    TabOrder = 1
    object tabSettings: TTabSheet
      BorderWidth = 10
      Caption = '&Settings'
      ImageIndex = 2
      object lblLanguage: TLabel
        Left = 0
        Top = 8
        Width = 51
        Height = 13
        Caption = 'Lan&guage:'
        FocusControl = cmbLanguage
      end
      object lblAlignment: TLabel
        Left = 216
        Top = 72
        Width = 92
        Height = 13
        Caption = 'Indicator &alignment:'
        FocusControl = cmbAlignment
      end
      object lblShow: TLabel
        Left = 216
        Top = 8
        Width = 30
        Height = 13
        Caption = 'Sho&w:'
        FocusControl = cmbShow
      end
      object cmbLanguage: TComboBox
        Left = 0
        Top = 24
        Width = 170
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 0
        OnChange = cmbLanguageChange
      end
      object cbTransparency: TCheckBox
        Left = 0
        Top = 72
        Width = 97
        Height = 17
        Caption = '&Transparency:'
        TabOrder = 2
        OnClick = cbTransparencyClick
      end
      object tbTransparency: TTrackBar
        Left = 0
        Top = 88
        Width = 170
        Height = 45
        Max = 255
        Frequency = 15
        TabOrder = 3
        OnChange = tbTransparencyChange
      end
      object cmbAlignment: TComboBox
        Left = 216
        Top = 88
        Width = 170
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 4
        OnChange = cmbAlignmentChange
        Items.Strings = (
          'Top-Left'
          'Middle-Left'
          'Bottom-Left'
          'Top-Right'
          'Middle-Right'
          'Bottom-Right')
      end
      object cmbShow: TComboBox
        Left = 216
        Top = 24
        Width = 169
        Height = 21
        Style = csDropDownList
        ItemHeight = 13
        TabOrder = 1
        OnChange = cmbShowChange
        Items.Strings = (
          'Near input area'
          'Near text caret')
      end
    end
    object tabLayouts: TTabSheet
      BorderWidth = 10
      Caption = '&Layouts'
      object pnlLayouts: TPanel
        Left = 112
        Top = 0
        Width = 276
        Height = 242
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        object lblId: TLabel
          Left = 16
          Top = 0
          Width = 14
          Height = 13
          Caption = '&ID:'
          FocusControl = edId
        end
        object lblIcon: TLabel
          Left = 16
          Top = 64
          Width = 24
          Height = 13
          Caption = 'I&con:'
        end
        object edId: TEdit
          Left = 16
          Top = 16
          Width = 170
          Height = 21
          ReadOnly = True
          TabOrder = 0
        end
        object btnIdDetect: TButton
          Left = 192
          Top = 16
          Width = 75
          Height = 25
          Caption = 'De&tect'
          TabOrder = 1
          OnClick = btnIdDetectClick
        end
        object edIcon: TEdit
          Left = 16
          Top = 80
          Width = 170
          Height = 21
          ReadOnly = True
          TabOrder = 2
        end
        object btnIconBrowse: TButton
          Left = 192
          Top = 80
          Width = 75
          Height = 25
          Caption = 'B&rowse...'
          TabOrder = 3
          OnClick = btnIconBrowseClick
        end
      end
      object lbLayouts: TListBox
        Left = 0
        Top = 0
        Width = 112
        Height = 242
        Style = lbOwnerDrawFixed
        Align = alClient
        ItemHeight = 32
        PopupMenu = pmLayouts
        TabOrder = 1
        OnClick = lbLayoutsClick
        OnContextPopup = lbLayoutsContextPopup
        OnDrawItem = lbLayoutsDrawItem
      end
    end
    object tabAbout: TTabSheet
      BorderWidth = 10
      Caption = '&About'
      ImageIndex = 3
      object lblAppName: TLabel
        Left = 56
        Top = 16
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
        Left = 56
        Top = 40
        Width = 34
        Height = 13
        Caption = 'version'
      end
      object lblAuthors: TLabel
        Left = 16
        Top = 168
        Width = 39
        Height = 13
        Caption = 'Authors:'
        FocusControl = memAuthors
      end
      object lblSite: TLabel
        Left = 16
        Top = 64
        Width = 28
        Height = 13
        Cursor = crHandPoint
        Caption = 'lblSite'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsUnderline]
        ParentFont = False
        OnClick = lblSiteClick
      end
      object lblLicense: TLabel
        Left = 16
        Top = 88
        Width = 353
        Height = 73
        AutoSize = False
        Caption = 
          'This program is free software: you can redistribute it and/or mo' +
          'dify it under the terms of the GNU General Public License as pub' +
          'lished by the Free Software Foundation, either version 3 of the ' +
          'License, or (at your option) any later version.'
        WordWrap = True
      end
      object imgLogo: TImage
        Left = 16
        Top = 16
        Width = 32
        Height = 32
      end
      object memAuthors: TMemo
        Left = 16
        Top = 184
        Width = 353
        Height = 49
        Align = alCustom
        ReadOnly = True
        TabOrder = 0
      end
    end
  end
  object pmLayouts: TPopupMenu
    Images = frIndicator.imlMain
    Left = 372
    Top = 201
    object LayoutDelete: TMenuItem
      Caption = '&Delete'
      ImageIndex = 5
      OnClick = LayoutDeleteClick
    end
  end
  object dlgIconBrowse: TOpenPictureDialog
    DefaultExt = 'bmp'
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    InitialDir = 'flags'
    Options = [ofHideReadOnly, ofNoChangeDir, ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 332
    Top = 201
  end
end
