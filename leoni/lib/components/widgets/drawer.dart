import '/imports.dart';

class MyDrawer extends StatefulWidget {
  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final NavigationController navController = Get.find();
  final AuthController authController = Get.find();
  final NewsController newsController = Get.find();
  final ThemeController themeController = Get.find();
  final AccountController controller = Get.find();

  @override
  void initState() {
    super.initState();
    authController.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: themeController.currentTheme.value.scaffoldBackgroundColor,
      child: Column(
        children: [
          MaterialButton(
            onPressed: () {
              Get.toNamed('/profile');
            },
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: themeController.currentTheme.value.scaffoldBackgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 100, 0, 50),
                child: Center(
                  child: Row(
                    children: [
                      GetBuilder<AccountController>(builder: (controller) {
                        return Container(
                          height: 73,
                          width: 73,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.grey),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: authController.currentUser.imagePath.startsWith('assets/')
                                  ? Image.asset(
                                      authController.currentUser.imagePath,
                                      fit: BoxFit.cover,
                                    )
                                  : controller.base64Image != null && controller.base64Image!.isNotEmpty
                                      ? Base64Image(
                                          base64String:
                                              authController.currentUser.imagePath,
                                        )
                                      : Image.asset(
                                          'assets/images/default_profile.png')),
                        );
                      }),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          authController.currentUser.name,
                          style: TextStyle(
                              color: themeController.currentTheme.value.focusColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
              child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Icon(
                      Iconsax.flag,
                      size: 35,
                      color: themeController.currentTheme.value.focusColor,
                    ),
                  ),
                  title: Text(
                    'Events',
                    style: TextStyle(fontSize: 18, color: themeController.currentTheme.value.focusColor),
                  ),
                  onTap: () {
                    Get.back();
                    navController.navigateToPage('/events');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Icon(
                      Iconsax.document_text,
                      size: 35,
                      color: themeController.currentTheme.value.focusColor,
                    ),
                  ),
                  title: Text(
                    'News',
                    style: TextStyle(fontSize: 18, color: themeController.currentTheme.value.focusColor),
                  ),
                  onTap: () {
                    Get.back();
                    navController.navigateToPage('/news');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Icon(
                      Iconsax.directbox_notif,
                      size: 35,
                      color: themeController.currentTheme.value.focusColor,
                    ),
                  ),
                  title: Text(
                    'Service',
                    style: TextStyle(fontSize: 18, color: themeController.currentTheme.value.focusColor),
                  ),
                  onTap: () {
                    Get.back();
                    Get.toNamed('/service');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Icon(
                      Iconsax.message_question,
                      size: 35,
                      color: themeController.currentTheme.value.focusColor,
                    ),
                  ),
                  title: Text(
                    'Support',
                    style: TextStyle(fontSize: 18, color: themeController.currentTheme.value.focusColor),
                  ),
                  onTap: () {
                    Get.back();
                    Get.toNamed('/support');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Icon(
                      Iconsax.calendar_1,
                      size: 35,
                      color: themeController.currentTheme.value.focusColor,
                    ),
                  ),
                  title: Text(
                    'Leave Request',
                    style: TextStyle(fontSize: 18, color: themeController.currentTheme.value.focusColor),
                  ),
                  onTap: () {
                    Get.back();
                    Get.toNamed('/leaveRequest');
                  },
                ),
                ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 50),
                  leading: Padding(
                    padding: const EdgeInsets.only(right: 25),
                    child: Icon(
                      Iconsax.document_1,
                      size: 35,
                      color: themeController.currentTheme.value.focusColor,
                    ),
                  ),
                  title: Text(
                    'Document Request',
                    style: TextStyle(fontSize: 18, color: themeController.currentTheme.value.focusColor),
                  ),
                  onTap: () {
                    Get.back();
                    Get.toNamed('/documentRequest');
                  },
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
