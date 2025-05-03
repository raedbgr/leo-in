import '/imports.dart';

class MyImageFilter extends StatelessWidget {
  final String imagePath;
  final bool isBase64;

  MyImageFilter({super.key, required this.imagePath, required this.isBase64});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
          child: isBase64
              ? Base64Image(
                  base64String: imagePath,
                )
              : Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.black.withOpacity(0.7),
              ],
            ),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35),
              bottomRight: Radius.circular(35),
            ),
          ),
        ),
      ],
    );
  }
}
