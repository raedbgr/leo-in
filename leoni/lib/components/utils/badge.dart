import '/imports.dart';

class MyBadge extends StatelessWidget {
  final Widget iconChild;
  final String value;
  final Color color;
  final TextStyle textStyle;
  final double posX;
  final double posY;

  const MyBadge(
      {Key? key,
      required this.iconChild,
      required this.value,
      this.color = Colors.red,
      this.textStyle = const TextStyle(color: Colors.white, fontSize: 12),
      required this.posX,
      required this.posY})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        iconChild,
        if (value.isNotEmpty)
          Positioned(
            top: posX,
            right: posY,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              constraints: const BoxConstraints(
                minWidth: 12,
                minHeight: 12,
              ),
              child: Center(
                child: Text(
                  '',
                  style: textStyle,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
