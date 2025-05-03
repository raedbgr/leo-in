import '/imports.dart';

class HomePage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const HomePage({required this.scaffoldKey});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final UserModel currentUser = Get.find<AuthController>().currentUser;
  final ThemeController themeController = Get.find();
  final HomeController controller = Get.find();
  final NotifController notifCtr = Get.find();
  final NewsController newsController = Get.find();
  final NavigationController navController = Get.find();
  final PartnerController partController = Get.find();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: themeController.currentTheme.value.highlightColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.5, 15, 12.5, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          widget.scaffoldKey.currentState!.openDrawer();
                        },
                        icon: const Icon(
                          Iconsax.menu,
                          size: 30,
                        ),
                        color: themeController.currentTheme.value.focusColor,
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      const SizedBox(width: 15),
                      Text(
                        'LEO-IN',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                          color:
                              themeController.currentTheme.value.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  StreamBuilder<List<NotificationModel>>(
                    stream: notifCtr.notificationStream(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return MyBadge(
                          posX: -1,
                          posY: 10,
                          value: '${snapshot.data!.length}',
                          color:
                              themeController.currentTheme.value.primaryColor,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          iconChild: IconButton(
                            onPressed: () {
                              Get.toNamed('/notif');
                            },
                            icon: Icon(
                              Iconsax.notification,
                              size: 30,
                              color:
                                  themeController.currentTheme.value.focusColor,
                            ),
                          ),
                        );
                      } else {
                        return IconButton(
                          onPressed: () {
                            Get.toNamed('/notif');
                          },
                          icon: Icon(
                            Iconsax.notification,
                            size: 30,
                            color:
                                themeController.currentTheme.value.focusColor,
                          ),
                        );
                      }
                    },
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
                  controller.refreshData(context);
                });
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Text(
                            'Welcome,',
                            style: TextStyle(
                              fontSize: 20,
                              color:
                                  themeController.currentTheme.value.focusColor,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              currentUser.name,
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: themeController
                                    .currentTheme.value.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      EventSlider(),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Popular Partners',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  themeController.currentTheme.value.focusColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navController.navigateToPage('/partners');
                            },
                            style: const ButtonStyle(
                                overlayColor: WidgetStateColor.transparent),
                            child: Text(
                              'See all',
                              style: TextStyle(
                                color: themeController
                                    .currentTheme.value.hintColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      FutureBuilder(
                          future: partController.partnerFutureBuilder(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(
                                child: CircularProgressIndicator(
                                  color: themeController
                                      .currentTheme.value.primaryColor,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text('Error: ${snapshot.error}')));
                              return Center(
                                  child: Text(
                                'An Error Occurred!',
                                style: TextStyle(
                                  color: themeController
                                      .currentTheme.value.hintColor,
                                ),
                              ));
                            } else if (snapshot.hasData) {
                              final partners = snapshot.data!;
                              if (partners.isEmpty) {
                                return Center(
                                    child: Text(
                                  'No Partners yet.',
                                  style: TextStyle(
                                    color: themeController
                                        .currentTheme.value.hintColor,
                                  ),
                                ));
                              }
                              return ScrollYItems(
                                itemCount:
                                    min(partController.partnerList.length, 3),
                                itemBuilder: (index) => GestureDetector(
                                  onTap: () {
                                    Get.toNamed('/partnerInfo',
                                        arguments:
                                            partController.partnerList[index]);
                                  },
                                  child: SquareContainer(index: index),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('No partners found'),
                                ),
                              );
                              return Center(
                                  child: Text(
                                'No Partners yet.',
                                style: TextStyle(
                                  color: themeController
                                      .currentTheme.value.hintColor,
                                ),
                              ));
                            }
                          }),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Company News',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  themeController.currentTheme.value.focusColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navController.navigateToPage('/news');
                              newsController.updateCategory('Company News');
                            },
                            style: const ButtonStyle(
                              overlayColor: WidgetStateColor.transparent,
                            ),
                            child: Text(
                              'See all',
                              style: TextStyle(
                                color: themeController
                                    .currentTheme.value.hintColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      buildNewsSection('Company News'),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Announcements',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  themeController.currentTheme.value.focusColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navController.navigateToPage('/news');
                              newsController.updateCategory('Announcements');
                            },
                            style: const ButtonStyle(
                              overlayColor: WidgetStateColor.transparent,
                            ),
                            child: Text(
                              'See all',
                              style: TextStyle(
                                color: themeController
                                    .currentTheme.value.hintColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      buildNewsSection('Announcements'),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Industry Updates',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color:
                                  themeController.currentTheme.value.focusColor,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              navController.navigateToPage('/news');
                              newsController.updateCategory('Industry Updates');
                            },
                            style: const ButtonStyle(
                              overlayColor: WidgetStateColor.transparent,
                            ),
                            child: Text(
                              'See all',
                              style: TextStyle(
                                color: themeController
                                    .currentTheme.value.hintColor,
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      buildNewsSection('Industry Updates'),
                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  Widget buildNewsSection(String category) {
    List<NewsModel> newsList = newsController.newsList
        .where((news) => news.category == category)
        .toList();
        
    if (newsList.isEmpty) {
      return Center(
        child: Text(
          'No news found',
          style: TextStyle(
            color: themeController.currentTheme.value.hintColor,
          ),
        ),
      );
    }
    
    return Column(
      children: List.generate(
        min(newsList.length, 2),
        (index) => GestureDetector(
          onTap: () {
            Get.toNamed('/newsInfo', arguments: newsList[index]);
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: themeController.currentTheme.value.cardColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 3,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    newsList[index].imageUrl,
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        newsList[index].title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: themeController.currentTheme.value.focusColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        newsList[index].date,
                        style: TextStyle(
                          fontSize: 12,
                          color: themeController.currentTheme.value.hintColor,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        newsList[index].content.substring(0, min(80, newsList[index].content.length)) + '...',
                        style: TextStyle(
                          fontSize: 13,
                          color: themeController.currentTheme.value.hintColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
