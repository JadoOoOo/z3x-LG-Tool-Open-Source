unit u_array_utils;

interface
uses windows,sysutils, qcrc;

function rep_res_byte(var buf:array of byte; len:integer):integer;
function del_res_byte(var buf:array of byte; start, len:integer):integer;

implementation

function rep_res_byte(var buf:array of byte; len:integer):integer;
var
  buf_tmp:array of byte;
  cur,i,buf_tmp_len:integer;
  cs:dword;
begin
  buf_tmp_len:=len*2+10;//if len=1 then +10
  setlength(buf_tmp,buf_tmp_len);//set buf size
  for i:=1 to 4 do
    buf_tmp[i]:=$7e;//cmd start
  cur:=5;//set cur byte
  cs:=CRC_16_L(@buf[0],len);//calc cs
  buf[len]:=lo(cs);//set lo cs
  buf[len+1]:=hi(cs);//set hi cs

  for i:=0 to len+1 do
    case buf[i] of
      $7e:
          begin
            buf_tmp[cur]:=$7D;
            buf_tmp[cur+1]:=$5E;
            inc(cur,2);
          end;
      $7d:
          begin
            buf_tmp[cur]:=$7D;
            buf_tmp[cur+1]:=$5D;
            inc(cur,2);
          end;
      else
          begin
            buf_tmp[cur]:=buf[i];
            inc(cur);
          end;
    end;
  buf_tmp[cur]:=$7E;//set end cmd
  CopyMemory(@buf[0],@buf_tmp[1],cur);//copy buf
  result:=cur;//return buf size
end;


function del_res_byte(var buf:array of byte; start, len:integer):integer;
var
  buf_tmp: array of byte;
  cur,i:integer;
begin

  setlength(buf_tmp,len*2);//set buf size
  cur:=1;//set cur byte
  i:=start-1;//set cur i
  while i<=(len-1) do
    begin
    if (buf[i]=$7D) and (buf[i+1]=$5D) then
        begin
        buf_tmp[cur]:=$7D;
        inc(i,2);
        end
    else  if (buf[i]=$7D) and (buf[i+1]=$5E) then
              begin
              buf_tmp[cur]:=$7E;
              inc(i,2);
              end
          else
              begin
              buf_tmp[cur]:=buf[i];
              inc(i);
              end;
    inc(cur);
    end;
  CopyMemory(@buf[0],@buf_tmp[1],cur-1);//copy buf
  result:=cur-1;//return buf size
end;


end.
