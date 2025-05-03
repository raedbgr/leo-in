import '/imports.dart';

class MyDropdown extends StatefulWidget {
  final String hintTxt;
  final List<String> items;
  final ValueChanged<String?> onSelected;

  const MyDropdown({
    required this.hintTxt,
    required this.items,
    required this.onSelected,
  });

  @override
  State<MyDropdown> createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {
  final ThemeController themeController = Get.find();
  late String locationT;
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      width: 200,
      inputDecorationTheme: InputDecorationTheme(
        fillColor: themeController.currentTheme.value.cardColor,
        filled: true,
        hintStyle: TextStyle(
          color: themeController.currentTheme.value.hintColor,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: themeController.currentTheme.value.hintColor,
          ),
        ),
      ),
      menuStyle: const MenuStyle(
        backgroundColor: WidgetStatePropertyAll(Colors.white),
      ),
      hintText: widget.hintTxt,
      textStyle: TextStyle(
        color: themeController.currentTheme.value.focusColor,
      ),
      onSelected: (value) {
        setState(() {
          selectedValue = value;
        });
        widget.onSelected(value);
      },
      dropdownMenuEntries: widget.items.map((item) {
        return DropdownMenuEntry(value: item, label: item);
      }).toList(),
    );
  }
}
