import '/imports.dart';

class UnorderedList extends StatelessWidget {
  final List<String> items;

  UnorderedList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) => ListItem(text: item)).toList(),
    );
  }
}

class ListItem extends StatelessWidget {
  final String text;
  final ThemeController themeController = Get.find();

  ListItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('• ', style: TextStyle(fontSize: 20, color: themeController.currentTheme.value.focusColor)),
        Expanded(
          child: Text(
            text,
            style: TextStyle(color: themeController.currentTheme.value.focusColor, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
