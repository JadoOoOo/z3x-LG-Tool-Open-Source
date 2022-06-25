unit u_unlock;

interface
uses windows,sysutils;

function unlock_ku311_and_other_file(var buf:array of byte; len:integer):boolean;

implementation

function unlock_ku311_and_other_file(var buf:array of byte; len:integer):boolean;
const
  lock_label:array [1..18]  of byte=($46,$4C,$45,$58,$5F,$43,$4F,$55,$4E,$54,$52,$59,$5F,$43,$4F,$44,$45,$3D);
var
  cur:integer;
begin
  result:=false;
  cur:=0;
  while cur<len-1 do
    begin
      if CompareMem(@lock_label[1],@buf[cur],18) then
        begin
          buf[cur+18]:=$58;
          buf[cur+18+1]:=$58;
          buf[cur+18+2]:=$58;
          result:=true;
          break;
        end;
      inc(cur);
    end;
end;

end.
