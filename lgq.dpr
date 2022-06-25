program lgq;

uses
  Forms,
  u_main in 'u_main.pas' {f_main},
  nv_tables in 'nv_tables.pas',
  u_unlock in 'u_unlock.pas',
  u_array_utils in 'u_array_utils.pas',
  u_previnst in 'u_previnst.pas',
  u_repair in 'u_repair.pas' {f_repair},
  u_Splash in 'u_Splash.pas' {f_splash},
  u_other in 'u_other.pas',
  u_repair_imei in 'u_repair_imei.pas' {f_repair_imei},
  u_select_modem_port in 'u_select_modem_port.pas' {f_select_modem_port},
  EXECryptor in 'EXECryptor.pas',
  u_advanced_repair in 'u_advanced_repair.pas' {f_advanced_repair},
  u_cryptor in 'u_cryptor.pas' {fConverter},
  u_aes_utils in 'u_aes_utils.pas',
  u_unlock_type in 'u_unlock_type.pas' {f_unlock_type},
  u_login in 'u_login.pas' {f_login},
  FGIntRSA in 'E:\soft\Miranda\incoming\Andrew-418016710\DUMMY\MODULES\LGQ_MODELS\FGIntRSA.pas',
  FGInt in 'E:\soft\Miranda\incoming\Andrew-418016710\DUMMY\MODULES\LGQ_MODELS\FGInt.pas',
  FGIntPrimeGeneration in 'E:\soft\Miranda\incoming\Andrew-418016710\DUMMY\MODULES\LGQ_MODELS\FGIntPrimeGeneration.pas',
  u_comport in 'u_comport.pas';

{$R *.res}
const
  UniqueString = 'LGQ_ST';

begin
    if not init_mutex(UniqueString) then
      exit;

  Application.Initialize;
  Application.Title := 'LGQ UMTS Tool';
  f_splash := tf_splash.create(nil);
  f_splash.show;
  f_splash.update;
  Application.CreateForm(Tf_main, f_main);
  Application.CreateForm(Tf_repair, f_repair);
  Application.CreateForm(Tf_repair_imei, f_repair_imei);
  Application.CreateForm(Tf_select_modem_port, f_select_modem_port);
  Application.CreateForm(Tf_advanced_repair, f_advanced_repair);
  Application.CreateForm(TfConverter, fConverter);
  Application.CreateForm(Tf_unlock_type, f_unlock_type);
  Application.CreateForm(Tf_login, f_login);
  Application.Run;
end.
