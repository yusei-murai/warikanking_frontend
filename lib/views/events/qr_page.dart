import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:warikanking_frontend/utils/function_utils.dart';
import 'package:warikanking_frontend/utils/widget_utils.dart';

class QrPage extends StatefulWidget {
  QrPage(this.eventId, this.eventName);
  String eventId;
  String eventName;

  @override
  _QrPageState createState() => _QrPageState();
}

class _QrPageState extends State<QrPage> {
  ScreenshotController screenshotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    final QrImage qr = QrUtils.qrImage(widget.eventId);
    File? image;

    return Scaffold(
      appBar: AppBarUtils.screenAppBar(context, ""),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.pink,width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.eventName,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  const SizedBox(height: 30,),
                  Screenshot(
                    controller: screenshotController,
                    child: Container(
                        color: Colors.white,
                        child: qr
                    ),
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                    ),
                    onPressed: () async {
                      await FunctionUtils.screenshotSave(screenshotController);
                      if (!mounted) return;
                      SnackBarUtils.doneSnackBar("QRコードを保存しました", context);
                    },
                    child: const Icon(Icons.save_alt_outlined),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
