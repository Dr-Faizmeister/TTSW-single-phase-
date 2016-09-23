unit uMyProcs;
(*
   Набор полезных подпрограмм.
   Создан: 01.01.2008, Ивановым И.И.
////////////////////////////////////////////////////////
Изменения:
==01) (03.01.2008, Иванов И.И.)
  01.1) Добавление xxx;
  01.2) Исправлено yyy;
////////////////////////////////////////////////////////
*)

interface

uses
   SysUtils;

////////////////////////////////////////////////////////
// TYPES
type
   float = double;

   // EInvalidFloat: исключение, которое поднимается при неверном формате числовых строк
   EInvalidFloat = class(Exception);

////////////////////////////////////////////////////////
// CONST
const
   cDefFloatDecs = 3; // кол-во дес. знаков (цифр) при форматировании float

////////////////////////////////////////////////////////
// PROC
   // MyStr2Float: представить строку s как вещественное число;
   // в отличии от стандартных (StrToFloat/Val) принимает как разделители 
   // и дес. точку и запятую, автоматически пропускает начальные
   // пробелы в s;
   // при ошибках присваивается Default;
   // MyChkStr2Float: при ошибках поднимает исключение;
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
      {ошибка преобразования} Result := Default;
end;

function MyChkStr2Float( const s: string ) : float;
var i: integer;
begin
   Val( AnsiReplaceStr( Trim(s), ',', '.'), Result, i );
   if  i <> 0 then
      {ошибка преобразования} Raise EInvalidFloat.CreateFmt( 'Строка <%s> не является числом', [s] );
end;

end.