import 'package:ecommerce/env/conf/config_base.dart';

class QaEnv extends BaseConfig{
  @override
  String get appName => 'Ecommerce';

  @override
  String get serviceUrl => 'http://172.16.50.175:8910/';
}