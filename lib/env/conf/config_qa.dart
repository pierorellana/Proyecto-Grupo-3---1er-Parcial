import 'package:solca_app/env/config/config_base.dart';

class QaEnv extends BaseConfig{
  @override
  String get appName => 'Solca App';

  @override
  String get serviceUrl => 'http://172.16.50.175:8910/';
}