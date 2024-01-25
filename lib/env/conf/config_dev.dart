import 'package:solca_app/env/config/config_base.dart';

class DevEnv extends BaseConfig{
  
  @override
  String get appName => 'Solca App';

  @override

  String get serviceUrl => 'http://10.10.80.249:8910/';
}