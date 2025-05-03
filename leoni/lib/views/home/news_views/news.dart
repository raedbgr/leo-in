import '/imports.dart';

class NewsPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  const NewsPage({required this.scaffoldKey});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final NewsController controller = Get.find();
  final ThemeController themeController = Get.find();
  bool isFilterVisible = false;

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
                children: [
                  IconButton(
                    onPressed: () {
                      widget.scaffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(
                      Iconsax.menu,
                      size: 30,
                      color: themeController.currentTheme.value.focusColor,
                    ),
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  const SizedBox(width: 15),
                  Text(
                    'News',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: themeController.currentTheme.value.focusColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      isFilterVisible = !isFilterVisible; // Toggle filter visibility
                    });
                  },
                  child: Row(
                    children: [
                      Icon(Iconsax.filter,
                          color: themeController.currentTheme.value.focusColor),
                      const SizedBox(width: 10),
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      controller.clearFilter();
                      isFilterVisible = false;
                    });
                  },
                  child: Text(
                    'Clear Filter',
                    style: TextStyle(
                      color: themeController.currentTheme.value.focusColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                )
              ],
            ),
          ),
          Visibility(
            visible: isFilterVisible,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 25),
                    MyDropdown(
                      hintTxt: 'Category',
                      items: controller.categories,
                      onSelected: (value) {
                        controller.updateCategory(value);
                      },
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
              )
            ),
          ),
          Expanded(
            child: Obx(
              () {
                return controller.filteredNews.isEmpty
                  ? RefreshIndicator(
                      backgroundColor: themeController.currentTheme.value.scaffoldBackgroundColor,
                      color: themeController.currentTheme.value.primaryColor,
                      onRefresh: () async {
                        setState(() {
                          controller.refreshData(context);
                        });
                      },
                      child: Center(
                        child: Text(
                          'No news found',
                          style: TextStyle(
                            fontSize: 18,
                            color: themeController.currentTheme.value.hintColor,
                          ),
                        ),
                      ),
                    )
                  : RefreshIndicator(
                      backgroundColor: themeController.currentTheme.value.scaffoldBackgroundColor,
                      color: themeController.currentTheme.value.primaryColor,
                      onRefresh: () async {
                        setState(() {
                          controller.refreshData(context);
                        });
                      },
                      child: ListView.builder(
                        itemCount: controller.filteredNews.length,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        itemBuilder: (context, index) {
                          final news = controller.filteredNews[index];
                          return GestureDetector(
                            onTap: () {
                              Get.toNamed('/newsInfo', arguments: news);
                            },
                            child: buildNewsCard(news),
                          );
                        },
                      ),
                    );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget buildNewsCard(NewsModel news) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: themeController.currentTheme.value.cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // News image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Image.asset(
              news.imageUrl,
              height: 140,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category and date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: themeController.currentTheme.value.primaryColor.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        news.category,
                        style: TextStyle(
                          color: themeController.currentTheme.value.primaryColor,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      news.date,
                      style: TextStyle(
                        color: themeController.currentTheme.value.hintColor,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                
                // Title
                Text(
                  news.title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeController.currentTheme.value.focusColor,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Preview of content
                Text(
                  news.content.length > 120
                      ? '${news.content.substring(0, 120)}...'
                      : news.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: themeController.currentTheme.value.hintColor,
                  ),
                ),
                const SizedBox(height: 8),
                
                // Read More button
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Get.toNamed('/newsInfo', arguments: news);
                    },
                    child: Text(
                      'Read More',
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
        ],
      ),
    );
  }
} 