import '/imports.dart';

class MyBindings extends Bindings {
  @override
  void dependencies() {
    // Created at start
    Get.put(AuthController());
    Get.put(ThemeController());
    // Created when needed
    Get.lazyPut<AccountController>(() => AccountController(),fenix: true);
    Get.lazyPut<CalendarController>(() => CalendarController(),fenix: true);
    Get.lazyPut<EventController>(() => EventController(),fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(),fenix: true);
    Get.lazyPut<NewsController>(() => NewsController(),fenix: true);
    Get.lazyPut<NavigationController>(() => NavigationController(),fenix: true);
    Get.lazyPut<NotifController>(() => NotifController(),fenix: true);
    Get.lazyPut<PartnerController>(() => PartnerController(),fenix: true);
  }
}
