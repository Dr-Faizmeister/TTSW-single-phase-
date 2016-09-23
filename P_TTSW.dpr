program P_TTSW;

uses
  Forms,
  UMain in 'UMain.pas' {TTSWform},
  uMyProcs in 'uMyProcs.pas',
  UintervalGrid in 'UintervalGrid.pas' {gridForm},
  UwellForm in 'UwellForm.pas' {wellForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TTTSWform, TTSWform);
  Application.CreateForm(TgridForm, gridForm);
  Application.CreateForm(TwellForm, wellForm);
  Application.Run;
end.
