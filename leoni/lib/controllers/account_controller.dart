import '/imports.dart';

class AccountController extends GetxController {
  UserModel currentUser = Get.find<AuthController>().currentUser;
  final bioController = TextEditingController();
  final skillsController = TextEditingController();
  final hobbiesController = TextEditingController();
  final langsController = TextEditingController();
  String? base64Image;

  @override
  void onInit() {
    super.onInit();
    bioController.text = currentUser.bio;
    skillsController.text = currentUser.skills;
    hobbiesController.text = currentUser.hobbies;
    langsController.text = currentUser.langs;
    base64Image = currentUser.imagePath;
  }

  void updateUserData() {
    final updatedUser = UserModel(
      name: currentUser.name,
      uniqueName: currentUser.uniqueName,
      imagePath: base64Image ?? '',
      isAdmin: currentUser.isAdmin,
      region: currentUser.region,
      department: currentUser.department,
      team: currentUser.team,
      post: currentUser.post,
      bio: bioController.text,
      skills: skillsController.text,
      hobbies: hobbiesController.text,
      langs: langsController.text,
    );

    currentUser = updatedUser;
    update();
  
  }

  Future<void> pickImageFromGallery() async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final bytes = await pickedFile.readAsBytes();
        base64Image = base64Encode(bytes);
        update(); // Trigger an update if needed
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }
}
