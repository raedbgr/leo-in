import '/imports.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final ThemeController themeController = Get.find();
  final NavigationController controller = Get.find();
  final UserModel currentUser = Get.find<AuthController>().currentUser;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        key: _scaffoldKey,
        backgroundColor:
            themeController.currentTheme.value.scaffoldBackgroundColor,
        drawer: MyDrawer(),
        body: controller.getScreen(controller.selectedPage.value, _scaffoldKey),
        // floatingActionButton: controller.selectedPage.value == '/chat' && currentUser.isAdmin
        //     ? FloatingActionButton(
        //   onPressed: () {
        //     controller.navigateToPage('/createChat');
        //   },
        //   shape: const CircleBorder(),
        //   backgroundColor: themeController.currentTheme.value.primaryColor,
        //   child: const Icon(Icons.add, color: Colors.white,),
        // )
        //     : null,
        bottomNavigationBar: MyNavBar(),
      ),
    );
  }
}
