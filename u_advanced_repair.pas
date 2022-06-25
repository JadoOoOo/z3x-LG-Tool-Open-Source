unit u_advanced_repair;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExControls, JvComponent, JvButton,
  JvTransparentButton;

type
  Tf_advanced_repair = class(TForm)
    cbWriteNVM: TCheckBox;
    cbRepairIMEI: TCheckBox;
    MaskEdit1: TMaskEdit;
    cbRepairBT: TCheckBox;
    bRepair: TJvTransparentButton;
    bCancel: TJvTransparentButton;
    lComPort: TLabel;
    cbPortList: TComboBox;
    lbKS20repairmanual: TLabel;
    lbKS20repairphoto: TLabel;
    procedure bRepairClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbRepairIMEIClick(Sender: TObject);
    procedure cbWriteNVMClick(Sender: TObject);
    procedure lbKS20repairmanualClick(Sender: TObject);
    procedure lbKS20repairphotoClick(Sender: TObject);
  private
     procedure init_port;
  public
    { Public declarations }
  end;

var
  f_advanced_repair: Tf_advanced_repair;

implementation

{$R *.dfm}
uses
     Registry, u_main, u_other, shellapi;

procedure Tf_advanced_repair.init_port;
var
  reg: TRegistry;
  st: TStrings;
  i,x: integer;
  not_dubl:boolean;
begin
  not_dubl:=false;
  cbPortList.Clear;
  reg := TRegistry.Create;
  reg.RootKey := HKEY_LOCAL_MACHINE;
  reg.OpenKey('hardware\devicemap\serialcomm', false);
  st := TStringList.Create;
  reg.GetValueNames(st);
  for i := 0 to st.Count - 1 do
    begin
      for x:=0 to cbPortList.Items.Count-1 do
        if cbPortList.Items.Strings[x]=reg.ReadString(st.Strings[i]) then
          begin
            not_dubl:=true;
            break;
          end;
      if not not_dubl then
        cbPortList.items.Add(reg.ReadString(st.Strings[i]));
    end;
  f_main.sort_combo_box(cbPortList);
  st.Free;
  reg.CloseKey;
  reg.free;
end;

procedure Tf_advanced_repair.bRepairClick(Sender: TObject);
begin
ModalResult:=mrOk;
end;

procedure Tf_advanced_repair.bCancelClick(Sender: TObject);
begin
     ModalResult:=mrAbort;
end;

procedure Tf_advanced_repair.FormShow(Sender: TObject);
begin
     init_port;
     lComPort.caption:=lang('Port:');
     cbWriteNVM.caption:=lang('Write NVM');
     cbRepairIMEI.caption:=lang('Repair IMEI');
     cbRepairBT.caption:=lang('Repair BT address');
     bRepair.caption:=lang('Repair');
     bCancel.caption:=lang('Cancel');
     lbKS20repairphoto.caption:=lang('KS20 repair photo');
     lbKS20repairmanual.caption:=lang('KS20 repair manual');
end;

procedure Tf_advanced_repair.cbRepairIMEIClick(Sender: TObject);
begin
     MaskEdit1.enabled:=cbRepairIMEI.checked;
end;

procedure Tf_advanced_repair.cbWriteNVMClick(Sender: TObject);
begin
if cbWriteNVM.checked then
     begin
               f_main.OpenDialog1.FileName:='';
               f_main.OpenDialog1.Filter:='Crypted NVM(*.cnv)|*.cnv';
               if f_main.OpenDialog1.Execute then
                    f_main.eNvmFile.Text:=f_main.OpenDialog1.FileName
               else
                    cbWriteNVM.checked:=false;
     end;
end;

procedure Tf_advanced_repair.lbKS20repairmanualClick(Sender: TObject);
begin
     MessageBox(WindowHandle,pchar(
     lang('1.Solder Rx, Tx, Gnd.')
     +#13+lang('2.Connect phone to unibox(ftdi, pl2303,etc...), and select this port in repair window.')
     +#13+lang('3.Type 2676625720#->Port Setting->Diag Setting->UART Set for Diag->Press Ok.')
     +#13+lang('4.Type 2676625720#->Port Setting->USB Switching->LG Composite DIAG->Press Ok.')
     +#13+lang('5.Reboot phone.')
     +#13+lang('6.Press Ok and start repair.')
     ),pchar(lang('Advanced Repair')),MB_OK+MB_ICONINFORMATION);
end;

procedure Tf_advanced_repair.lbKS20repairphotoClick(Sender: TObject);
begin
        if FileExists(ExtractFilePath(Application.ExeName)+'repair_photo\ks20_repair.jpg') then
             ShellExecute(self.Handle,nil,pchar(ExtractFilePath(Application.ExeName)+'repair_photo\ks20_repair.jpg'),nil, nil,SW_SHOWNORMAL)
        else
            ShowMessage(lang('File not exist, reinstall programm!'));
end;

end.
