import '/imports.dart';

class UploadButton extends StatelessWidget {
  final Color color;

  const UploadButton({
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      width: 125,
      decoration: BoxDecoration(
          color: const Color(0xffF6F6F6),
          border: Border.all(
            color: color,
          ),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Iconsax.export,
            color: color,
            size: 50,
          ),
          const Text(
            'Upload File',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Color(0xff7E7E7E)),
          )
        ],
      ),
    );
  }
}
