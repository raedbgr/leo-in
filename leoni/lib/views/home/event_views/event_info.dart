import '/imports.dart';

class EventInfo extends StatefulWidget {
  @override
  _EventInfoState createState() => _EventInfoState();
}

class _EventInfoState extends State<EventInfo> {
  final EventController controller = Get.find();
  final ThemeController themeController = Get.find();
  final EventModel currentEvent = Get.arguments;
  late final Color color;

  @override
  Widget build(BuildContext context) {
    if (currentEvent.dateB.isAfter(DateTime.now())) {
      color = Colors.cyan;
    } else if (currentEvent.dateB.isBefore(DateTime.now()) &&
        currentEvent.dateE.isAfter(DateTime.now())) {
      color = const Color(0xff69D138);
    } else if (currentEvent.dateE.isBefore(DateTime.now())) {
      color = const Color(0xffEA2D2D);
    }

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: themeController.currentTheme.value.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 175,
                    child: Stack(children: [
                      MyImageFilter(
                        isBase64: false,
                        imagePath: 'assets/images/event.jpeg',
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    icon: const Icon(
                                      Iconsax.arrow_left_2,
                                      size: 30,
                                      color: Colors.white,
                                    )),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30),
                              child: Center(
                                child: Text(
                                  currentEvent.name,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 135, right: 25),
                        child: Center(
                          child: Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: color),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('dd').format(currentEvent.dateB),
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                ),
                                Text(
                                  DateFormat('MMM').format(currentEvent.dateB),
                                  style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.calendar,
                                color: color,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Text(
                                DateFormat('EEE. MMMM dd. yyyy \'at\' hh:mm a')
                                    .format(currentEvent.dateB),
                                style: TextStyle(
                                  color: themeController.currentTheme.value.focusColor,
                                    fontWeight: FontWeight.w500, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Iconsax.location,
                                color: color,
                              ),
                              const SizedBox(
                                width: 7,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentEvent.location,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: themeController.currentTheme.value.focusColor,
                                        fontSize: 15),
                                  ),
                                  Text(
                                    currentEvent.region,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15,
                                        color: themeController.currentTheme.value.hintColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              ),
              TabBar(
                  labelStyle: const TextStyle(fontWeight: FontWeight.bold),
                  unselectedLabelStyle:
                      TextStyle(fontWeight: FontWeight.normal, color: themeController.currentTheme.value.hintColor),
                  labelColor: themeController.currentTheme.value.focusColor,
                  indicatorColor: Colors.transparent,
                  overlayColor: WidgetStateColor.transparent,
                  dividerColor: Colors.transparent,
                  tabs: const [
                    Tab(
                      text: 'Details',
                    ),
                    Tab(
                      text: 'Event Schedule',
                    ),
                    Tab(
                      text: 'Objective',
                    )
                  ]),
              Expanded(
                  child: TabBarView(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: Text(currentEvent.details,
                        style: TextStyle(
                            color: themeController.currentTheme.value.focusColor,)),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: Text(currentEvent.schedule,
                      style: TextStyle(
                        color: themeController.currentTheme.value.focusColor,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: Text(currentEvent.objective,
                      style: TextStyle(
                        color: themeController.currentTheme.value.focusColor,
                      ),
                    ),
                  ),
                ),
              ])),
              if (currentEvent.dateB.isAfter(DateTime.now()) &&
                  !currentEvent.isParticipated)
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      MaterialButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: themeController
                                    .currentTheme.value.scaffoldBackgroundColor,
                                content: Text(
                                    'Do you want to Participate in this Event ?',
                                    style: TextStyle(
                                      color: themeController.currentTheme.value.focusColor,
                                    )),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      controller.participateEvent(currentEvent, context);
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
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        child: MyButton(
                          text: 'Participate',
                          color: color,
                          outline: false,
                          width: 135,
                          height: 50,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
