import '/imports.dart';

class Base64Image extends StatelessWidget {
  final String base64String;

  Base64Image({required this.base64String});

  @override
  Widget build(BuildContext context) {
    // Decode the Base64 string into bytes
    Uint8List imageBytes = base64Decode(base64String.split(',').last);

    // Return the image widget
    return Image.memory(
      imageBytes,
      fit: BoxFit.contain,
    );
  }
}
