import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:palette_generator/palette_generator.dart';

class MyImageScreen extends StatefulWidget {
  const MyImageScreen({Key? key}) : super(key: key);

  @override
  _MyImageScreenState createState() => _MyImageScreenState();
}

class _MyImageScreenState extends State<MyImageScreen> {
  late Uint8List _imageData;
  Color? _dominantColor;

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final ByteData data = await rootBundle.load('assets/images/ahmed.jpeg');
    _imageData = data.buffer.asUint8List();
    _getDominantColor();
  }

  Future<void> _getDominantColor() async {
    final PaletteGenerator paletteGenerator =
    await PaletteGenerator.fromImageProvider(
      MemoryImage(_imageData),
      maximumColorCount: 20,
      filters: [avoidRedBlackWhitePaletteFilter],
    );
    setState(() {
      _dominantColor = paletteGenerator.dominantColor?.color;
    });
  }

  @override
  Widget build(BuildContext context) {
     print(  _dominantColor);
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Image Screen'),
      ),
      body: Center(
        child: _dominantColor != null
            ? Container(
          decoration: BoxDecoration(
            color: _dominantColor,
            borderRadius: BorderRadius.circular(10.0),
          ),
          width: 200.0,
          height: 200.0,
        )
            : const CircularProgressIndicator(),
      ),
    );
  }
}
