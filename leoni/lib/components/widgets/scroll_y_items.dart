import '/imports.dart';

class ScrollYItems extends StatelessWidget {
  final HomeController controller = Get.find();
  final Widget Function(int index) itemBuilder;
  final int itemCount;

  ScrollYItems({required this.itemBuilder, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(itemCount, (index) {
            return Padding(
              padding: const EdgeInsets.only(right: 15),
              child: itemBuilder(index),
            );
          }),
        ));
  }
}
