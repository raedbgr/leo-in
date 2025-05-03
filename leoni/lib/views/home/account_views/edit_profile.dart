import '/imports.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final ThemeController themeController = Get.find();
  final UserModel currentUser = Get.find<AuthController>().currentUser;
  final AccountController controller = Get.find();

  @override
  void initState() {
    super.initState();
    currentUser;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        imagePath: 'assets/images/chessbg.jpg',
                        isBase64: false,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: themeController
                                          .currentTheme.value.scaffoldBackgroundColor,
                                      content: Text(
                                          'Are you sure you want to cancel editing?',
                                          style: TextStyle(
                                            color: themeController.currentTheme.value.focusColor,
                                          )),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                            Get.back();
                                          },
                                          child: Text('Yes', style: TextStyle(color: themeController.currentTheme.value.focusColor)),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Text('No', style: TextStyle(color: themeController.currentTheme.value.focusColor)),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Iconsax.arrow_left_2,
                                size: 30,
                                color: Colors.white,
                              ),
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
                    child: GestureDetector(
                      onTap: () {
                        controller.pickImageFromGallery();
                      },
                      child:
                          GetBuilder<AccountController>(builder: (controller) {
                        return Container(
                          width: 132,
                          height: 132,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: themeController
                                    .currentTheme.value.scaffoldBackgroundColor,
                                width: 5),
                          ),
                          child: Stack(
                            children: [
                              CircleAvatar(
                                radius: 66,
                                backgroundImage: controller.base64Image != null
                                    ? MemoryImage(
                                        base64Decode(controller.base64Image!
                                            .split(',')
                                            .last),
                                      )
                                    : const AssetImage(
                                            'assets/images/default_profile.png')
                                        as ImageProvider,
                                backgroundColor: Colors.black.withOpacity(0.5),
                              ),
                              CircleAvatar(
                                radius: 66,
                                backgroundColor: Colors.black.withOpacity(0.5),
                                child: const Icon(
                                  Iconsax.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
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
                      currentUser.name,
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
                        Icon(Iconsax.briefcase, color: themeController.currentTheme.value.focusColor,),
                        const SizedBox(width: 7),
                        Text(
                          currentUser.post,
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
                            Icon(Iconsax.building, color: themeController.currentTheme.value.focusColor,),
                            const SizedBox(width: 7),
                            Text(
                              currentUser.department,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: themeController.currentTheme.value.focusColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 30),
                        Row(
                          children: [
                            Icon(Iconsax.location, color: themeController.currentTheme.value.focusColor,),
                            const SizedBox(width: 7),
                            Text(
                              currentUser.region,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                                color: themeController.currentTheme.value.focusColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 35),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                              'Bio :',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeController.currentTheme.value.focusColor,
                            ),
                          ),
                        ],
                      ),
                      EditInput(
                        descriptionController: controller.bioController,
                        label: 'Bio',
                        sizeMin: 1,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Skills :',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeController.currentTheme.value.focusColor,
                            ),
                          ),
                        ],
                      ),
                      EditInput(
                        descriptionController: controller.skillsController,
                        label: 'Skills',
                        sizeMin: 1,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Hobbies :',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeController.currentTheme.value.focusColor,
                            ),
                          ),
                        ],
                      ),
                      EditInput(
                        descriptionController: controller.hobbiesController,
                        label: 'Hobbies',
                        sizeMin: 1,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Languages :',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: themeController.currentTheme.value.focusColor,
                            ),
                          ),
                        ],
                      ),
                      EditInput(
                        descriptionController: controller.langsController,
                        label: 'Languages',
                        sizeMin: 1,
                      ),
                      const SizedBox(height: 25),
                      MaterialButton(
                        onPressed: () {
                          controller.updateUserData();
                          Get.back(result: true);
                        },
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: MyButton(
                          text: 'Save',
                          color: themeController.currentTheme.value.primaryColor,
                          outline: false,
                          width: 115,
                          height: 44,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
