import '/imports.dart';
import 'package:http/http.dart' as http;

class EventController extends GetxController {
  final currentUser = Get.find<AuthController>().currentUser;
  var eventList = <EventModel>[].obs;
  var allMonthsEvents = <EventModel>[].obs;
  var selectedDayEvents = <EventModel>[].obs;
  var userEvents = <EventModel>[].obs;
  List<EventModel> upcomingEvents = <EventModel>[].obs;
  List<EventModel> ongoingEvents = <EventModel>[].obs;
  List<EventModel> finishedEvents = <EventModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHardcodedEvents();
  }

  Future<void> refreshData(context) async {
    try {
      // Load hardcoded events instead of fetching
      loadHardcodedEvents();
    } catch (error) {
      // Handle any errors during the refresh process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh data: $error')),
      );
    }
  }

  void loadHardcodedEvents() {
    final now = DateTime.now();
    
    final hardcodedEvents = [
      EventModel(
        id: 1,
        name: 'Annual Company Conference',
        image: 'assets/images/slider1.jpg',
        location: 'Main Conference Hall',
        region: 'Corporate HQ',
        department: 'All Departments',
        details: 'Join us for our annual company conference where we will discuss company achievements, future goals, and celebrate success stories.',
        schedule: '09:00 AM - Opening Ceremony\n10:30 AM - Keynote Speech\n12:00 PM - Lunch\n01:30 PM - Department Presentations\n04:00 PM - Networking',
        objective: 'To bring together all employees for knowledge sharing and team building.',
        dateB: now.add(const Duration(days: 15)),
        dateE: now.add(const Duration(days: 16)),
      ),
      EventModel(
        id: 2,
        name: 'Tech Innovation Workshop',
        image: 'assets/images/slider2.jpeg',
        location: 'Workshop Room B',
        region: 'R&D Center',
        department: 'Engineering',
        details: 'A hands-on workshop focused on emerging technologies and their application in our industry.',
        schedule: '09:30 AM - Introduction to New Technologies\n11:00 AM - Hands-on Session\n01:00 PM - Lunch\n02:00 PM - Project Planning\n04:30 PM - Presentation of Ideas',
        objective: 'To foster innovation and explore new technological solutions.',
        dateB: now.add(const Duration(days: 5)),
        dateE: now.add(const Duration(days: 5)),
      ),
      EventModel(
        id: 3,
        name: 'Leadership Training',
        image: 'assets/images/slider3.jpg',
        location: 'Training Center',
        region: 'Regional Office',
        department: 'Management',
        details: 'A comprehensive training program designed to enhance leadership skills and management techniques.',
        schedule: '08:30 AM - Leadership Principles\n10:30 AM - Case Studies\n12:30 PM - Lunch\n01:30 PM - Team Management Workshops\n04:00 PM - Q&A Session',
        objective: 'To develop and strengthen leadership capabilities among managers.',
        dateB: now.add(const Duration(days: -5)),
        dateE: now.add(const Duration(days: -3)),
        isParticipated: true,
      ),
      EventModel(
        id: 4,
        name: 'Team Building Day',
        image: 'assets/images/slider4.png',
        location: 'City Park',
        region: 'Outdoor Venue',
        department: 'All Departments',
        details: 'A full day of team-building activities, games, and challenges designed to improve teamwork and communication.',
        schedule: '09:00 AM - Welcome and Team Formation\n10:00 AM - Team Challenges\n12:30 PM - Lunch\n01:30 PM - Outdoor Activities\n04:00 PM - Awards and Closing',
        objective: 'To strengthen team bonds and improve collaboration across departments.',
        dateB: now.add(const Duration(days: -15)),
        dateE: now.add(const Duration(days: -15)),
      ),
      EventModel(
        id: 5,
        name: 'Customer Service Excellence',
        image: 'assets/images/slider1.jpg',
        location: 'Training Room A',
        region: 'Main Office',
        department: 'Customer Support',
        details: 'A specialized training program focused on enhancing customer service skills and handling challenging situations.',
        schedule: '09:00 AM - Customer Service Principles\n11:00 AM - Role-playing Exercises\n12:30 PM - Lunch\n01:30 PM - Case Study Analysis\n03:30 PM - Best Practices Discussion',
        objective: 'To improve customer satisfaction through enhanced service delivery.',
        dateB: now.add(const Duration(days: 10)),
        dateE: now.add(const Duration(days: 11)),
      ),
    ];
    
    eventList.assignAll(hardcodedEvents);
    
    // Add the participated event to userEvents
    userEvents.assignAll(eventList.where((event) => event.isParticipated).toList());
    
    updateEventList();
    updateAllMonthsEvents();
  }

  void participateEvent(EventModel event, context) {
    try {
      event.isParticipated = true;
      userEvents.add(event);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Participation successful'),
        duration: Duration(seconds: 2),
      ));
      Get.back();
    } catch (e) {
      print('Error participating event: $e');
    }
  }

  void updateAllMonthsEvents() {
    allMonthsEvents.assignAll(eventList.toList());
  }

  void updateSelectedDayEvents(DateTime selectedDay) {
    selectedDayEvents.assignAll(allMonthsEvents
        .where((event) => isSameDay(event.dateB, selectedDay))
        .toList());
  }

  void updateEventList() {
    upcomingEvents = eventList.where((event) => event.dateB.isAfter(DateTime.now())).toList();
    ongoingEvents = eventList.where((event) => event.dateB.isBefore(DateTime.now()) && event.dateE.isAfter(DateTime.now())).toList();
    finishedEvents = eventList.where((event) => event.dateE.isBefore(DateTime.now())).toList();
  }
}
