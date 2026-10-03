object UniServerModule: TUniServerModule
  OnCreate = UniGUIServerModuleCreate
  TempFolder = 'temp\'
  Port = 8090
  Title = 'Usegear '#32452#24577#24037#31243#24037#20316#21488
  SuppressErrors = []
  Bindings = <>
  SSL.SSLOptions.RootCertFile = 'root.pem'
  SSL.SSLOptions.CertFile = 'cert.pem'
  SSL.SSLOptions.KeyFile = 'key.pem'
  SSL.SSLOptions.Method = sslvSSLv23
  SSL.SSLOptions.SSLVersions = [sslvTLSv1_1, sslvTLSv1_2]
  SSL.SSLOptions.Mode = sslmUnassigned
  SSL.SSLOptions.VerifyMode = []
  SSL.SSLOptions.VerifyDepth = 0
  ConnectionFailureRecovery.ErrorMessage = #36830#25509#38169#35823
  ConnectionFailureRecovery.RetryMessage = #37325#35797'...'
  Height = 480
  Width = 640
end
