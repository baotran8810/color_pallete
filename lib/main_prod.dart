import 'package:color_pallete/data/enum.dart';
import 'package:color_pallete/data/models/app_configs_model.dart';
import 'package:color_pallete/main.dart';

void main() {
  //TODO: change app config prod here
  const appConfig = AppConfig(
    appName: "AppNameProd",
    env: Environment.prod,
  );
  executeMain(appConfig);
}
