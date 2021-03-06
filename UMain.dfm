object TTSWform: TTTSWform
  Left = 0
  Top = 0
  Caption = 'TTSW'
  ClientHeight = 590
  ClientWidth = 928
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Chart1: TChart
    Left = 0
    Top = 0
    Width = 281
    Height = 590
    Cursor = crCross
    Legend.Visible = False
    PrintProportional = False
    Title.Font.Color = -1
    Title.Font.Name = 'Leelawadee UI'
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'Temperature, '#176#1057)
    BottomAxis.Automatic = False
    BottomAxis.AutomaticMaximum = False
    BottomAxis.Maximum = 50.000000000000000000
    BottomAxis.PositionPercent = 100.000000000000000000
    LeftAxis.Grid.SmallDots = True
    LeftAxis.Inverted = True
    RightAxis.Grid.Style = psSolid
    View3D = False
    Zoom.Pen.Color = 16744576
    Align = alLeft
    Color = clWhite
    TabOrder = 0
    PrintMargins = (
      38
      13
      38
      18)
    ColorPaletteIndex = 10
    object Series1: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 8
      Marks.Visible = False
      ClickableLine = False
      Pointer.Brush.Color = -1
      Pointer.Brush.Gradient.EndColor = 390140
      Pointer.Gradient.EndColor = 390140
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = -1
      Pointer.Style = psRectangle
      Pointer.VertSize = 1
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Data = {
        0241000000000000000000000000000020000000000000000000000020000000
        0000000000000000200000000000000000000000200000000000000000000000
        2000000000000000000000002000000000000000000000002000000000000000
        0000000020000000000000000000000020000000000000000000000020000000
        0000000000000000200000000000000000000000200000000000000000000000
        2000000000000000000000002000000000000000000000002000000000000000
        0000000020000000000000000000000020000000000000000000000020000000
        0000000000000000200000000000000000000000200000000000000000000000
        200000000000000000FFFFFF0000000000000000000000002000000000000000
        00FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F000000
        0000000000FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF
        1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F00000000000000
        00FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F000000
        0000000000FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF
        1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F00000000000000
        00FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F000000
        0000000000FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF
        1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F00000000000000
        00FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F000000
        0000000000FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF
        1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F00000000000000
        00FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F000000
        0000000000FFFFFF1F0000000000000000FFFFFF1F0000000000000000FFFFFF
        1F0000000000000000FFFFFF1F0000000000000000FFFFFF1F00000000000000
        00FFFFFF1F0000000000000000FFFFFF1F}
    end
    object Series2: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 8
      Marks.Visible = False
      DataSource = Series1
      ClickableLine = False
      Pointer.Brush.Color = 168
      Pointer.Brush.Gradient.EndColor = 156927
      Pointer.Gradient.EndColor = 156927
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = 155
      Pointer.Style = psRectangle
      Pointer.VertSize = 1
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
    end
    object horizontal1: THorizAreaSeries
      Gradient.Direction = gdRightLeft
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Visible = False
      SeriesColor = 8421631
      AreaChartBrush.Color = -1
      DrawArea = True
      Pointer.Brush.Gradient.EndColor = 4227327
      Pointer.Gradient.EndColor = 4227327
      Pointer.InflateMargins = True
      Pointer.Style = psRectangle
      Pointer.Visible = False
      Transparency = 99
      XValues.Name = 'X'
      XValues.Order = loNone
      YValues.Name = 'Y'
      YValues.Order = loAscending
      Data = {
        010A00000000000000000000000000000000000000721CC7711CC75B40000000
        0000000000721CC7711CC76B4000000000000000005655555555D57440000000
        0000000000721CC7711CC77B400000000000000000C7711CC7715C8140000000
        00000000005555555555D584400000000000000000E3388EE3384E8840000000
        0000000000711CC7711CC78B400000000000000000FFFFFFFFFF3F8F40000000
        0000000000}
    end
  end
  object Chart2: TChart
    Left = 281
    Top = 0
    Width = 230
    Height = 590
    Cursor = crCross
    Legend.Visible = False
    Title.Font.Color = -1
    Title.Font.Name = 'Leelawadee UI'
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'Pressure, atm')
    BottomAxis.MinimumOffset = 50
    BottomAxis.PositionPercent = 100.000000000000000000
    LeftAxis.Inverted = True
    RightAxis.Grid.Style = psSolid
    View3D = False
    Zoom.Pen.Color = 16744576
    Align = alLeft
    Color = clWhite
    TabOrder = 1
    PrintMargins = (
      35
      15
      35
      15)
    ColorPaletteIndex = 6
    object Series3: TPointSeries
      Cursor = crDrag
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 8
      Marks.Visible = False
      SeriesColor = 16744448
      ClickableLine = False
      Pointer.Brush.Color = 16744448
      Pointer.Brush.Gradient.EndColor = 16744448
      Pointer.Brush.Gradient.Visible = True
      Pointer.Gradient.EndColor = 16744448
      Pointer.Gradient.Visible = True
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = 16744448
      Pointer.Style = psRectangle
      Pointer.VertSize = 1
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Data = {
        0019000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000008031400000000000404F400000000000906540000000
        0000C047400000000000004E4000000000009065400000000000205240000000
        000080314000000000006053400000000000D061400000000000E06A40000000
        0000D066400000000000B06D400000000000C067400000000000805640000000
        00007062400000000000A06440}
    end
  end
  object pnl1: TPanel
    Left = 720
    Top = 0
    Width = 208
    Height = 590
    Align = alRight
    TabOrder = 2
    object Label1: TLabel
      Left = 32
      Top = 235
      Width = 130
      Height = 13
      Caption = 'Geothermal Gradient, '#176'C/m'
    end
    object Label2: TLabel
      Left = 32
      Top = 56
      Width = 44
      Height = 13
      Caption = 'Depth, m'
    end
    object Label3: TLabel
      Left = 32
      Top = 102
      Width = 69
      Height = 13
      Caption = 'Depth Step, m'
    end
    object Label4: TLabel
      Left = 31
      Top = 10
      Width = 89
      Height = 13
      Caption = 'Wellbore radius, m'
    end
    object Label5: TLabel
      Left = 32
      Top = 148
      Width = 124
      Height = 13
      Caption = 'Bottomhole Pressure, atm'
    end
    object Label10: TLabel
      Left = 32
      Top = 192
      Width = 138
      Height = 13
      Caption = 'Bottomhole Temperature, '#176'C'
    end
    object Label6: TLabel
      Left = 32
      Top = 281
      Width = 125
      Height = 13
      Caption = 'Number of inflow intervals'
    end
    object depthEdit: TEdit
      Left = 32
      Top = 75
      Width = 73
      Height = 21
      TabOrder = 0
      Text = '1000'
    end
    object exportbtn: TButton
      Left = 38
      Top = 552
      Width = 75
      Height = 25
      Caption = 'Export Data'
      TabOrder = 1
      OnClick = exportbtnClick
    end
    object importbtn: TButton
      Left = 38
      Top = 521
      Width = 75
      Height = 25
      Caption = 'Import Data'
      TabOrder = 2
      OnClick = importbtnClick
    end
    object radiusEdit: TEdit
      Left = 31
      Top = 29
      Width = 74
      Height = 21
      TabOrder = 3
      Text = '0,12'
    end
    object stepEdit: TEdit
      Left = 32
      Top = 121
      Width = 73
      Height = 21
      TabOrder = 4
      Text = '1'
    end
    object Tbtn: TButton
      Left = 38
      Top = 384
      Width = 75
      Height = 34
      Caption = 'RUN'
      TabOrder = 5
      OnClick = TbtnClick
    end
    object tgEdit: TEdit
      Left = 32
      Top = 254
      Width = 74
      Height = 21
      TabOrder = 6
      Text = '0,02'
    end
    object botPressureEdit: TEdit
      Left = 32
      Top = 167
      Width = 73
      Height = 21
      TabOrder = 7
      Text = '85'
    end
    object botTempEdit: TEdit
      Left = 32
      Top = 208
      Width = 73
      Height = 21
      TabOrder = 8
      Text = '45'
    end
    object intervalsbtn: TButton
      Left = 38
      Top = 459
      Width = 75
      Height = 25
      Caption = 'Layers'
      TabOrder = 9
      OnClick = intervalsbtnClick
    end
    object inclineButton: TButton
      Left = 38
      Top = 490
      Width = 75
      Height = 25
      Caption = 'Inclinometry'
      TabOrder = 10
      OnClick = inclineButtonClick
    end
    object chk1: TCheckBox
      Left = 114
      Top = 495
      Width = 97
      Height = 17
      Caption = 'Show Well Form'
      Checked = True
      State = cbChecked
      TabOrder = 11
    end
    object geothermalbtn: TButton
      Left = 120
      Top = 254
      Width = 74
      Height = 21
      Caption = 'Load'
      TabOrder = 12
      OnClick = geothermalbtnClick
    end
    object clearbtn: TButton
      Left = 128
      Top = 552
      Width = 73
      Height = 25
      Caption = 'RESET'
      TabOrder = 13
      OnClick = clearbtnClick
    end
    object rg1: TRadioGroup
      Left = 32
      Top = 327
      Width = 145
      Height = 51
      Caption = 'Fluid'
      ItemIndex = 0
      Items.Strings = (
        'Oil'
        'Gas')
      TabOrder = 14
    end
    object se1: TSpinEdit
      Left = 32
      Top = 296
      Width = 73
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 15
      Value = 2
    end
  end
  object Chart3: TChart
    Left = 511
    Top = 0
    Width = 209
    Height = 590
    Cursor = crCross
    Legend.Visible = False
    Title.Font.Color = -1
    Title.Font.Name = 'Leelawadee UI'
    Title.Font.Style = [fsBold]
    Title.Text.Strings = (
      'Velocity, m/s')
    BottomAxis.PositionPercent = 100.000000000000000000
    LeftAxis.Inverted = True
    View3D = False
    Zoom.Pen.Color = 16744576
    Align = alLeft
    Color = clWhite
    TabOrder = 3
    ColorPaletteIndex = 13
    object Series5: TPointSeries
      Marks.Arrow.Visible = True
      Marks.Callout.Brush.Color = clBlack
      Marks.Callout.Arrow.Visible = True
      Marks.Callout.Length = 8
      Marks.Visible = False
      ClickableLine = False
      Pointer.Brush.Color = 192
      Pointer.Brush.Gradient.EndColor = 10708548
      Pointer.Gradient.EndColor = 10708548
      Pointer.HorizSize = 1
      Pointer.InflateMargins = True
      Pointer.Pen.Color = 192
      Pointer.Style = psRectangle
      Pointer.VertSize = 1
      Pointer.Visible = True
      XValues.Name = 'X'
      XValues.Order = loAscending
      YValues.Name = 'Y'
      YValues.Order = loNone
      Data = {
        00190000000000000000E07F400000000000C483400000000000988240000000
        0000D081400000000000008440000000000098874000000000005C8740000000
        0000588640000000000088834000000000008482400000000000687F40000000
        00004080400000000000FC8240000000000008814000000000007C8040000000
        000028844000000000006880400000000000407F4000000000001C8140000000
        000090804000000000004C834000000000005485400000000000348740000000
        00008883400000000000248340}
    end
  end
  object InputFile: TOpenTextFileDialog
    Left = 592
    Top = 544
  end
  object dlgSave1: TSaveDialog
    Left = 528
    Top = 544
  end
  object Od: TOpenDialog
    Left = 464
    Top = 544
  end
  object IdMessage1: TIdMessage
    AttachmentEncoding = 'UUE'
    BccList = <>
    CCList = <>
    Encoding = meDefault
    FromList = <
      item
      end>
    Recipients = <>
    ReplyTo = <>
    ConvertPreamble = True
    Left = 392
    Top = 544
  end
end
