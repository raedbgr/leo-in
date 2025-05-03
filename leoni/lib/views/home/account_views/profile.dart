import '/imports.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ThemeController themeController = Get.find();
  final AuthController authController = Get.find();
  final AccountController controller = Get.find();
  final EventController eventCtr = Get.find();

  @override
  void initState() {
    super.initState();
    authController.fetchUserFromDatabase(authController.currentUser.uniqueName);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor:
            themeController.currentTheme.value.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 210,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                    child: Stack(
                      children: [
                        MyImageFilter(
                          isBase64: false,
                          imagePath: 'assets/images/chessbg.jpg',
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Iconsax.arrow_left_2,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      final result = await Get.toNamed(
                                        '/editPf',
                                      );
                                      if (result == true) {
                                        setState(() {
                                          // This will rebuild the UI with the updated data
                                          authController.currentUser =
                                              Get.find<AccountController>()
                                                  .currentUser;
                                        });
                                      }
                                    },
                                    icon: const Icon(
                                      Iconsax.edit,
                                      size: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 135),
                    child: Center(
                      child: Container(
                        width: 132,
                        height: 132,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:
                                themeController
                                    .currentTheme
                                    .value
                                    .scaffoldBackgroundColor,
                            width: 5,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 100,
                          backgroundImage: authController.currentUser.imagePath.startsWith('assets/')
                              ? AssetImage(authController.currentUser.imagePath)
                              : MemoryImage(base64Decode(
                                  authController.currentUser.imagePath.split(',').last)),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        authController.currentUser.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: themeController.currentTheme.value.focusColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Iconsax.briefcase,
                            color:
                                themeController.currentTheme.value.focusColor,
                          ),
                          const SizedBox(width: 7),
                          Text(
                            authController.currentUser.post,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color:
                                  themeController.currentTheme.value.focusColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.building,
                                color:
                                    themeController
                                        .currentTheme
                                        .value
                                        .focusColor,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                authController.currentUser.department,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color:
                                      themeController
                                          .currentTheme
                                          .value
                                          .focusColor,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                color:
                                    themeController
                                        .currentTheme
                                        .value
                                        .focusColor,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                authController.currentUser.region,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  color:
                                      themeController
                                          .currentTheme
                                          .value
                                          .focusColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      authController.currentUser.bio,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: themeController.currentTheme.value.focusColor,
                      ),
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
              TabBar(
                labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                unselectedLabelStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: themeController.currentTheme.value.hintColor,
                ),
                labelColor: themeController.currentTheme.value.focusColor,
                indicatorColor: Colors.transparent,
                overlayColor: WidgetStateColor.transparent,
                tabs: const [Tab(text: 'About'), Tab(text: 'Events')],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 20,
                        ),
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color:
                                    themeController
                                        .currentTheme
                                        .value
                                        .cardColor,
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(
                                  color:
                                      themeController
                                          .currentTheme
                                          .value
                                          .hintColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Skills',
                                      style: TextStyle(
                                        color:
                                            themeController
                                                .currentTheme
                                                .value
                                                .focusColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      authController.currentUser.skills,
                                      style: TextStyle(
                                        color:
                                            themeController
                                                .currentTheme
                                                .value
                                                .focusColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color:
                                    themeController
                                        .currentTheme
                                        .value
                                        .cardColor,
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(
                                  color:
                                      themeController
                                          .currentTheme
                                          .value
                                          .hintColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Hobbies',
                                      style: TextStyle(
                                        color:
                                            themeController
                                                .currentTheme
                                                .value
                                                .focusColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      authController.currentUser.hobbies,
                                      style: TextStyle(
                                        color:
                                            themeController
                                                .currentTheme
                                                .value
                                                .focusColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(
                                color:
                                    themeController
                                        .currentTheme
                                        .value
                                        .cardColor,
                                borderRadius: BorderRadius.circular(11),
                                border: Border.all(
                                  color:
                                      themeController
                                          .currentTheme
                                          .value
                                          .hintColor,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Languages',
                                      style: TextStyle(
                                        color:
                                            themeController
                                                .currentTheme
                                                .value
                                                .focusColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      authController.currentUser.langs,
                                      style: TextStyle(
                                        color:
                                            themeController
                                                .currentTheme
                                                .value
                                                .focusColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: Obx(
                        () =>
                            eventCtr.userEvents.isEmpty
                                ? const Center(
                                  child: Text(
                                    'You haven\'t participated in any events yet',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                                : ListView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: eventCtr.userEvents.length,
                                  itemBuilder:
                                      (context, index) => GestureDetector(
                                        onTap: () {
                                          Get.toNamed(
                                            '/eventInfo',
                                            arguments:
                                                eventCtr.userEvents[index],
                                          );
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            vertical: 3,
                                            horizontal: 10,
                                          ),
                                          width: double.infinity,
                                          margin: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: const Color(0xff2F3D47),
                                            borderRadius: BorderRadius.circular(
                                              11,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  eventCtr
                                                      .userEvents[index]
                                                      .name,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Iconsax.location,
                                                          color: Colors.green,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          eventCtr
                                                              .userEvents[index]
                                                              .region,
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Row(
                                                      children: [
                                                        const Icon(
                                                          Iconsax.clock,
                                                          color: Colors.green,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          DateFormat(
                                                            'hh:mm a',
                                                          ).format(
                                                            eventCtr
                                                                .userEvents[index]
                                                                .dateB,
                                                          ),
                                                          style:
                                                              const TextStyle(
                                                                fontSize: 16,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                color:
                                                                    Colors
                                                                        .white,
                                                              ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
