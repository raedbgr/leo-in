import 'package:flutter/cupertino.dart';

import '/imports.dart';

class AccountPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  AccountPage({required this.scaffoldKey});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final ThemeController themeController = Get.find();
  final AuthController authController = Get.find();
  final AccountController controller = Get.find();

  @override
  void initState() {
    super.initState();
    authController.currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: themeController.currentTheme.value.highlightColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: const Offset(0, 20),
                    blurStyle: BlurStyle.normal),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                  right: 12.5, left: 12.5, top: 15, bottom: 25),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              widget.scaffoldKey.currentState!.openDrawer();
                            },
                            icon: const Icon(
                              Iconsax.menu,
                              size: 30,
                            ),
                            color: themeController.currentTheme.value.focusColor,
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'Account',
                            style: TextStyle(
                              color: themeController
                                  .currentTheme.value.focusColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      IconButton(
                        onPressed: () {
                          Get.find<AuthController>().logout();
                        },
                        icon: const Icon(
                          Iconsax.logout,
                          size: 30,
                        ),
                        color: themeController.currentTheme.value.focusColor,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/profile');
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12.5, 25, 12.5, 0),
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
                                  borderRadius: BorderRadius.circular(12),
                                  child: authController.currentUser.imagePath.startsWith('assets/')
                                      ? Image.asset(
                                          authController.currentUser.imagePath,
                                          fit: BoxFit.cover,
                                        )
                                      : controller.base64Image != null
                                          ? Base64Image(
                                              base64String:
                                                  authController.currentUser.imagePath,
                                            )
                                          : Image.asset(
                                              'assets/images/default_profile.png')),
                            );
                          }),
                          const SizedBox(
                            width: 15,
                          ),
                          Expanded(
                            child: Text(
                              authController.currentUser.name,
                              style: TextStyle(
                                color: themeController
                                    .currentTheme.value.focusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Icon(
                            Iconsax.arrow_right_3,
                            color:
                                themeController.currentTheme.value.focusColor,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 50, 50),
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Theme toggle here
                      setState(() {
                        themeController.toggleTheme();
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            // toggle button here instead of icon
                            Icon(
                              Iconsax.moon,
                              size: 30,
                              color:
                                  themeController.currentTheme.value.focusColor,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Dark Mode',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: themeController
                                      .currentTheme.value.focusColor),
                            ),
                          ],
                        ),
                        Obx(
                          () => CupertinoSwitch(
                            value: themeController.isDarkModeOn.value,
                            onChanged: (value) {
                              themeController.toggleTheme();
                            },
                            activeColor: themeController.currentTheme.value.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.toNamed('/notif');
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Iconsax.notification,
                              size: 30,
                              color:
                                  themeController.currentTheme.value.focusColor,
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                            Text(
                              'Notifications',
                              style: TextStyle(
                                fontSize: 16,
                                color: themeController
                                    .currentTheme.value.focusColor,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Iconsax.arrow_right_3,
                          color: themeController.currentTheme.value.focusColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
