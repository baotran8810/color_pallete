import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:color_pallete/main.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:image/image.dart' as imglib;

const shift = (0xFF << 24);

class CameraApp extends StatefulWidget {
  /// Default Constructor
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  final DynamicLibrary convertImageLib = Platform.isAndroid
      ? DynamicLibrary.open("libconvertImage.so")
      : DynamicLibrary.process();

  List<Color> listColor = [];
  late Timer _timer;
  bool processImage = false;
  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    startTimer();
    controller.initialize().then((_) {
      _handleImage();

      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            if (kDebugMode) {
              print('User denied camera access.');
            }
            break;
          default:
            if (kDebugMode) {
              print('Handle other errors.');
            }
            break;
        }
      }
    });
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        processImage = true;
      },
    );
  }

  ByteData? _convertImage(CameraImage image) {
    final int width = image.width;
    final int height = image.height;
    final int uvRowStride = image.planes[1].bytesPerRow;
    final int uvPixelStride = image.planes[1].bytesPerPixel!;

    var img = imglib.Image(width, height);

    for (int x = 0; x < width; x++) {
      for (int y = 0; y < height; y++) {
        final int uvIndex =
            uvPixelStride * (x / 2).floor() + uvRowStride * (y / 2).floor();
        final int index = y * width + x;

        final yp = image.planes[0].bytes[index];
        final up = image.planes[1].bytes[uvIndex];
        final vp = image.planes[2].bytes[uvIndex];
        // Calculate pixel color
        int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
        int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
            .round()
            .clamp(0, 255);
        int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
        // color: 0x FF  FF  FF  FF
        //           A   B   G   R
        img.data[index] = shift | (b << 16) | (g << 8) | r;
      }
      // imglib.PngEncoder pngEncoder = imglib.PngEncoder(level: 0, filter: 0);
      // List<int> png = pngEncoder.encodeImage(img);

      // final result = Image.memory(Uint8List.fromList(png));

      return img.data.buffer.asByteData();
    }
    return null;
  }

  _handleImage() {
    controller.startImageStream((image) async {
      final result = _convertImage(image);

      if (result != null && processImage) {
        processImage = false;
        final paletteGenerator = await PaletteGenerator.fromByteData(
            EncodedImage(result, width: image.width, height: image.height));

        setState(() {
          listColor = paletteGenerator.colors.toList();
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CameraPreview(controller),
          ),
          SizedBox(
            height: 10,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ...listColor.map((e) => Container(
                      width: 10,
                      height: 10,
                      color: e,
                    ))
              ],
            ),
          )
        ],
      ),
    );
  }
}
