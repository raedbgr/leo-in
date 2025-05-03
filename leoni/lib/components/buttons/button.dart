import '/imports.dart';

class MyButton extends StatelessWidget {
  late final String text;
  late final Color color;
  late final bool outline;
  late final double width;
  late final double height;
  late final double fontSize;

  MyButton({
    required this.text,
    required this.color,
    required this.outline,
    required this.width,
    required this.height,
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: outline
          ? BoxDecoration(
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(15),
            )
          : BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(15),
            ),
      child: Center(
        child: Text(
          text,
          style: outline
              ? TextStyle(color: color, fontSize: fontSize)
              : TextStyle(color: Colors.white, fontSize: fontSize),
        ),
      ),
    );
  }
}
