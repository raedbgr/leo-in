import '/imports.dart';

class MyCalendar extends StatefulWidget {
  @override
  State<MyCalendar> createState() => _MyCalendarState();
}

class _MyCalendarState extends State<MyCalendar> {
  final CalendarController controller = Get.find();
  final EventController eventController = Get.find();
  final ThemeController themeController = Get.find();
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Update the selected events for the current day
      controller.selectedEvents.value = controller.getEventsForDay(_focusedDay);
    });
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        controller.selectedEvents.value =
            controller.getEventsForDay(selectedDay);
        controller.selectedHolidays.value = controller
            .getHolidaysForDay(selectedDay);
      });
    }
  }

  List<dynamic> _getMarkersForDay(DateTime day) {
    // Combine events and holidays for the given day
    final events = controller.getEventsForDay(day);
    final holidays = controller.getHolidaysForDay(day);
    return [...events, ...holidays]; // Return combined list
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: _focusedDay,
      onDaySelected: _onDaySelected,
      eventLoader: _getMarkersForDay,
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },
      firstDay: DateTime(1901),
      lastDay: DateTime(2030),
      headerStyle: const HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        leftChevronIcon: Icon(Iconsax.arrow_left_2, color: Colors.white),
        rightChevronIcon: Icon(
          Iconsax.arrow_right_3,
          color: Colors.white,
        ),
      ),
      daysOfWeekStyle: const DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Colors.white, fontSize: 12),
        weekendStyle: TextStyle(color: Colors.white, fontSize: 12),
      ),
      calendarStyle: CalendarStyle(
        cellMargin: const EdgeInsets.all(5),
        defaultTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        weekendTextStyle: TextStyle(
          color: themeController.isDarkModeOn.value
              ? themeController.currentTheme.value.focusColor
              : Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        selectedTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        outsideTextStyle:
            TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.4)),
        todayDecoration: const BoxDecoration(
            color: Color(0xff3B38D1), shape: BoxShape.circle),
        todayTextStyle: const TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        markerDecoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        markersAlignment: Alignment.topCenter,
        markersMaxCount: 1,
      ),
    );
  }
}
