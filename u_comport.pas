unit u_comport;

interface
uses
    Classes, Windows, Graphics, Sysutils;

var
    lastbaudrate:integer;
    ComName:String;
    ComFile:THandle;
    portmode:byte;
    readevent,writeevent:THandle;
    readTO,writeTO:cardinal;

    function OpenPort():boolean;
    function ReadPort(var buf; size:Cardinal):Cardinal;
    function ReadPort_some_times(var a:array of byte; size,times,slp:Cardinal):Cardinal;
    function ReadByte:byte;
    function Readword:Word;
    function ReadDword:cardinal;
    function GetPortBufLen:integer;
    procedure WritePort(const buf; size:Cardinal);
    procedure WriteByte(a:byte);
    procedure WriteWord(a:word);
    procedure WriteDword(a:cardinal);
    procedure SetTimeouts(RI,RM,RC,WM,WC:Cardinal);
    procedure setbaudrate(BaudRate:cardinal);
    procedure SetDCB(BaudRate:cardinal; XonLim,XoffLim:word; XonChar,XoffChar:Ansichar; StopBits:byte=0; Parity:byte=NOPARITY);
    procedure ClosePort;

implementation


function OpenPort():boolean;
var
    p:pchar;
    flags:cardinal;
begin
    lastbaudrate:=115200;
    if (length(ComName)>0) and (ComName[1]<>'\') then
        p:=PChar('\\.\'+ComName) else p:=PChar(ComName);
    flags:=0;
    ComFile:=CreateFile(p,GENERIC_READ or GENERIC_WRITE,0,nil,OPEN_EXISTING,flags,0);
    setTimeouts(0,200,0,0,0);
    result:=(ComFile<>INVALID_HANDLE_VALUE);
end;

procedure WritePort(const buf; size:Cardinal);
var
    abp:cardinal;
begin
    WriteFile(ComFile,buf,size,abp,nil);
end;

function ReadPort(var buf; size:Cardinal):Cardinal;
begin
    ReadFile(ComFile,buf,size,result,nil);
end;

function ReadPort_some_times(var a:array of byte; size,times,slp:Cardinal):Cardinal;
var
    i, abp, pos:cardinal;
begin
    i:=0; {a:=@buf; }pos:=0;
    repeat
        abp:=ReadPort(a[pos],size-pos);
        pos:=pos+abp;
        if (abp<>size) then
            sleep(slp);
    until (i>times)or(abp>=size);
    result:=pos;
end;

procedure WriteByte(a:byte);
begin
    WritePort(a,1);
end;

procedure WriteWord(a:word);
begin
    WritePort(a,2);
end;

procedure WriteDWord(a:cardinal);
begin
    WritePort(a,4);
end;

function ReadByte:byte;
begin
    if ReadPort(result,1)<>1 then
        result:=0;
end;

function Readword:Word;
begin
    if ReadPort(result,2)<>2 then
        result:=0;
end;

function ReadDword:cardinal;
begin
    if ReadPort(result,4)<>4 then
        result:=0;
end;

procedure SetTimeouts(RI,RM,RC,WM,WC:Cardinal);
var
    timeouts:TCommTimeouts;
begin
//  GetCommTimeouts(comfile,timeouts);
    timeouts.ReadIntervalTimeout:=RI;
    timeouts.ReadTotalTimeoutMultiplier:=RM;
    timeouts.ReadTotalTimeoutConstant:=RC;
    timeouts.WriteTotalTimeoutMultiplier:=WM;
    timeouts.WriteTotalTimeoutConstant:=WC;
    SetCommTimeouts(comfile,timeouts);
    readTO:=RC;
    writeTO:=WC;
end;

procedure setbaudrate(BaudRate:cardinal);
var
    DCB:TDCB;
begin
    GetCommState(ComFile,DCB);
    dcb.BaudRate:=BaudRate;
    SetCommState(comfile,DCB);
end;

procedure SetDCB(BaudRate:cardinal; XonLim,XoffLim:word; XonChar,XoffChar:Ansichar; StopBits:byte=0; Parity:byte=NOPARITY);
var
    DCB:TDCB;
begin
    GetCommState(ComFile,DCB);
    dcb.BaudRate:=BaudRate;
    dcb.XonLim:=XonLim;
    dcb.XoffLim:=XoffLim;
    dcb.XonChar:=XonChar;
    dcb.XoffChar:=XoffChar;

    DCB.Parity   := Parity;
    DCB.ByteSize := $08;
    DCB.StopBits := StopBits;
    SetCommState(comfile,DCB);
end;

procedure ClosePort;
begin
    CloseHandle(ComFile);
end;

function GetPortBufLen:integer;
var
    lpErrors:DWORD;
    Stat:TComStat;
begin
    ClearCommError(comfile,lpErrors,@Stat);
    result:=Stat.cbInQue;
end;

end.
