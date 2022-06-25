unit u_select_modem_port;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvComponent, JvButton,
  JvTransparentButton, ExtCtrls;

type
  Tf_select_modem_port = class(TForm)
    bRepair: TJvTransparentButton;
    bCancel: TJvTransparentButton;
    Label1: TLabel;
    cbPortList: TComboBox;
    Timer1: TTimer;
    procedure bCancelClick(Sender: TObject);
    procedure bRepairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  procedure init_port;
  public
    { Public declarations }
  end;

var
  f_select_modem_port: Tf_select_modem_port;

implementation

{$R *.dfm}

uses
Registry, u_main, u_other;

procedure Tf_select_modem_port.init_port;
var
  reg: TRegistry;
  i: integer;
begin
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('hardware\devicemap\serialcomm', false);
  for i:=99 downto 0 do
      if reg.ValueExists('\Device\LGSIMDM'+inttostr(i)) then
            cbPortList.Items.Add(reg.ReadString('\Device\LGSIMDM'+inttostr(i)));
  reg.CloseKey;
  reg.free;
  f_main.sort_combo_box(cbPortList);
end;

procedure Tf_select_modem_port.bCancelClick(Sender: TObject);
begin
ModalResult:=mrAbort;
end;

procedure Tf_select_modem_port.bRepairClick(Sender: TObject);
begin
ModalResult:=mrOk;
end;

procedure Tf_select_modem_port.FormShow(Sender: TObject);
begin
    Caption:=lang('Port Select');
    bRepair.Caption:=lang('Ok');
    bCancel.Caption:=lang('Cancel');
    Label1.Caption:=lang('Port:');
    init_port;
    if cbPortList.Items.Count=1 then
        cbPortList.ItemIndex:=0;
    timer1.enabled:=true;
end;

procedure Tf_select_modem_port.Timer1Timer(Sender: TObject);
begin
if cbPortList.Items.Count=1 then
    ModalResult:=mrOk;
end;

procedure Tf_select_modem_port.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
    timer1.enabled:=false;
end;

end.
