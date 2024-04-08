import 'package:flutter/material.dart';

import 'dart:typed_data';
import 'dart:convert';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //fucntion to download the image
Future<void> _downloadImage(GlobalKey key, String fileName) async {
  final RenderRepaintBoundary? boundary =
      key.currentContext!.findRenderObject() as RenderRepaintBoundary?;

  final double pixelRatio = ui.window.devicePixelRatio; // Get device pixel ratio

  final ui.Image image = await boundary!.toImage(pixelRatio: pixelRatio);

  final ByteData? byteData =
      await image.toByteData(format: ui.ImageByteFormat.png);

  final Uint8List pngBytes = byteData!.buffer.asUint8List();

  final base64 = base64Encode(pngBytes);

  AnchorElement(
    href: 'data:application/octet-stream;base64,$base64',
  )
    ..setAttribute('download', '$fileName.png')
    ..click();
}


  final GlobalKey globalKey1 = GlobalKey();

  final TextEditingController factTitleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fact Poster Generator'),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                RepaintBoundary(
                  key: globalKey1,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/1.jpg',
                        height: MediaQuery.sizeOf(context).height /1.2,
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 55, 0, 0),
                          child: Column(
                            children: [
                              Text(
                                factTitleController.text,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 35,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                child: Text(
                                  descriptionController.text,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 40,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  child: Column(
                    children: [
                      TextField(
                        controller: factTitleController,
                        onChanged: (value) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: "Enter title of the fact",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: descriptionController,
                        onChanged: (value) => setState(() {}),
                        decoration: const InputDecoration(
                          labelText: "Enter description of the fact",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(),
                        ),
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                        
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    await _downloadImage(globalKey1, 'fact_poster.png');

                  },
                  //async {
                  //   final RenderRepaintBoundary? boundary =
                  //       globalKey.currentContext!.findRenderObject()
                  //           as RenderRepaintBoundary?;
            
                  //   final ui.Image image = await boundary!.toImage(
                  //     pixelRatio: 3.0,
                  //   );
            
                  //   final ByteData? byteData =
                  //       await image.toByteData(format: ui.ImageByteFormat.png);
            
                  //   final Uint8List pngBytes = byteData!.buffer.asUint8List();
            
                  //   final base64 = base64Encode(pngBytes);
            
                  //   AnchorElement(
                  //     href: 'data:application/octet-stream;base64,$base64',
                  //   )
                  //     ..setAttribute('download',
                  //         '${factTitleController.text.trim().replaceAll(' ', '_').toLowerCase()}.png')
                  //     ..click();
                  // },
                  child: const Text(
                    "Save Image",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
