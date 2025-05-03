import '/imports.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  MyTextField({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, color: Color(0xff6B6B6B)),
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8E8E8)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffE8E8E8)),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          filled: true,
          fillColor: const Color(0xffF6F6F6),
          hintText: hintText,
          hintStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Color(0xffBDBDBD))),
    );
  }
}
