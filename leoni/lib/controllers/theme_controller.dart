import '/imports.dart';

class ThemeController extends GetxController {
  final String _themeKey = 'isDarkModeOn';
  late SharedPreferences _prefs;

  final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xffFFFFFF),
    highlightColor: const Color(0xffFFFFFF),
    primaryColor: const Color(0xff0379f6),
    splashColor: const Color(0xffE9881B),
    hintColor: const Color(0xff95969D),
    cardColor: const Color(0xffF5F5F5).withOpacity(0.5),
    focusColor: Colors.black,
    brightness: Brightness.light,
    fontFamily: 'Poppins',
  );
  final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color(0xff0D1114),
    highlightColor: const Color(0xff121212),
    primaryColor: const Color(0xff0379f6),
    splashColor: const Color(0xffE9881B),
    hintColor: const Color(0xff95969D),
    cardColor: const Color(0xffFBF9F9).withOpacity(0.15),
    focusColor: const Color(0xffFBF9F9),
    brightness: Brightness.dark,
    fontFamily: 'Poppins',
  );
  Rx<ThemeData> currentTheme = ThemeData.light().obs;
  Rx<bool> isDarkModeOn = false.obs;

  @override
  void onInit() async {
    super.onInit();
    _prefs = await SharedPreferences.getInstance();
    isDarkModeOn.value = _prefs.getBool(_themeKey) ?? false;
    currentTheme.value = isDarkModeOn.value ? darkTheme : lightTheme;
  }

  // Method to toggle between light and dark themes
  void toggleTheme() async {
    if (currentTheme.value.brightness == Brightness.light) {
      currentTheme.value = darkTheme;
      isDarkModeOn.value = true;
    } else {
      currentTheme.value = lightTheme;
      isDarkModeOn.value = false;
    }
    // Save the theme mode in shared preferences
    await _prefs.setBool(_themeKey, isDarkModeOn.value);
  }
}
