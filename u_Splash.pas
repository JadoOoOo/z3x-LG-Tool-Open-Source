unit u_splash;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, jpeg;

type
  Tf_splash = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    procedure labeltext(text: string; mode: byte = 0);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_splash: Tf_splash;

implementation

{$R *.dfm}

procedure Tf_splash.labeltext(text: string; mode: byte = 0);
var
  w: integer;
begin
  case mode of
   0: begin
     Label1.Font.Color:= clBlack;
     Label1.Font.Style:= [];
     w:= 500;
   end;
   1: begin
     text:='Warning: '+text;
     Label1.Font.Color:= clMaroon;
     Label1.Font.Style:= [];
     w:= 1000;
   end;
   2: begin
     text:='ERROR: '+text;
     Label1.Font.Color:= clRed;
     Label1.Font.Style:= [fsBold];
     w:= 2000;
   end;
  end;
  
  Label1.Caption:= text;
  f_splash.Update;
  Sleep(w);
  if mode = 2 then halt;
end;

end.
