unit u_repair_imei;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExControls, JvComponent, JvButton,
  JvTransparentButton;

type
  Tf_repair_imei = class(TForm)
    bCancel: TJvTransparentButton;
    bRepair: TJvTransparentButton;
    Label1: TLabel;
    MaskEdit1: TMaskEdit;
    procedure bRepairClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_repair_imei: Tf_repair_imei;

implementation

{$R *.dfm}
uses u_main, u_other;

procedure Tf_repair_imei.bRepairClick(Sender: TObject);
begin
ModalResult:=mrOk;
end;

procedure Tf_repair_imei.bCancelClick(Sender: TObject);
begin
ModalResult:=mrAbort;
end;

procedure Tf_repair_imei.FormShow(Sender: TObject);
begin
Caption:=lang('Repair IMEI');
bRepair.Caption:=lang('Repair');
bCancel.Caption:=lang('Cancel');
Label1.Caption:=lang('IMEI:');
end;

end.
