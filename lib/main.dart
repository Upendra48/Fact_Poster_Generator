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
  final int itemCount = 3; // Number of items in the list
  final GlobalKey globalKey = GlobalKey();
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
                  key: globalKey,
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/insight_01.png',
                            height: MediaQuery.sizeOf(context).height * 0.7,
                          ),
                          Center(
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
                                Text(
                                  descriptionController.text,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/insight_01.png',
                            height: MediaQuery.sizeOf(context).height * 0.7,
                          ),
                          Center(
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
                                Text(
                                  descriptionController.text,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/insight_01.png',
                            height: MediaQuery.sizeOf(context).height * 0.7,
                          ),
                          Center(
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
                                Text(
                                  descriptionController.text,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w100,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
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
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    final RenderRepaintBoundary? boundary =
                        globalKey.currentContext!.findRenderObject()
                            as RenderRepaintBoundary?;

                    final ui.Image image = await boundary!.toImage(
                      pixelRatio: 3.0,
                    );

                    final ByteData? byteData =
                        await image.toByteData(format: ui.ImageByteFormat.png);

                    final Uint8List pngBytes = byteData!.buffer.asUint8List();

                    final base64 = base64Encode(pngBytes);

                    AnchorElement(
                      href: 'data:application/octet-stream;base64,$base64',
                    )
                      ..setAttribute('download',
                          '${factTitleController.text.trim().replaceAll(' ', '_').toLowerCase()}.png')
                      ..click();
                  },
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
