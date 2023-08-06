import 'dart:typed_data';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:intl/intl.dart';
import 'package:screenshot/screenshot.dart';

class FunctionUtils{
  static String toYenFormat(int money){
    final yenFormatter = NumberFormat("#,###");
    String result = yenFormatter.format(money);

    return result;
  }

  static Future<void> screenshotSave(
      ScreenshotController screenshotController) async {
    await screenshotController.capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List? image) async {
      if (image != null) {
        final result = await ImageGallerySaver.saveImage(image);
      }
    });
  }
}