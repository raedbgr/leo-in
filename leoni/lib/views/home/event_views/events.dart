import '/imports.dart';

class EventsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  EventsPage({required this.scaffoldKey});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  final EventController controller = Get.find();
  final ThemeController themeController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              color: themeController.currentTheme.value.highlightColor,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.5, 15, 12.5, 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            widget.scaffoldKey.currentState!.openDrawer();
                          },
                          icon: Icon(
                            Iconsax.menu,
                            color:
                                themeController.currentTheme.value.focusColor,
                            size: 30,
                          ),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Events',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color:
                                themeController.currentTheme.value.focusColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    TabBar(
                        labelStyle:
                            const TextStyle(fontWeight: FontWeight.w600),
                        unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.w600,
                            color:
                                themeController.currentTheme.value.hintColor),
                        labelColor:
                            themeController.currentTheme.value.focusColor,
                        indicatorColor: Colors.transparent,
                        overlayColor: WidgetStateColor.transparent,
                        dividerColor: Colors.transparent,
                        tabs: const [
                          Tab(
                            text: 'Upcoming',
                          ),
                          Tab(
                            text: 'Ongoing',
                          ),
                          Tab(
                            text: 'Finished',
                          )
                        ]),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  controller.upcomingEvents.isEmpty
                      ? RefreshIndicator(
                          backgroundColor: themeController
                              .currentTheme.value.scaffoldBackgroundColor,
                          color:
                              themeController.currentTheme.value.primaryColor,
                          onRefresh: () async {
                            setState(() {
                              controller.refreshData(context);
                            });
                          },
                          child: Center(
                            child: Text(
                              'No events yet',
                              style: TextStyle(
                                fontSize: 18,
                                color: themeController
                                    .currentTheme.value.hintColor,
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          backgroundColor: themeController
                              .currentTheme.value.scaffoldBackgroundColor,
                          color:
                              themeController.currentTheme.value.primaryColor,
                          onRefresh: () async {
                            setState(() {
                              controller.refreshData(context);
                            });
                          },
                          child: buildEventListView(controller.upcomingEvents)),
                  controller.ongoingEvents.isEmpty
                      ? RefreshIndicator(
                          backgroundColor: themeController
                              .currentTheme.value.scaffoldBackgroundColor,
                          color:
                              themeController.currentTheme.value.primaryColor,
                          onRefresh: () async {
                            setState(() {
                              controller.refreshData(context);
                            });
                          },
                          child: Center(
                            child: Text(
                              'No events yet',
                              style: TextStyle(
                                fontSize: 18,
                                color: themeController
                                    .currentTheme.value.hintColor,
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          backgroundColor: themeController
                              .currentTheme.value.scaffoldBackgroundColor,
                          color:
                              themeController.currentTheme.value.primaryColor,
                          onRefresh: () async {
                            setState(() {
                              controller.refreshData(context);
                            });
                          },
                          child: buildEventListView(controller.ongoingEvents)),
                  controller.finishedEvents.isEmpty
                      ? RefreshIndicator(
                          backgroundColor: themeController
                              .currentTheme.value.scaffoldBackgroundColor,
                          color:
                              themeController.currentTheme.value.primaryColor,
                          onRefresh: () async {
                            setState(() {
                              controller.refreshData(context);
                            });
                          },
                          child: Center(
                            child: Text(
                              'No events yet',
                              style: TextStyle(
                                fontSize: 18,
                                color: themeController
                                    .currentTheme.value.hintColor,
                              ),
                            ),
                          ),
                        )
                      : RefreshIndicator(
                          backgroundColor: themeController
                              .currentTheme.value.scaffoldBackgroundColor,
                          color:
                              themeController.currentTheme.value.primaryColor,
                          onRefresh: () async {
                            setState(() {
                              controller.refreshData(context);
                            });
                          },
                          child: buildEventListView(controller.finishedEvents)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
