import '/imports.dart';

class DescInput extends StatelessWidget {

  DescInput({
    super.key,
    required TextEditingController descriptionController,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _descriptionController,
      style: TextStyle(
        color: themeController.currentTheme.value.focusColor,
      ),
      maxLines: 5,
      decoration: InputDecoration(
        fillColor: themeController.currentTheme.value.cardColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: themeController.currentTheme.value.hintColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: themeController.currentTheme.value.hintColor),
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
      ),
    );
  }
}
