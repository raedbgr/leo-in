import '/imports.dart';

class ReadOnlyInput extends StatelessWidget {
  const ReadOnlyInput({super.key, required this.content, required this.icon});

  final String content;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextField(
        readOnly: true,
        decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffFAFAFA),
            prefixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(
                  width: 15,
                ),
                Icon(icon),
                Container(
                  height: 24,
                  width: 1,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                ),
              ],
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xffb1b1b1))),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xffb1b1b1))),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Color(0xffb1b1b1)))),
        controller: TextEditingController(text: content),
      ),
    );
  }
}
