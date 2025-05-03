import '/imports.dart';
import 'package:http/http.dart' as http;

class NotifController extends GetxController {
  var notifications = <NotificationModel>[].obs;
  final FlutterSecureStorage notifSecureStorage = const FlutterSecureStorage();
  final currentUser = Get.find<AuthController>().currentUser;
  var unreadCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _initializeUnreadCount();
  }

  Future<void> refreshData(context) async {
    try {
      // Example: Fetch data from your controllers
      await fetchNotifications();
    } catch (error) {
      // Handle any errors during the refresh process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh data: $error')),
      );
    }
  }

  void _initializeUnreadCount() async {
    await fetchNotifications();
    final storedIds = await getStoredIds();
    final newNotifications = notifications.where((notif) {
      return !storedIds['partnerIds']!.contains(notif.typeId.toString());
    }).toList();
    unreadCount.value = newNotifications.length;
  }

  Stream<List<NotificationModel>> notificationStream() async* {
    while (true) {
      await fetchNotifications(); // Fetch the latest notifications
      _initializeUnreadCount(); // update unread notification count
      yield notifications; // Emit the latest notifications
    }
  }

  Future<void> storePartners(List<String> newPartnerIds) async {
    try {
      String partnerIds = newPartnerIds.join(',');

      if (kIsWeb) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('partnerIds', partnerIds);
      } else {
        await notifSecureStorage.write(key: 'partnerIds', value: partnerIds);
      }
    } catch (e) {
      // Handle error
      print('Error storing partner IDs: $e');
    }
  }

  Future<Map<String, List<String>>> getStoredIds() async {
    try {
      String? partnerIdsStr;

      if (kIsWeb) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        partnerIdsStr = prefs.getString('partnerIds');
      } else {
        partnerIdsStr = await notifSecureStorage.read(key: 'partnerIds');
      }
      return {
        'partnerIds': partnerIdsStr?.split(',') ?? [],
      };
    } catch (e) {
      // Handle error
      print('Error retrieving partner IDs: $e');
      return {'partnerIds': []};
    }
  }

  void postNotification(NotificationModel notification) async {
    final url = Uri.parse('https://leoni.com:4444/add-notification');
    final notifResponse = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'userId': notification.userId,
        'notif_type': notification.notif_type,
        'content': notification.content,
        'typeId': notification.typeId,
      }),
    );
    if (notifResponse.statusCode == 200) {
      print('Notification added');
      update();
    } else {
      print('Failed to add notification');
    }
  }

  Future<void> fetchNotifications() async {
    try {
      final url = Uri.parse(
          'https://leoni.com:4444/notifications?userId=${currentUser.uniqueName}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        List<NotificationModel> fetchedNotifications = jsonResponse
            .map((notif) => NotificationModel.fromJson(notif))
            .toList();

        notifications.assignAll(fetchedNotifications);
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      final url = Uri.parse(
          'https://leoni.com:4444/delete-notifications?userId=${currentUser.uniqueName}');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        notifications.clear(); // Clear the local list of notifications
        unreadCount.value = 0; // Reset the unread count
        print('All notifications cleared');
      } else {
        throw Exception('Failed to clear notifications');
      }
    } catch (e) {
      print('Error clearing notifications: $e');
    }
  }
}
