import '/imports.dart';

class FlipIcon extends StatefulWidget {
  final IconData icon;

  const FlipIcon({super.key, required this.icon});

  @override
  _FlipIconState createState() => _FlipIconState();
}

class _FlipIconState extends State<FlipIcon> {
  bool _isFlipped = false;

  void _toggleFlip() {
    setState(() {
      _isFlipped = !_isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFlip,
      child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.rotationX(
              _isFlipped ? 3.14 : 0), // 3.14 radians = 180 degrees
          child: Icon(
            widget.icon,
            size: 30,
          )),
    );
  }
}
