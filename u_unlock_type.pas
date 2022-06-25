unit u_unlock_type;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, u_other;

type
  Tf_unlock_type = class(TForm)
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_unlock_type: Tf_unlock_type;

implementation

{$R *.dfm}

procedure Tf_unlock_type.FormShow(Sender: TObject);
begin
    RadioButton1.Caption:=lang('Old algoritm');
    RadioButton2.Caption:=lang('New algoritm');
    RadioButton3.Caption:=lang('New algoritm - restore from backup');
    RadioButton4.Caption:=lang('New algoritm - show supported version list');
    Button1.Caption:=lang('Ok');
    Button2.Caption:=lang('Cancel');
end;

end.
