unit u_repair;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, JvExControls, JvComponent, JvButton,
  JvTransparentButton;

type
  Tf_repair = class(TForm)
    ComboBox1: TComboBox;
    Label1: TLabel;
    bRepair: TJvTransparentButton;
    bCancel: TJvTransparentButton;
    procedure FormShow(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure bRepairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_repair: Tf_repair;

implementation

uses u_main, u_other;

{$R *.dfm}

procedure Tf_repair.FormShow(Sender: TObject);
begin
Label1.Caption:=lang('Country(Unavailable Media File):');
bRepair.Caption:=lang('Repair');
bCancel.Caption:=lang('Cancel');
f_repair.Caption:=lang('Repair');
end;

procedure Tf_repair.bCancelClick(Sender: TObject);
begin
ModalResult:=mrAbort;
end;

procedure Tf_repair.bRepairClick(Sender: TObject);
begin
ModalResult:=mrOk;
end;

end.
