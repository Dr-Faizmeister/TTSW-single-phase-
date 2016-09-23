unit UwellForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TwellForm = class(TForm)
    Chart1: TChart;
    Series1: TPointSeries;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  wellForm: TwellForm;

implementation

uses UMain;

{$R *.dfm}


end.
