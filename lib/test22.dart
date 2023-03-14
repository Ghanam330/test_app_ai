import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';
import 'package:image/image.dart' as img;
class PixelColorScreen extends StatefulWidget {
  @override
  PixelColorScreenState createState() => PixelColorScreenState();
}

class PixelColorScreenState extends State<PixelColorScreen> {
  Color? _pixelColor;

  Future<void> _getPixelColor() async {
    final pixelColor = await getPixelColor('assets/images/test3.png', 100, 200);
    setState(() {
      _pixelColor = pixelColor;
    });
  }
  Future<Color> getPixelColor(String imagePath, int x, int y) async {
    ByteData byteData = await rootBundle.load(imagePath);
    final image = img.decodeImage(byteData.buffer.asUint8List());
    if (x < 0 || y < 0 || x >= image!.width || y >= image.height) {
      throw ArgumentError('Pixel coordinates are out of bounds.');
    }

    final pixel = image.getPixel(x, y);
    return Color.fromRGBO(
      img.getRed(pixel),
      img.getGreen(pixel),
      img.getBlue(pixel),
      1.0,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pixel Color'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _getPixelColor,
              child: Text('Get Pixel Color'),
            ),
            if (_pixelColor != null) ...[
              SizedBox(height: 20),
              Text(
                'Pixel Color: $_pixelColor',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Container(
                width: 50,
                height: 50,
                color: _pixelColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
