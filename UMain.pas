unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TeEngine, Series, ExtCtrls, TeeProcs, Chart, uMyProcs,
  ExtDlgs, XPMan, Math, ComCtrls, Grids, ExcelXP, OleServer, ComObj,
  IdBaseComponent, IdMessage;

type
  TTTSWform = class(TForm)
    tgEdit: TEdit;
    Label1: TLabel;
    depthEdit: TEdit;
    Label2: TLabel;
    Tbtn: TButton;
    stepEdit: TEdit;
    Label3: TLabel;
    Chart1: TChart;
    Chart2: TChart;
    exportbtn: TButton;
    importbtn: TButton;
    InputFile: TOpenTextFileDialog;
    radiusEdit: TEdit;
    Label4: TLabel;
    pnl1: TPanel;
    botPressureEdit: TEdit;
    Label5: TLabel;
    dlgSave1: TSaveDialog;
    botTempEdit: TEdit;
    Label10: TLabel;
    intervalsbtn: TButton;
    intervCountEdit: TEdit;
    Label6: TLabel;
    inclineButton: TButton;
    chk1: TCheckBox;
    Od: TOpenDialog;
    IdMessage1: TIdMessage;
    Series4: TPointSeries;
    Chart3: TChart;
    Series5: TPointSeries;
    Series1: TPointSeries;
    Series2: TPointSeries;
    geothermalbtn: TButton;
    clearbtn: TButton;
    Series3: TPointSeries;
    rg1: TRadioGroup;
    procedure TbtnClick(Sender: TObject);
    procedure exportbtnClick(Sender: TObject);
    procedure importbtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure intervalsbtnClick(Sender: TObject);
    procedure inclineButtonClick(Sender: TObject);
    procedure geothermalbtnClick(Sender: TObject);
    procedure clearbtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TTSWform: TTTSWform;
  tM, Ll: Integer;
  dl, L, T_0, test, test1: Real48;
  T_geo: array of Real48; // geothermal
  ro: array of Real48; // fluid density
  visc: array of Real48; // fluid viscosity
  T: array of Real48; // temperature
  p: array of Real48; // pressure
  v: array of Real48; // velocity
  angle: array of Real48; // inclination angle
  coss: array of Real48; // cos(angle)
  L_bot: array[0..20] of Real48; // depth of the lower perforation interval
  L_top: array[0..20] of Real48; // depth of the upper perforation interval
  R, D, S, g, Rg, p_c, T_c, acentr, M, kappa, e, n: Real48;
  sQ: array of Real48; // velocity of fluid
  inQ: array[0..20] of Real48; // inflow rate
  inro: array[0..20] of Real48; // inflow density
  inT: array[0..20] of Real48; // inflow temperature
  Z: array of Real48; // compressibility
  MD: array of Real48; // measured depth values
  TVD: array of Real48; // true vertical depth values
  c, fr, Re, lambda, Pr, Nu,
  R0, depth, depth0, dl0, p0, hbot, htop, inQ0, TG, TG0, inT0, T0,
  n0, Qw, fluid : Real48;
  tempfile, inFile: TextFile;
  Excel, WorkBook, List1, FSheet, Range, ArrayData, Cell1, Cell2: Variant;
  input_file_name, s1_, s2_: String;


implementation

uses UintervalGrid, UwellForm;

{$R *.dfm}
function ZZZ(i: Integer): Real;
function supercompressibility(Z: Real): Real;
var aPT, bPT, mPT, AZ, BZ: Real;
begin
  bPT:=0.0778*Rg*T_c/p_c;
  mPT:=0.37464+1.54226*acentr-0.26992*sqr(acentr);
  aPT:=(0.45724*sqr(Rg)*sqr(T_c))/p_c*sqr(1+mPT*(1-sqrt(T[i]/T_c)));
  AZ:=(aPT*p[i])/(sqr(Rg)*sqr(T[i]));
  BZ:=(p[i]*bPT)/(Rg*T[i]);
  Result:=power(Z, 3)+sqr(Z)*(BZ-1)+Z*(AZ-2*BZ-3*sqr(BZ))+(AZ*BZ-sqr(BZ)-power(BZ, 3));
end;
var a, b, e, c, Z: Real;
begin
  a:=0.5;
  b:=3;
  e:=0.00001;
  c:=(a+b)/2;
  while abs(b-a)>e do
  begin
    if ((supercompressibility(a)*supercompressibility(c)) < 0) then
    b:=c
    else a:=c;
    c:=(a+b)/2;
  end;
  Z:=(a+b)/2;
  Result:=Z;
end;
// ------ fluid parameters calculation -------------------------------------- //
procedure fluid_calc(i: Integer);
var critical_visc: Real48;
begin
  if fluid=0 then ro[i]:=800;
  if fluid=1 then ro[i]:=p[i]*M/Z[i]/Rg/T[i];
  if fluid=0 then e:=0.0000004;
  if fluid=1 then e:=-0.000004;
  if fluid=0 then visc[i]:=0.002;
  if fluid=1 then begin
  critical_visc:=1.61*sqrt(M)*power(p_c/1000, 2/3)/power(T_c, 1/6);
  if (T[i]/T_c < 1) then visc[i]:=(critical_visc*power(T[i]/T_c, 0.965))/1000000;
  if (T[i]/T_c > 1) then visc[i]:=(critical_visc*power(T[i]/T_c, 0.71+0.29*T_c/T[i]))/1000000;
  end;
end;
// ------ geothermal distribution calculation ------------------------------- //
procedure T_g(TG: Double; Ll: Integer);
var i: Integer;
begin
if T_geo[0]=0 then
begin
for i:=0 to Ll do
T_geo[i]:=T_0+273.15-TG*i*dl;
end;
end;
// ------ heat transfer coefficient calculation ----------------------------- //
function alphaG(i:Integer):Double;
begin
  Pr:=c*visc[i-1]/lambda;
  if (Re < 2100) then
  begin
    Nu:=4.36;
  end;
  if (Re > 2100) and (Re < 4000) then
  begin
    Nu:=4.36+(0.021*power(4000, 0.8)*power(Pr, 0.43)-4.36)*(Re-2100)/(4000-2100);
  end;
  if (Re > 4000) then
  begin
    Nu:=0.021*power(Re, 0.8)*power(Pr, 0.43);
  end;
  Result:=(lambda*Nu)/D;
end;
// ------- heat exchange with the rocks ------------------------------------- //
procedure T_rocks(i, k: Integer);
var E1: Real;
begin
  E1:=alphaG(i)*dl/c/ro[i-1]/v[i]*2/R;
  T[i]:=E1/(E1+1)*T_geo[i]+T[i-1]/(E1+1);
//  T[i]:=T[i-1]*(1-E1)+E1*T_geo[i];
end;
// ------- temperature in the bottomhole ------------------------------------ //
procedure T_zumpf(i, k: Integer);
var dh, dT0, Rz: Real;
begin
  dT0:=inT[k];
  Rz:=sqrt(1+4*kappa*tM/R); // probing range
  dh:=L_bot[k]-i*dl; // current distance from the bottomhole
  T[i]:=T_geo[i]+dT0*(1-dh/sqrt(dh*dh+Rz*Rz));
end;
// ------- temperature in the first perforated interval --------------------- //
procedure T_perf1(i: Integer);
var E1: Real;
begin
  E1:=alphaG(i)*dl/c/ro[i-1]/v[i]*2/R;
  T[i]:=T[i-1]+e*dl*(p[i]-p[i-1]);
//  test:=e*dl*(p[i]-p[i-1]);
//  test1:=g*cos(angle[i])/c;
end;
// ------- temperature in the perforated interval --------------------------- //
procedure T_perf(i, k : Integer);
var E1, E2: Real;
begin
//  T[i]:=(v[i]*T[i-1]+inv*(inT[k]+T_geo[i]))/(v[i]+inv);
  E2:=inro[k]*inQ[k]*dl/86400/(L_top[k]-L_bot[k])/S/ro[i-1]/v[i];
  T[i]:=(inT[k]+T_geo[i])*E2/(1+E2)+(T[i-1])/(1+E2)-g*coss[Trunc(L)-i]/c;
end;
// ------- pressure calculation --------------------------------------------- //
function press(i, k: Integer):Double;
begin
  Re:=(ro[i-1]*v[i]*D)/visc[i-1];
  if (Re > 2100) then fr:=0.316/power(Re, 0.25)
  else fr:=64/Re;
  Result:=p[i-1]-dl*((ro[i-1]*g*coss[Trunc(L)-i])+(ro[i-1]*sqr(v[i])*fr)/(2*D));
end;
// -------- read input file ------------------------------------------------- //
function GetParametr(s1_:string):real;
  var s2_:string; i:integer;
begin
  s2_:=''; i:=0;
 Repeat
  i:=i+1;
  s2_:=s2_+s1_[i];
 Until (s1_[i]=' ')and(s1_[i+1]='[')or(s1_[i+1]=' ');
  GetParametr:=uMyProcs.MyChkStr2Float(s2_);
end;
// -------------------------------------------------------------------------- //
procedure TTTSWform.clearbtnClick(Sender: TObject);
var
  i: Integer;
begin
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;
  Series5.Clear;
  for i := 0 to Ll do
begin
  T_geo[i]:=0;
  T[i]:=0;
  p[i]:=0;
  angle[i]:=0;
end;
end;

procedure TTTSWform.exportbtnClick(Sender: TObject);
var i, j, Size: Integer;
arg: Double;
begin
  Size:=Trunc(L);
  ArrayData:=VarArrayCreate([1, Size+2, 1, 7], varVariant);
  begin
    ArrayData[1, 1]:= 'Measured Depth, m';
    ArrayData[1, 2]:= 'Geothermal T_geo, K';
    ArrayData[1, 3]:= 'Pressure P, atm';
    ArrayData[1, 4]:= 'Temperature T, K';
    ArrayData[1, 5]:= 'Real gas factor Z';
    ArrayData[1, 6]:= 'Density, kg/m3';
    ArrayData[1, 7]:= 'Viscosity, Pa*s';

    j:=2;
    for i:=0 to Trunc(L) do
    begin
      arg:=(Ll-i)*dl/coss[Ll-i]; // arg axis (measured depth)
      ArrayData[j, 1]:=(depth-i*dl)/coss[Trunc(L)-i];
      ArrayData[j, 2]:=T_geo[i];
      ArrayData[j, 3]:=p[i]/101325;
      ArrayData[j, 4]:=T[i];
      ArrayData[j, 5]:=Z[i];
      ArrayData[j, 6]:=ro[i];
      ArrayData[j, 7]:=visc[i];
      j:=j+1;
    end;
  end;
  begin
    Excel:=CreateOleObject('Excel.Application');
    Excel.DisplayAlerts:=False;
    //Excel.Visible:= True;
    Workbook:=Excel.Workbooks.Add;
    {WorkBook := Excel.Workbooks.Add(ExtractFilePath(Application.ExeName)
        + '\template-excel.xls');}
    List1:= Workbook.ActiveSheet;
    List1.Name:='Modeling Data';

    Cell1 := List1.Cells[1, 1];
    Cell2 := List1.Cells[Size+2, 7];
    Range := WorkBook.ActiveSheet.Range[Cell1, Cell2];
    Range.Value := ArrayData;
    // WorkBook.SaveAs(GetCurrentDir+'\'+'Temperature.xls');
    if dlgSave1.Execute then Workbook.SaveAs(dlgSave1.FileName);
    if dlgSave1.FileName='' then Exit;
    Workbook.Close;
    Excel.Quit;
    Excel:=Unassigned;
  end;
end;

procedure TTTSWform.FormCreate(Sender: TObject);
begin
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;
  Series5.Clear;
end;

procedure TTTSWform.geothermalbtnClick(Sender: TObject);
var
  i, r: Integer;
  exApp, exBook, exSh : Variant;
begin
  if Od.InitialDir = '' then
  Od.InitialDir := ExtractFileName(ParamStr(0));
  if not Od.Execute then Exit;
  if not FileExists(Od.FileName) then begin
    MessageBox(0, 'File not found. Action failed.',
      'Warning!', MB_OK + MB_ICONWARNING + MB_APPLMODAL);
    Exit;
  end;

  try
  exApp := CreateOleObject('Excel.Application');
  except
  MessageBox(0, 'Cannot launch MS Excel. Action failed.',
  'Error!', MB_OK + MB_ICONERROR + MB_APPLMODAL);
  Exit;
  end;

  // Excel window invisible
   exApp.Visible := False;  // убрали чтобы excel не запускался
  // Open the Book
  exBook := exApp.WorkBooks.Open(Od.FileName);

  // First List of the Book
  exSh := exBook.Worksheets[1];

  // activate the last cell of the list
  exSh.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
  // last row
  r:=exApp.ActiveCell.Row;
//  c:=exApp.ActiveCell.Col;
  SetLength(T_geo, r);
  for i:=2 to r do
  T_geo[i-2]:=exSh.Cells[i, 2];

  // close Excel App
  exApp.Quit;

  // memory clear
  exApp:=Unassigned;
  exSh:=Unassigned;
  tgEdit.Text:='Custom';

end;

procedure TTTSWform.importbtnClick(Sender: TObject);
begin
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  InputFile.InitialDir:=GetCurrentDir;
  if InputFile.Execute then
  input_file_name:=InputFile.FileName;
  if input_file_name='' then
  begin
    Exit;
  end;
  s1_:='';
  s2_:='';
  AssignFile(inFile, input_file_name);
  Reset(inFile);
  readln(inFile,s1_); fluid:=GetParametr(s1_);
  readln(inFile,s1_); R0:=GetParametr(s1_);
  readln(inFile,s1_); depth0:=GetParametr(s1_);
  readln(inFile,s1_); dl0:=GetParametr(s1_);
  readln(inFile,s1_); p0:=GetParametr(s1_);
  readln(inFile,s1_); T0:=GetParametr(s1_);
  readln(inFile,s1_); TG0:=GetParametr(s1_);
  readln(inFile,s1_); n0:=GetParametr(s1_);
  readln(inFile,s1_); htop:=GetParametr(s1_);
  readln(inFile,s1_); hbot:=GetParametr(s1_);
  readln(inFile,s1_); inT0:=GetParametr(s1_);
  readln(inFile,s1_); inQ0:=GetParametr(s1_);

  CloseFile(inFile);
  radiusEdit.Text:=FloatToStrf(R0, ffFixed, 4, 2);
  depthEdit.Text:=FloatToStr(depth0);
  stepEdit.Text:=FloatToStr(dl0);
  botPressureEdit.Text:=FloatToStr(p0);
  tgEdit.Text:=FloatToStrf(TG0, ffFixed, 4, 3);
  botTempEdit.Text:=FloatToStr(T0);
  gridForm.strngrd1.Cells[1,1]:=FloatToStr(htop);
  gridForm.strngrd1.Cells[2,1]:=FloatToStr(hbot);
  gridForm.strngrd1.Cells[3,1]:=FloatToStr(inT0);
  gridForm.strngrd1.Cells[4,1]:=FloatToStr(inQ0);
  if fluid=0 then TTSWform.rg1.ItemIndex:=0;
  if fluid=1 then TTSWform.rg1.ItemIndex:=1;
end;

procedure TTTSWform.inclineButtonClick(Sender: TObject);
var
  i, r, j: Integer;
  exApp, exBook, exSh : Variant;
  y: Real;
begin
  if Od.InitialDir = '' then
  Od.InitialDir := ExtractFileName(ParamStr(0));
  if not Od.Execute then Exit;
  if not FileExists(Od.FileName) then begin
    MessageBox(0, 'File not found. Action failed.',
      'Warning!', MB_OK + MB_ICONWARNING + MB_APPLMODAL);
    Exit;
  end;

  try
  exApp := CreateOleObject('Excel.Application');
  except
  MessageBox(0, 'Cannot launch MS Excel. Action failed.',
  'Error!', MB_OK + MB_ICONERROR + MB_APPLMODAL);
  Exit;
  end;

  // Excel window invisible
   exApp.Visible := False;  // убрали чтобы excel не запускался
  // Open the Book
  exBook := exApp.WorkBooks.Open(Od.FileName);

  // First List of the Book
  exSh := exBook.Worksheets[1];

  // activate the last cell of the list
  exSh.Cells.SpecialCells(xlCellTypeLastCell, EmptyParam).Activate;
  // last row
  r:=exApp.ActiveCell.Row;
//  c:=exApp.ActiveCell.Col;
  SetLength(MD, r-1);
  SetLength(TVD, r-1);
  for i:=2 to r do
  begin
    MD[i-2]:=exSh.Cells[i, 1];
    TVD[i-2]:=exSh.Cells[i, 2];
  end;

  // close Excel App
  exApp.Quit;

  // memory clear
  exApp:=Unassigned;
  exSh:=Unassigned;

  if (depth0=0) then depth:=StrToFloat(depthEdit.Text) else depth:=depth0; // all vertical depth
  if (dl0=0) then dl:=StrToFloat(stepEdit.Text) else dl:=dl0; // depth step

  L:=depth/dl; // step amount (vertical)
  Ll:=Trunc(L);
  dl:=depth/Ll; // depth step

  SetLength(coss, Ll);
  SetLength(angle, Ll);
  j:=0; // "MD <-> TVD counter"
  for i:=0 to Ll do
  begin
    if (j+1 < r) then
    begin
      coss[i]:=TVD[j]/MD[j];
      angle[i]:=ArcCos(coss[i]);
    if (Abs(i*dl-TVD[j]) <= 0.01) then j:=j+1;
    end
    else begin
      coss[i]:=coss[i-1];
      angle[i]:=ArcCos(coss[i]);
    end;
  end;
  y:=0;
  wellForm.Series1.Clear;
  for i:=1 to Ll do
  begin
  y:=y+dl*Tan(angle[i]);
    wellForm.Series1.AddXY(y, i*dl, '', clBlack);
  end;

//  test:=Cos(DegToRad(60));

  if chk1.Checked=True then wellForm.Show;


end;

procedure TTTSWform.intervalsbtnClick(Sender: TObject);
var i: Integer;
begin
  n:=StrToFloat(intervCountEdit.Text);
  depth:=StrToFloat(depthEdit.Text);
  gridForm.strngrd1.RowCount:=Trunc(n+1);
  for i:=1 to Trunc(n) do gridForm.strngrd1.Cells[0,i]:=IntToStr(i);
  gridForm.Show;
end;

procedure TTTSWform.TbtnClick(Sender: TObject);
var i, k, ii, Ll: Integer;
    dT, arg : Double;
begin
// ------ wellbore parameters ----------------------------------------------- //
  depth:=StrToFloat(depthEdit.Text); // well depth
  dl:=StrToFloat(stepEdit.Text); // depth step
  TG:=StrToFloat(tgEdit.Text); // geothermal gradient
  R:=StrToFloat(radiusEdit.Text); // wellbore radius
  D:=2*R; // wellbore diameter
  S:=pi*R*R;
  L:=depth/dl; // step amount (vertical)
  Ll:=Trunc(L);
  dl:=depth/Ll; // depth step

  k:=1; // perforation interval counter
  SetLength(ro, Ll);
  SetLength(visc, Ll);
  SetLength(T_geo, Ll);
  SetLength(T, Ll);
  SetLength(p, Ll);
  SetLength(coss, Ll);
  SetLength(angle, Ll);
  SetLength(v, Ll);
  SetLength(sQ, Ll);
  SetLength(Z, Ll);
// ---- RESET before RE-calculation---- //
  Series1.Clear;
  Series2.Clear;
  Series3.Clear;
  Series4.Clear;
  Series5.Clear;
  for i := 0 to Ll do
begin
  T_geo[i]:=0;
  T[i]:=0;
  p[i]:=0;
  if coss[i]=0 then coss[i]:=1;
end;

  n:=StrToFloat(intervCountEdit.Text); // number of inflow intervals
  L_top[1]:=depth-StrToFloat(gridForm.strngrd1.Cells[1,1]);
  L_bot[1]:=depth-StrToFloat(gridForm.strngrd1.Cells[2,1]);
  inQ[1]:=StrToFloat(gridForm.strngrd1.Cells[4,1]);
  inT[1]:=StrToFloat(gridForm.strngrd1.Cells[3,1]); // inflow temperature
  T_0:=StrToFloat(botTempEdit.Text); // initial bottomhole temperature
  T_g(TG, Ll);
  Series1.Clear;
  for i:=0 to Ll do
  Series1.AddXY(T_geo[i]-273.15, (Ll-i)*dl/coss[Ll-i], '', clRed); // geothermal plot
// ------ main constants ---------------------------------------------------- //
  g:=9.8; // gravity constant
  Rg:=8.314; // gas constant
  M:=0.01604; // molar mass of methane
  T_c:=190.55;
  p_c:=4695000;
  acentr:={-1-log10(p_c)}0.0104;
// ------ initial conditions------------------------------------------------- //
  p[0]:=StrToFloat(botPressureEdit.Text)*101325; // initial bot pressure
  T[0]:=T_geo[0]; // initial bottomhole temperature
  Z[0]:=0.92874;
  if (rg1.ItemIndex = 0) then fluid:=0;
  if (rg1.ItemIndex = 1) then fluid:=1;

  if fluid=0 then ro[0]:=800;
  if fluid=1 then ro[0]:=p[0]*M/Z[0]/Rg/T[0]; // initial bottomhole density
  if fluid=0 then visc[0]:=0.002;
  if fluid=1 then visc[0]:=3.749e-05; // initial bottomhole viscosity
  c:=3500;  // thermal capacity
  kappa:=0.0150; // piezoconductivity
  tM:=500;  // measuring time
  lambda:=0.065;
// -------------------------------------------------------------------------- //
  Series2.Clear;
// ************************************************************************** //
// --------------------------- MAIN CYCLE ----------------------------------- //
  for i:=1 to Ll do
  begin
    arg:=(Ll-i)*dl/coss[Ll-i]; // arg axis (measured depth)
    if (i*dl < L_bot[1]) then // bottomhole
    begin
      T_zumpf(i, k);
      v[i]:=1e-5;
      p[i]:=p[i-1]-dl*ro[i-1]*g*coss[Ll-i];
      Z[i]:=ZZZ(i);
      fluid_calc(i);
      Series2.AddXY(T[i]-273.15, arg, '', clBlack);
      Series3.AddXY(p[i]/101325, arg, '', clBlue);
      Series5.AddXY(v[i], arg, '', clRed);
    end;
    if (i*dl >= L_bot[1]) and (i*dl <= L_top[1]) then // 1st perforation interval (k=1)
    begin
      sQ[i]:=sQ[i-1]+inQ[1]/((L_top[1]-L_bot[1])/dl);
      v[i]:=sQ[i]/S/86400;
      p[i]:=press(i, k);
      T_perf1(i);
      Z[i]:=ZZZ(i);
      fluid_calc(i);
      Series2.AddXY(T[i]-273.15, arg, '', clBlack);
      Series3.AddXY(p[i]/101325, arg, '', clBlue);
      Series4.AddXY(25, arg, '', clBlack);
      Series5.AddXY(v[i], arg, '', clRed);
    end;
    if (k > 1) and (i*dl >= L_bot[k]) and (i*dl <= L_top[k]) then // k-th perforation interval (k>1)
    begin
      sQ[i]:=sQ[i-1]+inQ[k]/((L_top[k]-L_bot[k])/dl);
      v[i]:=sQ[i]/S/86400;
      p[i]:=press(i, k);
      inro[k]:=ro[i];
      T_perf(i, k);
      Z[i]:=ZZZ(i);
      fluid_calc(i);
      Series2.AddXY(T[i]-273.15, arg, '', clBlack);
      Series3.AddXY(p[i]/101325, arg, '', clBlue);
      Series4.AddXY(25, arg, '', clBlack);
      Series5.AddXY(v[i], arg, '', clRed);
    end;
    if k < n then
    begin
      if (i*dl <= L_bot[k+1]) and (i*dl > L_top[k]) then // interval without perforation
      begin
      sQ[i]:=sQ[i-1];
      v[i]:=v[i-1];
      p[i]:=press(i, k);
      T_rocks(i, k);
      Z[i]:=ZZZ(i);
      fluid_calc(i);
      Series2.AddXY(T[i]-273.15, arg, '', clBlack);
      Series3.AddXY(p[i]/101325, arg, '', clBlue);
      Series5.AddXY(v[i], arg, '', clRed);
      if (abs(L_bot[k+1]-i*dl) <= 0.01) then k:=k+1;
      end;
    end
    else
    begin
      if (i*dl > L_top[k]) then // interval without perforation
      begin
      sQ[i]:=sQ[i-1];
      v[i]:=v[i-1];
      p[i]:=press(i, k);
      T_rocks(i, k);
      Z[i]:=ZZZ(i);
      fluid_calc(i);
      Series2.AddXY(T[i]-273.15, arg, '', clBlack);
      Series3.AddXY(p[i]/101325, arg, '', clBlue);
      Series5.AddXY(v[i], arg, '', clRed);
      end;
    end;
  end;
end;
end.