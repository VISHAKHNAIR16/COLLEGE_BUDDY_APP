import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({super.key});

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  String _recognizedText = '';

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final inputImage = InputImage.fromFilePath(image.path);
      final textRecognizer = GoogleMlKit.vision.textRecognizer();
      final RecognizedText recognizedText =
          await textRecognizer.processImage(inputImage);
      setState(() {
        _recognizedText = recognizedText.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Time Table Recognition'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImage,
            child: const Text('Pick Image'),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Text(_recognizedText),
            ),
          ),
        ],
      ),
    );
  }
}
