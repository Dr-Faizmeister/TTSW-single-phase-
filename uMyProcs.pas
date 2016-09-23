unit uMyProcs;
(*
   ����� �������� �����������.
   ������: 01.01.2008, �������� �.�.
////////////////////////////////////////////////////////
���������:
==01) (03.01.2008, ������ �.�.)
  01.1) ���������� xxx;
  01.2) ���������� yyy;
////////////////////////////////////////////////////////
*)

interface

uses
   SysUtils;

////////////////////////////////////////////////////////
// TYPES
type
   float = double;

   // EInvalidFloat: ����������, ������� ����������� ��� �������� ������� �������� �����
   EInvalidFloat = class(Exception);

////////////////////////////////////////////////////////
// CONST
const
   cDefFloatDecs = 3; // ���-�� ���. ������ (����) ��� �������������� float

////////////////////////////////////////////////////////
// PROC
   // MyStr2Float: ����������� ������ s ��� ������������ �����;
   // � ������� �� ����������� (StrToFloat/Val) ��������� ��� ����������� 
   // � ���. ����� � �������, ������������� ���������� ���������
   // ������� � s;
   // ��� ������� ������������� Default;
   // MyChkStr2Float: ��� ������� ��������� ����������;
   //
   function MyStr2Float( const s: string; Default: float = 0 ) : float;
   function MyChkStr2Float( const s: string ) : float;

implementation

uses
   StrUtils;

////////////////////////////////////////////////////////
// INTERFACE
function MyStr2Float( const s: string; Default: float ) : float;
var i: integer;
begin
   Val( AnsiReplaceStr( Trim(s), ',', '.'), Result, i );
   if  i <> 0 then
      {������ ��������������} Result := Default;
end;

function MyChkStr2Float( const s: string ) : float;
var i: integer;
begin
   Val( AnsiReplaceStr( Trim(s), ',', '.'), Result, i );
   if  i <> 0 then
      {������ ��������������} Raise EInvalidFloat.CreateFmt( '������ <%s> �� �������� ������', [s] );
end;

end.