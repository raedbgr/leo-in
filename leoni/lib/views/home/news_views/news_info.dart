import '/imports.dart';

class NewsInfo extends StatefulWidget {
  @override
  State<NewsInfo> createState() => _NewsInfoState();
}

class _NewsInfoState extends State<NewsInfo> {
  final NewsModel currentNews = Get.arguments;
  final NewsController newsController = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      imagePath: currentNews.imageUrl,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: Center(
                              child: Text(
                                currentNews.title,
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
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Category and Date
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: themeController.currentTheme.value.primaryColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              currentNews.category,
                              style: TextStyle(
                                color: themeController.currentTheme.value.primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            'Published on: ${currentNews.date}',
                            style: TextStyle(
                              color: themeController.currentTheme.value.hintColor,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      
                      // Content
                      Text(
                        currentNews.content,
                        style: TextStyle(
                          fontSize: 16,
                          color: themeController.currentTheme.value.focusColor,
                          height: 1.5,
                        ),
                      ),
                      
                      const SizedBox(height: 40),
                      
                      // Share options - Save button removed
                      Center(
                        child: TextButton.icon(
                          onPressed: () {
                            // Share functionality would go here
                          },
                          icon: Icon(
                            Iconsax.share,
                            color: themeController.currentTheme.value.primaryColor,
                          ),
                          label: Text(
                            'Share',
                            style: TextStyle(
                              color: themeController.currentTheme.value.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 