import '/imports.dart';

class CalendarController extends GetxController {
  final EventController eventController = Get.find();
  late final ValueNotifier<List<EventModel>> selectedEvents;
  late final ValueNotifier<List<HolidayModel>> selectedHolidays;
  var holidays = <HolidayModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadHardcodedHolidays();
  }

  void loadHardcodedHolidays() {
    final now = DateTime.now();
    final currentYear = now.year;
    
    final hardcodedHolidays = [
      HolidayModel(
        name: 'New Year\'s Day',
        date: DateTime(currentYear, 1, 1),
      ),
      HolidayModel(
        name: 'Independence Day',
        date: DateTime(currentYear, 7, 4),
      ),
      HolidayModel(
        name: 'Labor Day',
        date: DateTime(currentYear, 9, 5),
      ),
      HolidayModel(
        name: 'Thanksgiving Day',
        date: DateTime(currentYear, 11, 24),
      ),
      HolidayModel(
        name: 'Christmas Day',
        date: DateTime(currentYear, 12, 25),
      ),
      // Add a holiday near the current date to make it visible in the calendar
      HolidayModel(
        name: 'Company Foundation Day',
        date: DateTime(now.year, now.month, now.day + 2),
      ),
    ];
    
    holidays.assignAll(hardcodedHolidays);
  }

  CalendarController() {
    // Initialize selectedEvents with an empty list or a default value
    selectedEvents = ValueNotifier<List<EventModel>>([]);
    selectedHolidays = ValueNotifier<List<HolidayModel>>([]);
  }

  List<EventModel> getEventsForDay(DateTime day) {
    return eventController.allMonthsEvents
        .where((event) => isSameDay(event.dateB, day))
        .toList();
  }
  
  List<HolidayModel> getHolidaysForDay(DateTime day) {
    return holidays.where((holiday) => isSameDay(holiday.date, day)).toList();
  }
}
