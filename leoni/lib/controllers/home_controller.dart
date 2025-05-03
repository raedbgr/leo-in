import '/imports.dart';

class HomeController extends GetxController {
  final PartnerController partController = Get.find();
  final NewsController newsController = Get.find();
  final NotifController notifCtr = Get.find();
  final sliderCurrentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> refreshData(context) async {
    try {
      // Example: Fetch data from your controllers
      await notifCtr.fetchNotifications();
      // Load hardcoded news data
      newsController.loadHardcodedNews();
    } catch (error) {
      // Handle any errors during the refresh process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh data: $error')),
      );
    }
  }

  void updatePageIndicator(index) {
    sliderCurrentIndex.value = index;
  }

  void launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
