import 'package:camera/camera.dart';
import 'package:color_pallete/app.dart';
import 'package:color_pallete/data/enum.dart';
import 'package:color_pallete/data/models/app_configs_model.dart';
import 'package:color_pallete/di/locator.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> cameras;
void main() {
  //TODO: change app config dev here
  const appConfig = AppConfig(
    appName: "AppNameDev",
    env: Environment.dev,
  );
  executeMain(appConfig);
}

void executeMain(AppConfig appConfig) async {
  configureDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(
    MyApp(
      appConfig: appConfig,
    ),
  );
}
