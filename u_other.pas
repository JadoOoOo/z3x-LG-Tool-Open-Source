unit u_other;

interface

uses
Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, StrUtils, IOPCOM3Lib_TLB, DCPcrypt2, DCPsha1, DCPdes,
  DCPblockciphers, ComObj, ActiveX, wininet, inifiles, Tlhelp32;

  type
    rec = record
    data: array [1..6000] of char;
  end;


const
  card_command_ok = chr($90)+chr($00);
  card_fishMD_say_ky = 'fishMD say KY!!';
  card_fucking_java = 'FUCKING JAVA!!!';
  card_mk_noname = 'MK AND NONAME - GOOD BOYS ;)';
  card_zxxx_ok = chr($62)+chr($00);

var
  boxx: array[byte] of byte;
  strng: string;
  rec_val: rec;
  last_login_code: string;
  cb: integer;

function cry_file_load(unzip: string; onlyinf: Boolean = false; blocksize: Integer = 0; need_card_using: boolean = false; code_cut: boolean = true): Boolean;
function gethex(s: string) : string;
function getstr(s: string) : string;
function send_card(s: string; ashex: Boolean = false; withoutstatus: Boolean = false; needsearch: Boolean = true): string;
function PSArrayToStr(const ArrayToConvert: PSafeArray): string;
function DownloadURL(const aUrl: string; var s: String): Boolean;
procedure showmessage2(s: string);
function lang(s:string):string;
function des(pwd: String; data, out_data: TStream; need_des: Boolean): Boolean;
procedure str_to_stream(s:string; var stream:TMemoryStream);
function KillTask(ExeFileName: string): integer;
function card_dec_string (data: string): string;
procedure Code(var text: string; password: string; decode: boolean);

implementation

uses u_main, ComCtrls, EXECryptor;

function KillTask(ExeFileName: string): integer;
const
PROCESS_TERMINATE=$0001;
var
ContinueLoop: BOOL;
FSnapshotHandle: THandle;
FProcessEntry32: TProcessEntry32;
begin
result := 0;

FSnapshotHandle := CreateToolhelp32Snapshot
(TH32CS_SNAPPROCESS, 0);
FProcessEntry32.dwSize := Sizeof(FProcessEntry32);
ContinueLoop := Process32First(FSnapshotHandle,
FProcessEntry32);

while integer(ContinueLoop) <> 0 do
begin
if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) =
UpperCase(ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) =
UpperCase(ExeFileName))) then
Result := Integer(TerminateProcess(OpenProcess(
PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
end;

CloseHandle(FSnapshotHandle);
end;

function lang(s:string):string;
var
  myini:TIniFile;
begin
      myini:=TIniFile.Create(ExtractFilePath(Application.ExeName)+'languages.dat');
      result:=myini.ReadString(f_main.cbLngList.text,s,s);
      if Trim(result)='' then
        result:=s;
      if length(result)>255 then
        result:=copy(result,1,255);
      myini.Free;
end;

// des function with card using
function des(pwd: String; data, out_data: TStream; need_des: Boolean): Boolean;
var
  box: array[byte] of byte;
  data_length, i: integer;
  j, a, k, tmp, tmp2: byte;
  b, bb: byte;
  s: WideString;
  tocard, fromcard, ans: string;
  ser1, ser2: byte;
begin

  if not IsAppProtected then
   ShowMessage2(lang('Protection error!'));
  Result:= false;
  data_length := data.Size;
  out_data.Size:= data.size;

  if need_des then
   begin

    ans:= send_card('00A40400087711223344005511');
    if ans <> card_command_ok then
     begin
      f_main.logs(lang('Card error!')+' (D1'+gethex(ans)+')');
      exit;
     end;

    tocard:= '55620000'+IntToHex(length(pwd),2);
    for i:=1 to length(pwd) do
     tocard:= tocard+inttohex(ord(pwd[i]),2);

    ans:= send_card(tocard);

    if ans <> card_command_ok then
     begin
      f_main.logs(lang('Card error!')+' (D2'+gethex(ans)+')');
      exit;
     end;

    fromcard:= send_card('55630000FF',false,true);

    if length(fromcard) <> 255 then
     begin
      //ShowMessage(gethex(fromcard));
      f_main.logs(lang('Card error!')+' (D3'+IntToStr(length(fromcard))+')');
      exit;
     end;

    ser1:= 91;
    ser2:= 93-1;
    if ord(card_sn[9]) <> 0 then
     ser1:= ord(card_sn[9]) xor 30;
    if ord(card_sn[8]) <> 0 then
     ser2:= ord(card_sn[8]) xor 20;
    for i:=0 to $FF-1 do
     begin
      tmp2:=ord(fromcard[i+1]);
      if (i mod 2) <> 0 then
       box[i] := tmp2 xor ser1
      else
       box[i] := tmp2 xor ser2;
      boxx[i]:=box[i];
     end;

    need_des:= false;
   end
  else
   begin
    for i:=0 to $FF do
     box[i]:= boxx[i];
   end;

  a:=0;
  j:=0;
  s:='';

  for i := 0 to 1048575 do
   begin
    data.Position:=i;
    out_data.Position:=i;
    data.Read(b,1);

    a := (a + 1) mod 256;
    j := (j + box[a]) mod 256;
    tmp := box[a];
    box[a] := box[j];
    box[j] := tmp;
    k := box[((box[a] + box[j]) mod 256)];
    bb:=b xor k;

    out_data.Write(bb,1);
   end;
  out_data.Position:= 1048576;
  out_data.CopyFrom(data,data_length-1048576-1);
  Result:= true;
end;

procedure showmessage2(s: string);
begin
 SafeMessageBox(Application.Handle,pchar(s),'z3x-team',MB_OK or MB_ICONINFORMATION);
 if s = lang('Protection error!') then
  Application.Terminate;
end;

procedure upcb;
begin
  if cb=3 then cb:=-1;
  cb:=cb+1;
end;

// download URL to string
{function DownloadURL(const aUrl: string; var s: String): Boolean;
 var
   hSession: HINTERNET;
   hService: HINTERNET;
   lpBuffer: array[0..1024 + 1] of Char;
   dwBytesRead: DWORD;
 begin
   Result := False;
   s := '';
  hSession := InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
   try
     if Assigned(hSession) then
     begin
       hService := InternetOpenUrl(hSession, PChar(aUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
       if Assigned(hService) then
         try
           while True do
           begin
             dwBytesRead := 1024;
             InternetReadFile(hService, @lpBuffer, 1024, dwBytesRead);
             if dwBytesRead = 0 then break;
             lpBuffer[dwBytesRead] := #0;
             s := s + lpBuffer;
           end;
           Result := True;
         finally
           InternetCloseHandle(hService);
         end;
     end;
   finally
     InternetCloseHandle(hSession);
   end;
 end;}

// hex => str
function getstr(s: string) : string;
var
  i: integer;
begin
  Result:='';
  for i:=1 to Length(s) do
   if i mod 2 = 0 then
    Result:= Result+chr(strtoint('$'+s[i-1]+s[i]));
end;

// str => hex
function gethex(s: string) : string;
var
  i: integer;
begin
  Result:='';
  for i:=1 to Length(s) do
   Result:= Result+inttohex(ord(s[i]), 2);
end;

// raplace spec chars in string
function StringReplace(text: string; tfrom, tto: integer): string;
var
  i,ii: integer;
begin
  Result:='';
  if tto = 0 then
   tto:= length(text);
  if tfrom = 0 then
   tfrom:= 1;
  SetLength(Result,length(text));
  ii:= tfrom;
  for i:=tfrom to tto do
   case text[i] of
    '}': begin Result[ii]:='}'; Result[ii+1]:=']'; ii:= ii+2; SetLength(Result,Length(Result)+1); end;
    '~': begin Result[ii]:='}'; Result[ii+1]:='^'; ii:= ii+2; SetLength(Result,Length(Result)+1); end;
   else
    Result[ii]:=text[i];
    ii:= ii+1;
   end;
end;

// vygis activex to string
function PSArrayToStr(const ArrayToConvert: PSafeArray): string;
var
   i, MyUBound: Integer;
   ResultData: PByteArray;
begin
   Result:='';
   SafeArrayGetUBound(ArrayToConvert, 1, MyUBound);
   for i := 0 to MyUBound do
    SafeArrayGetElement(ArrayToConvert, i, ResultData^[i]);
   for i := 0 to MyUBound do
    Result:= Result+IntToHex(ResultData[i],2);
end;

// send to card and wait response
function send_card(s: string; ashex: Boolean = false; withoutstatus: Boolean = false; needsearch: Boolean = true): string;
begin
  {$I crypt_start.inc}

  if not IsAppProtected then
   ShowMessage2('Protection error!');

  result:= f_Main.card.GetResponseFromCard(getstr(s));
  if withoutstatus then
   if Length(Result) >=2 then
    Delete(Result,length(Result)-1,2);
  if ashex then result:=gethex(Result);

  if not IsAppProtected then
   halt;

  {$I crypt_end.inc}
end;

// modf
function modf(f1, f2: double): double;
var
  t1, t2, t3: double;
begin
  t1:= f1 / f2;
  t2:= trunc(t1);
  t3:= f2 * t2;
  Result:= f1 - t3;
end;

function DownloadURL(const aUrl: string; var s: String): Boolean;
 var
   hSession: HINTERNET;
   hService: HINTERNET;
   lpBuffer: array[0..1024 + 1] of Char;
   dwBytesRead: DWORD;
 begin
   Result := False;
   s := '';
  hSession := InternetOpen('MyApp', INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
   try
     if Assigned(hSession) then
     begin
       hService := InternetOpenUrl(hSession, PChar(aUrl), nil, 0, INTERNET_FLAG_RELOAD, 0);
       if Assigned(hService) then
         try
           while True do
           begin
             dwBytesRead := 1024;
             InternetReadFile(hService, @lpBuffer, 1024, dwBytesRead);
             if dwBytesRead = 0 then break;
             lpBuffer[dwBytesRead] := #0;
             s := s + lpBuffer;
           end;
           Result := True;
         finally
           InternetCloseHandle(hService);
         end;
     end;
   finally
     InternetCloseHandle(hSession);
   end;
 end;

// load crypted file
function cry_file_load(unzip: string; onlyinf: Boolean = false; blocksize: Integer = 0; need_card_using: boolean = false; code_cut: boolean = true): Boolean;
var
  tfs: TFileStream;
  ms12, ms1, tfs2: TMemoryStream;
  s: string;
begin
  if not IsAppProtected then
   ShowMessage2(lang('Protection error!'));
  result:=false;
  try
   tfs:= TFileStream.Create(f_Main.eFlashFile.Text, fmOpenRead);
   ms12:= TMemoryStream.Create;
   ms12.Size:= tfs.Size;
   tfs.Position:=0;
   ms12.Position:=0;
   if IsAppProtected then
   f_Main.CipherManager1.InitKey(inttostr(ord('l')+83)+'934665345356ewqe345677'+inttostr(0)+'7855645hfgh6578b543c'+'7E',nil);
   f_Main.CipherManager1.DecodeStream(tfs, ms12, tfs.Size);
   tfs.Free;
   tfs2:= TMemoryStream.Create;
   tfs2.Size:= ms12.Size;
   tfs2.Position:=0;
   ms12.Position:=0;
   f_Main.CipherManager1.InitKey(LowerCase(f_Main.cbPhoneModel.Text),nil);
   if not des(f_Main.CipherManager1.EncodeString(inttostr(ord('F')+63)+'93466534dmkgjmdfjigdf7'+inttostr(6)+'7855645632456578sd543c'+'7B'),ms12,tfs2, need_card_using) then exit;
   ms12.Free;
   tfs2.Position:= 0;
   f_Main.ZipForge1.OpenArchive(tfs2,false);
   if onlyinf then
    begin
     f_Main.ZipForge1.ExtractToString('info',s);
     f_main.lblog.items.Strings[f_main.lbLog.Count-1]:=f_main.lblog.items.Strings[f_main.lbLog.Count-1]+(' Ok');
     f_main.put_to_log(s);
     f_Main.ZipForge1.CloseArchive;
     tfs2.Free;
     Result:= true;
     exit;
    end;
   tfs2.Position:= 0;
   ms1:= TMemoryStream.Create;
   f_Main.ZipForge1.ExtractToString(unzip,strng);
   f_Main.ZipForge1.CloseArchive;
   tfs2.Free;
   ms1.Free;
   Result:= true;
  except
   tfs.Free;
   f_main.lblog.items.Strings[f_main.lbLog.Count-1]:=f_main.lblog.items.Strings[f_main.lbLog.Count-1]+lang('ERROR');
  end;
end;


procedure str_to_stream(s:string; var stream:TMemoryStream);
var
  str_stream:tstringstream;
begin
  str_stream:=tstringstream.create(s);
  stream.loadfromstream(str_stream);
  str_stream.free;
  strng:='';
end;

procedure Code(var text: string; password: string; decode: boolean);
var
  i, PasswordLength: integer;
  sign: shortint;
begin
  {$I crypt_start.inc} AntiDebug; ProtectImport;
  PasswordLength := length(password);
  if decode then
   sign := -1
  else
   sign := 1;
  for i := 1 to Length(text) do
   begin
    if decode then
     text[i] := chr(ord(text[i]) xor length(text));
    text[i] := chr((ord(text[i]) + sign * ord(password[i mod PasswordLength + 1])) );
    if not decode then
     text[i] := chr(ord(text[i]) xor length(text));
   end;
   {$I crypt_end.inc}
end;

// des2 function with card using
function card_dec_string (data: string): string;
var
  f: string;
  l: integer;
begin
  {$I crypt_start.inc} AntiDebug; ProtectImport;
  Result:= '';
  f:= '69';
  Result:= send_card('00A40400087711223344005511');
  if Result <> card_command_ok then
   begin
    ShowMessage(lang('Card error!')+' (D1'+gethex(Result)+')');
    exit;
   end;
  Result:= getstr(data);
  l:= Length(Result);
  if l >= 256 then exit; //!!!
  code(Result,DecryptStr(seskey),false);
  send_card('55'+f+'0000'+inttohex(l,2)+gethex(Result));
  Result:= send_card('05C00000'+inttohex(l,2),false,true);
  code(Result,DecryptStr(seskey),true);
  {$I crypt_end.inc}
end;

end.
