unit u_cryptor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZipForge, HCMngr,PCSCConnector, crc16,
  ComCtrls, XPMan, Mask, JvExMask, JvToolEdit;

type
  rec = record
   data: array [1..20000] of char;
  end;
  rec30 = record
   data: array [1..30000] of char;
  end;
  rec35 = record
   data: array [1..35000] of char;
  end;
  TfConverter = class(TForm)
    OpenDialog1: TOpenDialog;
    CipherManager2: TCipherManager;
    ZipForge1: TZipForge;
    SaveDialog1: TSaveDialog;
    Label3: TLabel;
    cbModel: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Label8: TLabel;
    b1create: TButton;
    i1info: TMemo;
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    StatusBar1: TStatusBar;
    f1modem: TJvFilenameEdit;
    f1media: TJvFilenameEdit;
    f1module: TJvFilenameEdit;
    f1modhead: TJvFilenameEdit;
    f1part: TJvFilenameEdit;
    f1bootlogo: TJvFilenameEdit;
    f1pbl: TJvFilenameEdit;
    f1oemsbl: TJvFilenameEdit;
    f1oemsblhd: TJvFilenameEdit;
    f1qcsbl: TJvFilenameEdit;
    f1qcsblhd: TJvFilenameEdit;
    procedure cbModelChange(Sender: TObject);
    procedure b1createClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  card_command_ok = chr($90)+chr($00);
  card_fishMD_say_ky = 'fishMD say KY!!';
  card_fucking_java = 'FUCKING JAVA!!!';
  card_mk_noname = 'MK AND NONAME - GOOD BOYS ;)';
  card_zxxx_ok = chr($62)+chr($00);
  ch0: char = chr(0);

var
  fConverter: TfConverter;
  rec_file: file of rec;
  rec_val: rec;
  rec_file30: file of rec30;
  rec_val30: rec30;
  rec_file35: file of rec35;
  rec_val35: rec35;
  boxx: array[byte] of byte;
  card_sn: string;

implementation

uses u_main;

{$R *.dfm}

function getstr(s: string) : string;
var
  i: integer;
begin
  Result:='';
  for i:=1 to Length(s) do
   if i mod 2 = 0 then
    Result:= Result+chr(strtoint('$'+s[i-1]+s[i]));
end;

function gethex(s: string) : string;
var
  i: integer;
begin
  Result:='';
  for i:=1 to Length(s) do
   Result:= Result+inttohex(ord(s[i]), 2);
end;

function send_card(s: string; ashex: Boolean = false; withoutstatus: Boolean = false): string;
begin
  result:= f_main.card.GetResponseFromCard(getstr(s));
  if withoutstatus then
   if Length(Result) >=2 then
    Delete(Result,length(Result)-1,2);
  if ashex then result:=gethex(Result);
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

  {
  if not IsAppProtected then
   ShowMessage(fMain.lang('Protection error!'));
  //}
  Result:= false;
  data_length := data.Size;
  out_data.Size:= data.size;

  if need_des then
   begin

    ans:= send_card('00A40400087711223344005511');
    if ans <> card_command_ok then
     begin
      ShowMessage('Card error! (D1'+gethex(ans)+')');
      exit;
     end;

    tocard:= '55620000'+IntToHex(length(pwd),2);
    for i:=1 to length(pwd) do
     tocard:= tocard+inttohex(ord(pwd[i]),2);

    ans:= send_card(tocard);

    if ans <> card_command_ok then
     begin
      ShowMessage('Card error! (D2'+gethex(ans)+')');
      exit;
     end;

    fromcard:= send_card('55630000FF',false,true);

    if length(fromcard) <> 255 then
     begin
      //ShowMessage(gethex(fromcard));
      ShowMessage('Card error! (D3'+IntToStr(length(fromcard))+')');
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

function fcs16(s: string; need_xor_ffff: Boolean = true): string;
const PPPINITFCS16:word   =$ffff;
const PPPGOODFCS16:word   =$f0b8;
var trialfcs:word;
    cp:pointer;
    len:integer;
begin
  cp := @s[1];
  len:= length(s);
  trialfcs:=pppfcs16(PPPINITFCS16,cp,len);
  if need_xor_ffff then
   trialfcs:=trialfcs xor $FFFF;
  result:= IntToHex(trialfcs,4)[3]+IntToHex(trialfcs,4)[4]+IntToHex(trialfcs,4)[1]+IntToHex(trialfcs,4)[2];
end;

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

function ReadMyFile(infile: string): string;
var
  ms: TFileStream;
begin
  ms:= TFileStream.Create(infile,fmOpenRead);
  SetLength(result, ms.Size);
  ms.Read(result[1], ms.Size);
  ms.Free;
end;

function rev(size, dig: integer; need: Boolean=true; defsize: integer = 1024; incs: integer = 0): string;
var
  s: string;
  i, t: integer;
begin
  Result:='';
  if need then
   begin
    t:= ((size div defsize)+1)*defsize;
    t:=t+incs;
    s:= IntToHex(t,dig);
   end
  else
    s:= IntToHex(size,dig);
  for i:=length(s) downto 1 do
   if i mod 2 = 0 then
    result:= result+s[i-1]+s[i];
  result:= StringReplace(result,0,0);
end;

function sw(ss: string; from: integer = 3): string;
var
  ps, f: string;
  i: integer;
begin
  ps:='';
  for i:=from to pos('%',ss)-1 do ps:= ps+ss[i];
  f:= StringReplace(getstr(fcs16(getstr(ps), true)),0,0);
  result:= getstr(Format(ss,[gethex(f)]));
end;

function to_rec(infile, outfile: string; n: Boolean=true; from_a: string=''; tword: string = 'DD'; chch: Boolean = true; block: integer = 16384; first: string = ''; erase2: boolean = false): Boolean;
label sendagain;
var
  i, i2, b_pos, q: integer;
  fc, sb, ah, st2, st, st3, sss, ad: string;
begin
  Assign(rec_file,outfile);
  Rewrite(rec_file);
  SetLength(st2, block);
  SetLength(st3, block);
  b_pos:= StrToInt(from_a);
  Result:= false;
  sb:='';
  for i2:= 1 to block do st3[i2]:= chr(255);
  for i:= 1 to block do st2[i]:= chr(255);
  i2:=0;
  st:= ReadMyFile(infile);
  if first <> '' then
   begin
    sss:= sw('7E00'+first+rev(StrToInt(from_a),8,false)+rev(length(st)-1,8, true, block, 0)+'%s7E',5);
    for q:= 1 to Length(sss) do
     rec_val.data[q]:= sss[q];
     Write(rec_file,rec_val);
     for q:= 1 to 20000 do
      rec_val.data[q]:= ch0;
   end;
  if erase2 then
   begin
    sss:= sw('7E00F0'+rev(StrToInt(from_a),8,false)+rev(length(st)-1,8, true, block, 0)+'%s7E',5);
    for q:= 1 to Length(sss) do
     rec_val.data[q]:= sss[q];
     Write(rec_file,rec_val);
     for q:= 1 to 20000 do
      rec_val.data[q]:= ch0;
   end;
  //fMain.MPHexEditor1.LoadFromFile(infile);
  //st:= fMain.MPHexEditor1.AsText;
  //ShowMessage(st);
  fConverter.ProgressBar1.Position:=0;
  fConverter.ProgressBar1.Max := length(st) div block;
  for i:= 1 to length(st) do
   begin
    //fMain.Caption:= IntToStr(i);
    inc(i2);
    st2[i2]:= st[i];
    if (i mod block = 0) or (i = Length(st))  then
     begin
      fc:= getstr(fcs16(getstr(tword+rev(b_pos,8,false)+'0040')+st2));
      ah:= StringReplace(st2,0,0);
      if chch then
       fc:= StringReplace(fc,0,0);
      ad:= gethex(StringReplace(getstr(rev(b_pos,8,false)),0,0));
      sb:= getstr('7E00'+tword+ad+'0040'+gethex(ah+fc)+'7E');

      //ShowMessage(ah);
      //ShowMessage(fc);
      //ShowMessage(gethex(sb));
      for q:= 1 to Length(sb) do
        rec_val.data[q]:= sb[q];
      //rec_val.data:= sb;
      Write(rec_file,rec_val);
      for q:= 1 to 20000 do
       rec_val.data[q]:= ch0;
      sb:='';
      //for i2:= 1 to block do st2[i2]:= chr(255);
      st2:= st3;
      fConverter.ProgressBar1.Position:= fConverter.ProgressBar1.Position +1;
      //fMain.Caption:= IntToStr(i);
      //Application.ProcessMessages;
      b_pos:= b_pos+block;
      i2:= 0;
     end;
   end;
  CloseFile(rec_file);
end;

function to_rec30(infile, outfile: string; n: Boolean=true; from_a: string=''; tword: string = 'DD'; chch: Boolean = true; block: integer = 16384; first: string = ''; inblock: string=''): Boolean;
label sendagain;
var
  i, i2, b_pos,q: integer;
  fc, sb, ah, st2, st, st3, sss, ad: string;
begin
  Assign(rec_file30,outfile);
  Rewrite(rec_file30);
  SetLength(st2, block);
  SetLength(st3, block);
  b_pos:= StrToInt(from_a);
  Result:= false;
  sb:='';
  for i2:= 1 to block do st3[i2]:= chr(255);
  for i:= 1 to block do st2[i]:= chr(255);
  i2:=0;
  st:= ReadMyFile(infile);
  if first <> '' then
   begin
    sss:= sw('7E00'+first+rev(StrToInt(from_a),8,false)+rev(length(st)-1,8, true, block, 0)+'%s7E',5);
    for q:= 1 to Length(sss) do
     rec_val30.data[q]:= sss[q];
     Write(rec_file30,rec_val30);
     for q:= 1 to 30000 do
      rec_val30.data[q]:= ch0;
   end;
  fConverter.ProgressBar1.Position:=0;
  fConverter.ProgressBar1.Max := length(st) div block;
  for i:= 1 to length(st) do
   begin
    inc(i2);
    st2[i2]:= st[i];
    if (i mod block = 0) or (i = Length(st))  then
     begin
      fc:= getstr(fcs16(getstr(tword+rev(b_pos,8,false)+'0040'+inblock)+st2));
      ah:= StringReplace(st2,0,0);
      if chch then
       fc:= StringReplace(fc,0,0);
      ad:= gethex(StringReplace(getstr(rev(b_pos,8,false)),0,0));
      sb:= getstr('7E00'+tword+ad+'0040'+inblock+gethex(ah+fc)+'7E');

      for q:= 1 to Length(sb) do
        rec_val30.data[q]:= sb[q];
      Write(rec_file30,rec_val30);
      for q:= 1 to 30000 do
       rec_val30.data[q]:= ch0;
      sb:='';
      st2:= st3;
      fConverter.ProgressBar1.Position:= fConverter.ProgressBar1.Position +1;
      b_pos:= b_pos+block;
      i2:= 0;
     end;
   end;
  CloseFile(rec_file30);
end;

function to_rec35(infile, outfile: string; n: Boolean=true; from_a: string=''; tword: string = 'DD'; chch: Boolean = true; block: integer = 16384; first: string = ''; inblock: string=''; erase2: boolean = false): Boolean;
label sendagain;
var
  i, i2, b_pos, q: integer;
  fc, sb, ah, st2, st, st3, sss, ad: string;
begin
  Assign(rec_file35,outfile);
  Rewrite(rec_file35);
  SetLength(st2, block);
  SetLength(st3, block);
  b_pos:= StrToInt(from_a);
  Result:= false;
  sb:='';
  for i2:= 1 to block do st3[i2]:= chr(255);
  for i:= 1 to block do st2[i]:= chr(255);
  i2:=0;
  st:= ReadMyFile(infile);
  if first <> '' then
   begin
    sss:= sw('7E00'+first+rev(StrToInt(from_a),8,false)+rev(length(st)-1,8, true, block, 0)+'%s7E',5);
    if erase2 then
     sss:= sss+sw('7E00F0'+rev(StrToInt(from_a),8,false)+rev(length(st)-1,8, true, block, 0)+'%s7E',5);
    for q:= 1 to Length(sss) do
     rec_val35.data[q]:= sss[q];
     Write(rec_file35,rec_val35);
     for q:= 1 to 35000 do
      rec_val35.data[q]:= ch0;
   end;
  
  fConverter.ProgressBar1.Position:=0;
  fConverter.ProgressBar1.Max := length(st) div block;
  for i:= 1 to length(st) do
   begin
    inc(i2);
    st2[i2]:= st[i];
    if (i mod block = 0) or (i = Length(st))  then
     begin
      fc:= getstr(fcs16(getstr(tword+rev(b_pos,8,false)+'0040'+inblock)+st2));
      ah:= StringReplace(st2,0,0);
      if chch then
       fc:= StringReplace(fc,0,0);
      ad:= gethex(StringReplace(getstr(rev(b_pos,8,false)),0,0));
      sb:= getstr('7E00'+tword+ad+'0040'+inblock+gethex(ah+fc)+'7E');
      MoveMemory(@rec_val35.data[1],@sb[1],Length(sb));
      {for q:= 1 to Length(sb) do
        rec_val35.data[q]:= sb[q]; }
      Write(rec_file35,rec_val35);
      ZeroMemory(@rec_val35.data[1], 35000 * SizeOf(rec_val35.data[1]));
      sb:='';
      st2:= st3;
      fConverter.ProgressBar1.Position:= fConverter.ProgressBar1.Position +1;
      b_pos:= b_pos+block;
      i2:= 0;
     end;
   end;
  CloseFile(rec_file35);
end;

procedure TfConverter.cbModelChange(Sender: TObject);
begin
  f1modem.Text:='';
  f1media.Text:='';
  f1module.Text:='';
  f1modhead.Text:='';
  f1part.Text:='';
  f1bootlogo.Text:='';
  f1pbl.Text:='';
  f1oemsbl.Text:='';
  f1oemsblhd.Text:='';
  f1qcsbl.Text:='';
  f1qcsblhd.Text:='';
  i1info.Clear;
end;

procedure TfConverter.FormShow(Sender: TObject);
begin
cbModel.Items:=f_main.cbPhoneModel.Items;
     with ProgressBar1 do
          begin
               Parent:=StatusBar1;
               Width:=StatusBar1.Width-8;
               Top:=4;
               Height:=StatusBar1.Height-6;
               Left:=3;
          end;
end;

procedure TfConverter.b1createClick(Sender: TObject);
label skip;
var
  so, de: TFileStream;
  t: TTime;
  i: integer;
  cmodel: string;
begin
  cmodel:= cbModel.Text;

  if cbModel.ItemIndex = -1 then exit;
  SaveDialog1.FileName:= cmodel+'.crp';
  if not SaveDialog1.Execute then exit;
  t:=now;
  ProgressBar1.Max:=4;
  ProgressBar1.Position:=1;
  ZipForge1.FileName:= SaveDialog1.FileName+'p';
  ZipForge1.OpenArchive(fmCreate);

  for i:=0 to i1info.Lines.Count-1 do
   i1info.Lines.Strings[i]:= '  '+i1info.Lines.Strings[i];
  i1info.Lines.SaveToFile(ExtractFilePath(SaveDialog1.FileName)+'info');

  ZipForge1.BaseDir:= ExtractFileDir(f1modem.Text);
  if FileExists(f1modem.Text) then
   begin
    ZipForge1.AddFiles(f1modem.Text);
    ZipForge1.RenameFile(ExtractFileName(f1modem.Text),'modem');
   end;
  ZipForge1.BaseDir:= ExtractFileDir(f1media.Text);
  if FileExists(f1media.Text) then
   begin
    ZipForge1.AddFiles(f1media.Text);
    ZipForge1.RenameFile(ExtractFileName(f1media.Text),'media');
   end;
  ZipForge1.BaseDir:= ExtractFileDir(f1module.Text);
  if FileExists(f1module.Text) then
   begin
    ZipForge1.AddFiles(f1module.Text);
    ZipForge1.RenameFile(ExtractFileName(f1module.Text),'module');
   end;
  ZipForge1.BaseDir:= ExtractFileDir(f1modhead.Text);
  if FileExists(f1modhead.Text) then
   begin
    ZipForge1.AddFiles(f1modhead.Text);
    ZipForge1.RenameFile(ExtractFileName(f1modhead.Text),'modhead');
   end;
  ZipForge1.BaseDir:= ExtractFileDir(f1part.Text);
  if FileExists(f1part.Text) then
   begin
    ZipForge1.AddFiles(f1part.Text);
    ZipForge1.RenameFile(ExtractFileName(f1part.Text),'part');
   end;

//start adding new file 18/11/2008 andrew_tm
  ZipForge1.BaseDir:= ExtractFileDir(f1bootlogo.Text);
  if FileExists(f1bootlogo.Text) then
   begin
    ZipForge1.AddFiles(f1bootlogo.Text);
    ZipForge1.RenameFile(ExtractFileName(f1bootlogo.Text),'bootlogo');
   end;

  ZipForge1.BaseDir:= ExtractFileDir(f1oemsbl.Text);
  if FileExists(f1oemsbl.Text) then
   begin
    ZipForge1.AddFiles(f1oemsbl.Text);
    ZipForge1.RenameFile(ExtractFileName(f1oemsbl.Text),'oemsbl');
   end;

  ZipForge1.BaseDir:= ExtractFileDir(f1oemsblhd.Text);
  if FileExists(f1oemsblhd.Text) then
   begin
    ZipForge1.AddFiles(f1oemsblhd.Text);
    ZipForge1.RenameFile(ExtractFileName(f1oemsblhd.Text),'oemsblhd');
   end;

  ZipForge1.BaseDir:= ExtractFileDir(f1pbl.Text);
  if FileExists(f1pbl.Text) then
   begin
    ZipForge1.AddFiles(f1pbl.Text);
    ZipForge1.RenameFile(ExtractFileName(f1pbl.Text),'pbl');
   end;

  ZipForge1.BaseDir:= ExtractFileDir(f1qcsbl.Text);
  if FileExists(f1qcsbl.Text) then
   begin
    ZipForge1.AddFiles(f1qcsbl.Text);
    ZipForge1.RenameFile(ExtractFileName(f1qcsbl.Text),'qcsbl');
   end;

  ZipForge1.BaseDir:= ExtractFileDir(f1qcsblhd.Text);
  if FileExists(f1qcsblhd.Text) then
   begin
    ZipForge1.AddFiles(f1qcsblhd.Text);
    ZipForge1.RenameFile(ExtractFileName(f1qcsblhd.Text),'qcsblhd');
   end;
//end adding new file 18/11/2008 andrew_tm

  skip:
  ZipForge1.BaseDir:= ExtractFileDir(ExtractFilePath(SaveDialog1.FileName));
  ZipForge1.AddFiles(ExtractFilePath(SaveDialog1.FileName)+'info');
  ZipForge1.CloseArchive;
  so:= TFileStream.Create(SaveDialog1.FileName+'p', fmOpenRead);
  de:= TFileStream.Create(SaveDialog1.FileName+'pp', fmCreate);
  CipherManager2.InitKey(LowerCase(cbModel.Text),nil);
  ProgressBar1.Position:=2;
  des(CipherManager2.EncodeString(inttostr(ord('F')+63)+'93466534dmkgjmdfjigdf7'+inttostr(6)+'7855645632456578sd543c'+'7B'),so,de,true);
  so.Free;
  de.Free;
  ProgressBar1.Position:=3;
  CipherManager2.InitKey(inttostr(ord('l')+83)+'934665345356ewqe345677'+inttostr(0)+'7855645hfgh6578b543c'+'7E',nil);
  CipherManager2.EncodeFile(SaveDialog1.FileName+'pp', SaveDialog1.FileName);
  if ParamStr(1) <> 'dev' then
   begin
    DeleteFile(SaveDialog1.FileName+'pp');
    DeleteFile(SaveDialog1.FileName+'p');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'info');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'modem');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'media');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'module');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'modhead');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'part');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'f1bootlogo');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'f1oemsbl');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'f1oemsblhd');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'f1pbl');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'f1qcsbl');
    DeleteFile(ExtractFilePath(SaveDialog1.FileName)+'f1qcsblhd');
   end;
  ShowMessage('Done, time - '+timetostr(now-t)+'!'+#13+'Saved to '+SaveDialog1.FileName);
  ProgressBar1.Position:=4;
end;


end.
