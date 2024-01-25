import 'package:ecommerce/env/conf/config_base.dart';

class DevEnv extends BaseConfig{
  
  @override
  String get appName => 'Solca App';

  @override

  String get serviceUrl => 'http://192.168.100.38:8000/';
}