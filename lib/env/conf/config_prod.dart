import 'package:solca_app/env/config/config_base.dart';

class ProdEnv extends BaseConfig{
  @override
  String get appName => 'Solca App';

  @override
  String get serviceUrl => 'http://172.16.1.148:40102/';
}