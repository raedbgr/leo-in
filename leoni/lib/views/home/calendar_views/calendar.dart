import '/imports.dart';

class CalendarPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  CalendarPage({required this.scaffoldKey});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final ThemeController themeController = Get.find();
  final EventController eventController = Get.find();
  final CalendarController controller = Get.find();

  @override
  void initState() {
    super.initState();
    controller.loadHardcodedHolidays();
    // Ensure that events are updated when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // This callback is called after the build method completes
      controller.selectedEvents.value =
          controller.getEventsForDay(DateTime.now());
      controller.selectedHolidays.value =
          controller.getHolidaysForDay(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            decoration: themeController.isDarkModeOn.value
                ? BoxDecoration(
                    color: themeController.currentTheme.value.highlightColor,
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  )
                : BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        themeController.currentTheme.value.primaryColor,
                        themeController.currentTheme.value.splashColor
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(12.5, 15, 12.5, 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    widget.scaffoldKey.currentState!
                                        .openDrawer();
                                  },
                                  icon: const Icon(
                                    Iconsax.menu,
                                    size: 30,
                                  ),
                                  color: Colors.white,
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                const Text(
                                  'Calendar',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        // calendar
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: MyCalendar(),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
            child: Column(
              children: [
                // Display selected day's holiday names
                ValueListenableBuilder<List<HolidayModel>>(
                  valueListenable: controller.selectedHolidays,
                  builder: (context, holidays, _) {
                    if (holidays.isEmpty) {
                      return const SizedBox.shrink(); // Hide if no holidays
                    } else {
                      return Column(
                        children: holidays.map((holiday) {
                          return Text(
                            holiday.name,
                            style: TextStyle(
                              color: themeController.currentTheme.value.focusColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        }).toList(),
                      );
                    }
                  },
                ),
                // Display "Events" title
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Events',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: controller.selectedEvents,
                builder: (context, value, _) {
                  if (value.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Center(
                        child: Text(
                          'No events found',
                          style: TextStyle(
                            fontSize: 18,
                            color: themeController.currentTheme.value.hintColor,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: GestureDetector(
                                onTap: () {
                                  Get.toNamed('/eventInfo',
                                      arguments: value[index]);
                                },
                                child: EventCard(currentEvent: value[index])),
                          );
                        },
                      ),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }
}
