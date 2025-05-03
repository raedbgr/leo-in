import '/imports.dart';

class MySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onSubmittedFunction;

  MySearchBar({required this.controller, required this.onSubmittedFunction});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffbababa)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xffbababa)),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        prefixIcon: Icon(Iconsax.search_normal),
        hintText: 'Search',
        filled: true,
        fillColor: Color(0xffeeeeee),
      ),
      onSubmitted: onSubmittedFunction,
    );
  }
}
