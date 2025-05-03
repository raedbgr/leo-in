import '/imports.dart';

class AuthController extends GetxController {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  
  // Hardcoded user data
  UserModel currentUser = UserModel(
    name: 'John Smith',
    uniqueName: 'john.smith@example.com',
    imagePath: 'assets/images/employee.jpg',
    isAdmin: true,
    region: 'Europe',
    department: 'Engineering',
    team: 'Mobile Development',
    post: 'Senior Developer',
    bio: 'Passionate about Flutter development',
    skills: 'Flutter, Dart, Firebase, REST APIs',
    hobbies: 'Coding, Reading, Hiking',
    langs: 'English, French',
  );
  
  String? accessToken = 'dummy_token'; // Hardcoded token
  String userName = 'John Smith';
  String userUniqueName = 'john.smith@example.com';

  @override
  void onInit() {
    super.onInit();
    // Skip token loading and use hardcoded data
    // Don't auto-navigate on init, let the login page handle this
  }

  // Set hardcoded user and navigate to home - public method
  void setHardcodedUser() async {
    try {
      // Store dummy token for app functionality
      await _secureStorage.write(key: 'accessToken', value: accessToken);
      // Navigate to the main navigation page which handles its own scaffoldKey
      Get.offAllNamed('/');
    } catch (e) {
      print('Error setting hardcoded user: $e');
    }
  }

  Future<void> initAppLinks() async {
    // Keep this method but skip actual implementation
    // Don't auto-navigate, let the login page handle it
  }

  void _handleUri(Uri uri) {
    // No need to handle URI for hardcoded auth
  }

  String? _extractAccessToken(Uri uri) {
    return 'dummy_token';
  }

  Future<void> _loadStoredToken() async {
    // This method is no longer auto-called
    accessToken = await _secureStorage.read(key: 'accessToken');
  }

  Future<void> launchUri(String url) async {
    // Skip external authentication and use hardcoded user
    setHardcodedUser();
  }

  Future<void> convertToken(String token) async {
    // No conversion needed for hardcoded data
    userName = currentUser.name;
    userUniqueName = currentUser.uniqueName;
  }

  Future<UserModel?> fetchUserFromDatabase(String email) async {
    // Return hardcoded user instead of fetching from database
    return currentUser;
  }

  void logout() async {
    try {
      await _secureStorage.delete(key: 'accessToken');
      accessToken = null;
      // Reset to default hardcoded user
      currentUser = UserModel(
        name: 'John Smith',
        uniqueName: 'demo.user@example.com',
        imagePath: 'assets/images/employee.jpg',
        isAdmin: true,
        region: 'Europe',
        department: 'Engineering',
        team: 'Mobile Development',
        post: 'Senior Developer',
        bio: 'Passionate about Flutter development',
        skills: 'Flutter, Dart, Firebase, REST APIs',
        hobbies: 'Coding, Reading, Hiking',
        langs: 'English, French',
      );
      Get.offAllNamed('/login');
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
