import '/imports.dart';

class NotifPage extends StatefulWidget {
  @override
  State<NotifPage> createState() => _NotifPageState();
}

class _NotifPageState extends State<NotifPage> {
  final NotifController notifCtr = Get.find();
  final ThemeController themeController = Get.find();

  @override
  void initState() {
    notifCtr.fetchNotifications();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          themeController.currentTheme.value.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: themeController.currentTheme.value.hintColor,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 5,
                  left: 5,
                  top: 20,
                  bottom: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: const Icon(Iconsax.arrow_left_2),
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          color: themeController.currentTheme.value.focusColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Notifications',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: themeController
                                        .currentTheme.value.focusColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: TextButton(
                        onPressed: () {
                          notifCtr.clearAllNotifications();
                        },
                        child: Text(
                          'Clear all',
                          style: TextStyle(
                              fontSize: 13,
                              color: themeController
                                  .currentTheme.value.focusColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: RefreshIndicator(
                backgroundColor:
                    themeController.currentTheme.value.scaffoldBackgroundColor,
                color: themeController.currentTheme.value.primaryColor,
                onRefresh: () async {
                  setState(() {
                    notifCtr.refreshData(context);
                  });
                },
                child: StreamBuilder<List<NotificationModel>>(
                  stream: notifCtr.notificationStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color:
                              themeController.currentTheme.value.primaryColor,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Error: ${snapshot.error}')));
                      return Center(
                          child: Text(
                        'An Error Occurred!',
                        style: TextStyle(
                          color: themeController.currentTheme.value.hintColor,
                        ),
                      ));
                    } else if (snapshot.hasData) {
                      final notifications = snapshot.data!;
                      if (notifications.isEmpty) {
                        return Center(
                            child: Text(
                          'No notifications yet.',
                          style: TextStyle(
                            color: themeController.currentTheme.value.hintColor,
                          ),
                        ));
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: ListView.builder(
                          itemCount: notifications.length,
                          itemBuilder: (context, index) {
                            final notification = notifications[index];
                            return Card(
                              color:
                                  themeController.currentTheme.value.cardColor,
                              child: Container(
                                color: themeController
                                    .currentTheme.value.cardColor,
                                child: Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      notification.notif_type == 'partner'
                                          ? Expanded(
                                              flex: 2,
                                              child: Container(
                                                width: 75,
                                                height: 75,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: themeController
                                                        .currentTheme
                                                        .value
                                                        .primaryColor),
                                                child: const Icon(
                                                  Icons.handshake_outlined,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            )
                                          : Expanded(
                                              flex: 2,
                                              child: Container(
                                                width: 75,
                                                height: 75,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: themeController
                                                        .currentTheme
                                                        .value
                                                        .primaryColor),
                                                child: const Icon(
                                                  Iconsax.briefcase,
                                                  color: Colors.white,
                                                  size: 30,
                                                ),
                                              ),
                                            ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        flex: 8,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              notification.content,
                                              style: TextStyle(
                                                color: themeController
                                                    .currentTheme
                                                    .value
                                                    .focusColor,
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              DateFormat('MMMM dd. yyyy hh:mm')
                                                  .format(
                                                      notification.timestamp),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w100,
                                                color: themeController
                                                    .currentTheme
                                                    .value
                                                    .focusColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return Center(
                          child: Text(
                        'No notifications yet.',
                        style: TextStyle(
                          color: themeController.currentTheme.value.hintColor,
                        ),
                      ));
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
