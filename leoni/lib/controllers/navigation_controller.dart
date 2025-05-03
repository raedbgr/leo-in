import '/imports.dart';

class NavigationController extends GetxController {
  final RxString selectedPage = '/home'.obs; // Initialize with default page
  final EventController eventController = Get.find();
  final CalendarController calendarController = Get.find();

  @override
  void onInit() {
    super.onInit();
  }

  Widget getScreen(String page, GlobalKey<ScaffoldState> scaffoldKey) {
    // Always use the provided scaffoldKey from NavigationPage
    switch (page) {
      case '/home':
        return HomePage(scaffoldKey: scaffoldKey);
      case '/calendar':
        return CalendarPage(scaffoldKey: scaffoldKey);
      case '/partners':
        return PartnersPage(scaffoldKey: scaffoldKey);
      case '/account':
        return AccountPage(scaffoldKey: scaffoldKey);
      case '/events':
        return EventsPage(scaffoldKey: scaffoldKey);
      case '/news':
        return NewsPage(scaffoldKey: scaffoldKey);
      default:
        return HomePage(scaffoldKey: scaffoldKey); // Default page
    }
  }

  void navigateToPage(String page) {
    // Update the selected page which will trigger the Obx rebuild in NavigationPage
    selectedPage.value = page;
  }

  // Maps the string route to the index
  int getSelectedIndex(String page) {
    switch (page) {
      case '/home':
        return 0;
      case '/calendar':
        return 1;
      // case '/chat':
      //   return 1;
      case '/partners':
        return 2;
      case '/account':
        return 3;
      default:
        return 0; // Default to Home page
    }
  }

  // Maps the index to the string route
  String? getPageFromIndex(int index) {
    switch (index) {
      case 0:
        return '/home';
      case 1:
        return '/calendar';
      // case 1:
      //   return '/chat';
      case 2:
        return '/partners';
      case 3:
        return '/account';
      default:
        return null;
    }
  }
}
