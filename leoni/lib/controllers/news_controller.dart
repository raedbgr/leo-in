import '/imports.dart';

class NewsController extends GetxController {
  final currentUser = Get.find<AuthController>().currentUser;
  var newsList = <NewsModel>[].obs;
  var filteredNews = <NewsModel>[].obs;
  String? selectedCategory;
  var savedNewsList = <NewsModel>[].obs;
  List<String> categories = [
    'All',
    'Company News',
    'Industry Updates',
    'Events',
    'Announcements'
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize with hardcoded news
    loadHardcodedNews();
  }

  Future<void> refreshData(context) async {
    try {
      // Just reload the hardcoded data
      loadHardcodedNews();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh data: $error')),
      );
    }
  }

  void loadHardcodedNews() {
    final hardcodedNews = [
      NewsModel(
        id: 1,
        title: 'Company Reaches New Milestone',
        category: 'Company News',
        date: '2023-08-15',
        content: 'Our company has reached an important milestone with over 1000 successful projects completed this year. This achievement highlights our team\'s dedication and expertise in delivering high-quality solutions to our clients across different industries.',
        imageUrl: 'assets/images/slider1.jpg',
      ),
      NewsModel(
        id: 2,
        title: 'New Office Opening in Berlin',
        category: 'Announcements',
        date: '2023-09-02',
        content: 'We are excited to announce the opening of our new office in Berlin, Germany. This expansion will allow us to better serve our European clients and tap into the rich talent pool in the region. The new office will be fully operational starting October 1st.',
        imageUrl: 'assets/images/slider2.jpeg',
      ),
      NewsModel(
        id: 3,
        title: 'Annual Tech Conference Announced',
        category: 'Events',
        date: '2023-09-10',
        content: 'Mark your calendars! Our annual tech conference will be held on November 15-17 at the Grand Convention Center. Join us for three days of inspiring talks, workshops, and networking opportunities with industry leaders and innovators.',
        imageUrl: 'assets/images/slider3.jpg',
      ),
      NewsModel(
        id: 4,
        title: 'Industry Report: Future Trends',
        category: 'Industry Updates',
        date: '2023-09-18',
        content: 'Our research team has published a comprehensive report on future trends in the industry. The report covers emerging technologies, changing consumer behaviors, and strategic recommendations for businesses to stay competitive in the evolving market landscape.',
        imageUrl: 'assets/images/slider4.png',
      ),
      NewsModel(
        id: 5,
        title: 'New Partnership Announced',
        category: 'Company News',
        date: '2023-09-25',
        content: 'We are pleased to announce our strategic partnership with TechInnovate Inc. This collaboration will enable us to offer integrated solutions that combine our expertise in software development with TechInnovate\'s advanced hardware systems.',
        imageUrl: 'assets/images/slider1.jpg',
      ),
    ];
    
    newsList.assignAll(hardcodedNews);
    filteredNews.assignAll(hardcodedNews);
  }

  void filterNews() {
    if (selectedCategory == null || selectedCategory == 'All') {
      filteredNews.assignAll(newsList);
    } else {
      List<NewsModel> filtered = newsList.where((news) => 
        news.category == selectedCategory).toList();
      filteredNews.assignAll(filtered);
    }
    update();
  }

  void updateCategory(String? category) {
    selectedCategory = category;
    filterNews();
  }

  void clearFilter() {
    selectedCategory = null;
    // Reset filteredNews to show all news
    filteredNews.assignAll(newsList);
    // Update the UI
    update();
  }

  void saveNews(NewsModel currentNews) {
    if (!currentNews.isSaved) {
      savedNewsList.add(currentNews);
      currentNews.isSaved = true;
      update();
    }
  }

  void removeNews(NewsModel currentNews) {
    if (currentNews.isSaved) {
      savedNewsList.remove(currentNews);
      currentNews.isSaved = false;
      update();
    }
  }
} 