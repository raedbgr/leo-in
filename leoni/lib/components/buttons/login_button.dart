import '/imports.dart';

class LoginButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;

  LoginButton({
    required this.textColor,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 272,
      height: 53,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          'Sign in',
          style: TextStyle(
              color: textColor, fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
