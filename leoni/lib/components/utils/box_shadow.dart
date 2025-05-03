import '/imports.dart';

Widget buildShadowedContainer(Widget child) {
  final ThemeController themeController = Get.find();
  return Material(
    elevation: 5, // Adjust elevation as needed
    shadowColor: Colors.black.withOpacity(0.25),
    child: Container(
      decoration: BoxDecoration(
        color: themeController.currentTheme.value.scaffoldBackgroundColor,
      ),
      child: child,
    ),
  );
}
