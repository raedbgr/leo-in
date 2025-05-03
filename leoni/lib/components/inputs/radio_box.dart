import '/imports.dart';

class MyRadioBox extends StatefulWidget {
  final String text;
  final int value;
  final int groupValue;
  final ValueChanged<int?> onChanged;

  MyRadioBox({
    required this.text,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  State<MyRadioBox> createState() => _MyRadioBoxState();
}

class _MyRadioBoxState extends State<MyRadioBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<int>(
          focusColor: Get.find<ThemeController>().currentTheme.value.focusColor,
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
        ),
        Text(
          widget.text,
          style: TextStyle(
            color: Get.find<ThemeController>().currentTheme.value.focusColor,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
