unit u_login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, JvExControls, JvButton, JvTransparentButton, u_other, ShellAPI;

type
  Tf_login = class(TForm)
    bCancel: TJvTransparentButton;
    bRepair: TJvTransparentButton;
    Edit1: TEdit;
    MaskEdit1: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    Label3: TLabel;
    Label4: TLabel;
    procedure bRepairClick(Sender: TObject);
    procedure bCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  f_login: Tf_login;

implementation

uses
    Registry;
{$R *.dfm}

procedure Tf_login.bCancelClick(Sender: TObject);
begin
    ModalResult:=mrCancel;
end;

procedure Tf_login.bRepairClick(Sender: TObject);
var
  reg: TRegistry;
begin
  reg := TRegistry.Create;
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\FMD\lgq',true);
    if CheckBox1.Checked then
        begin
            reg.WriteBool('AutoSave',true);
            reg.WriteString('par1',Edit1.Text);
            reg.WriteString('par2',MaskEdit1.Text);
        end
    else
        begin
            reg.WriteBool('AutoSave',false);
            reg.WriteString('par1','');
            reg.WriteString('par2','');
        end;
    ModalResult:=mrOk;
end;

procedure Tf_login.FormShow(Sender: TObject);
var
    reg: TRegistry;
begin
    Label1.Caption:=lang('Login:');
    Label2.Caption:=lang('Password:');
    Label4.Caption:=lang('For buy credits:');
    CheckBox1.Caption:=lang('Save login && password');
    bRepair.Caption:=lang('Ok');
    bCancel.Caption:=lang('Cancel');

    reg := TRegistry.Create;
    reg.RootKey := HKEY_LOCAL_MACHINE;
    reg.OpenKey('SOFTWARE\FMD\lgq',true);
    if reg.ValueExists('AutoSave') then
        CheckBox1.Checked:=reg.ReadBool('AutoSave');
    if (CheckBox1.Checked) and (reg.ValueExists('par1')) then
        Edit1.Text:=reg.ReadString('par1');
    if (CheckBox1.Checked) and (reg.ValueExists('par2')) then
        MaskEdit1.Text:=reg.ReadString('par2');
end;

procedure Tf_login.Label3Click(Sender: TObject);
begin
    ShellExecute(self.Handle,nil,'http://forum.z3x-team.com/',nil, nil,SW_SHOWNORMAL);
end;

end.
