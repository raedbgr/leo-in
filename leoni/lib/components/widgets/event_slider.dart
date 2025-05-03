import '/imports.dart';

class EventSlider extends StatelessWidget {
  final HomeController controller = Get.find();
  final pathImages = [
    'assets/images/slider1.jpg',
    'assets/images/slider2.jpeg',
    'assets/images/slider3.jpg',
    'assets/images/slider4.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider.builder(
            itemCount: pathImages.length,
            itemBuilder: (context, int index, int realIndex) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: AssetImage(pathImages[index]),
                      fit: BoxFit.cover,
                    )),
              );
            },
            options: CarouselOptions(
                viewportFraction: 1,
                initialPage: 0,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 3),
                onPageChanged: (index, _) =>
                    controller.updatePageIndicator(index))),
        const SizedBox(
          height: 15,
        ),
        Obx(
          () => Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int i = 0; i < 4; i++)
                Container(
                  width: 20,
                  height: 4,
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: controller.sliderCurrentIndex.value == i
                        ? const Color(0xff0379f6)
                        : Colors.grey,
                  ),
                )
            ],
          ),
        )
      ],
    );
  }
}
