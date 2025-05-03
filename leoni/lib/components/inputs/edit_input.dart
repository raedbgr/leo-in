import '/imports.dart';

class EditInput extends StatelessWidget {
  final ThemeController themeController = Get.find();
  final String label;
  final int sizeMin;

  EditInput({
    super.key,
    required TextEditingController descriptionController,
    required this.label,
    required this.sizeMin,
  }) : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _descriptionController,
      minLines: sizeMin,
      style: TextStyle(color: themeController.currentTheme.value.focusColor),
      maxLines: 4,
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
