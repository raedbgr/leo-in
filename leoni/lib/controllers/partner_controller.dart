import '/imports.dart';

class PartnerController extends GetxController {
  TextEditingController searchController = TextEditingController();
  final currentUser = Get.find<AuthController>().currentUser;
  List<PartnerModel> searchList = [];
  String searchPartnerText = '';
  var partnerList = <PartnerModel>[].obs;
  var likePartnerList = <PartnerModel>[].obs;
  var partnerCategories = <String>[].obs;

  void onInit() {
    super.onInit();
    loadHardcodedPartners();
  }

  Future<void> refreshData(context) async {
    try {
      // Just reload the hardcoded data
      loadHardcodedPartners();
    } catch (error) {
      // Handle any errors during the refresh process
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh data: $error')),
      );
    }
  }

  Future<List<PartnerModel>> partnerFutureBuilder() async {
    try {
      loadHardcodedPartners(); // Call your existing method
      return partnerList; // Return the updated partnerList
    } catch (e) {
      print('Error loading partners for builder: $e');
      return []; // Return an empty list in case of an error
    }
  }

  void loadHardcodedPartners() {
    try {
      // Clear existing lists
      likePartnerList.clear();
      
      // Create hardcoded partner data
      List<PartnerModel> hardcodedPartners = [
        PartnerModel(
          id: 1,
          name: 'Tunisie Telecom',
          category: 'Telecommunications',
          imagePath: 'https://upload.wikimedia.org/wikipedia/fr/2/2e/Tunisie_Telecom_Logo.svg',
          address: '19 Rue Mohamed Badra, Tunis 1073',
          phone: '+216 71 123 456',
          email: 'contact@tunisietelecom.tn',
          description: 'Leading telecommunications provider in Tunisia offering mobile, internet and fixed line services.',
          offers: 'Special mobile plans for employees, 20% discount on internet packages, Family plans at reduced rates',
          website: 'https://www.tunisietelecom.tn',
          facebook: 'https://www.facebook.com/tunisietelecom',
          instagram: 'https://www.instagram.com/tunisietelecom',
          totalLikes: 45,
          isLiked: false,
        ),
        PartnerModel(
          id: 2,
          name: 'UIB Bank',
          category: 'Banking',
          imagePath: 'https://www.uib.com.tn/sites/all/themes/uib/logo.png',
          address: '65 Avenue Habib Bourguiba, Tunis 1000',
          phone: '+216 71 218 000',
          email: 'service.client@uib.com.tn',
          description: 'Union Internationale de Banques, a leading banking institution offering financial services to individuals and businesses.',
          offers: 'Preferential rates on loans, Free premium credit card, Investment advisory services, Reduced fees on international transfers',
          website: 'https://www.uib.com.tn',
          facebook: 'https://www.facebook.com/uibbank',
          instagram: 'https://www.instagram.com/uibbank',
          totalLikes: 38,
          isLiked: true,
        ),
        PartnerModel(
          id: 3,
          name: 'Carrefour',
          category: 'Retail',
          imagePath: 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5b/Carrefour_logo.svg/1200px-Carrefour_logo.svg.png',
          address: 'Centre Commercial Carrefour, La Marsa 2070',
          phone: '+216 71 854 200',
          email: 'service.client@carrefour.tn',
          description: 'International hypermarket chain offering a wide range of groceries, electronics, household items and more.',
          offers: '5% discount on all purchases, Special loyalty program for employees, Monthly promotions on selected items',
          website: 'https://www.carrefour.tn',
          facebook: 'https://www.facebook.com/carrefourtunisie',
          instagram: 'https://www.instagram.com/carrefourtunisie',
          totalLikes: 56,
          isLiked: false,
        ),
        PartnerModel(
          id: 4,
          name: 'Royal Wellness',
          category: 'Health',
          imagePath: 'https://img.freepik.com/premium-vector/luxury-royal-wellness-spa-logo-design_139869-110.jpg',
          address: '27 Rue du Lac Victoria, Les Berges du Lac, Tunis 1053',
          phone: '+216 71 960 333',
          email: 'info@royalwellness.tn',
          description: 'Premium fitness center and spa offering gym equipment, swimming pool, classes, and wellness treatments.',
          offers: '20% off yearly membership, Free access to group classes, Discounted spa treatments, Free fitness assessment',
          website: 'https://www.royalwellness.tn',
          facebook: 'https://www.facebook.com/royalwellness',
          instagram: 'https://www.instagram.com/royalwellness',
          totalLikes: 72,
          isLiked: true,
        ),
        PartnerModel(
          id: 5,
          name: 'Samsung Tunisia',
          category: 'Electronics',
          imagePath: 'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Samsung_Logo.svg/2560px-Samsung_Logo.svg.png',
          address: 'Immeuble Horizon, Les Berges du Lac 2, Tunis 1053',
          phone: '+216 36 036 000',
          email: 'support@samsung.tn',
          description: 'Leading electronics manufacturer offering smartphones, TVs, home appliances and more.',
          offers: '15% discount on smartphones, 10% off on TVs and home appliances, Extended warranty on all products, Priority service at service centers',
          website: 'https://www.samsung.com/tn',
          facebook: 'https://www.facebook.com/SamsungTunisie',
          instagram: 'https://www.instagram.com/samsungtunisie',
          totalLikes: 83,
          isLiked: false,
        ),
        PartnerModel(
          id: 6,
          name: 'Hertz Car Rental',
          category: 'Automotive',
          imagePath: 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Hertz_Logo.svg/2560px-Hertz_Logo.svg.png',
          address: 'Tunis Carthage International Airport, Tunis 1080',
          phone: '+216 71 832 411',
          email: 'reservations@hertz.tn',
          description: 'Global car rental service providing a wide range of vehicles for business and leisure travel.',
          offers: '15% discount on all rentals, Free upgrade when available, Additional driver at no cost, Weekly special offers',
          website: 'https://www.hertz.tn',
          facebook: 'https://www.facebook.com/hertztunisie',
          instagram: 'https://www.instagram.com/hertztunisie',
          totalLikes: 29,
          isLiked: false,
        ),
        PartnerModel(
          id: 7,
          name: 'Carthage Thalasso Resort',
          category: 'Hospitality',
          imagePath: 'https://dynamic-media-cdn.tripadvisor.com/media/photo-o/16/41/ce/fb/the-residence-tunis.jpg?w=700&h=-1&s=1',
          address: 'Les Côtes de Carthage, Gammarth 2070',
          phone: '+216 71 910 111',
          email: 'reservations@carthagethalasso.com',
          description: 'Luxury beachfront resort with spa, thalassotherapy center, fine dining and conference facilities.',
          offers: '25% discount on room rates, Complimentary access to spa facilities, Special rates for events and meetings, 15% off dining',
          website: 'https://www.carthagethalasso.com',
          facebook: 'https://www.facebook.com/carthageresort',
          instagram: 'https://www.instagram.com/carthageresort',
          totalLikes: 64,
          isLiked: true,
        ),
        PartnerModel(
          id: 8,
          name: 'Air France',
          category: 'Travel',
          imagePath: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Air_France_Logo.svg/2560px-Air_France_Logo.svg.png',
          address: '7 Avenue Habib Bourguiba, Tunis 1001',
          phone: '+216 70 019 224',
          email: 'serviceclient.tunisie@airfrance.fr',
          description: 'International airline providing passenger and cargo transportation to destinations worldwide.',
          offers: '10% discount on all flights, Extra baggage allowance, Priority boarding, Free seat selection, Access to business lounges at discounted rates',
          website: 'https://www.airfrance.tn',
          facebook: 'https://www.facebook.com/airfrance',
          instagram: 'https://www.instagram.com/airfrance',
          totalLikes: 47,
          isLiked: false,
        ),
      ];

      // Mark some partners as liked by the current user
      for (var partner in hardcodedPartners) {
        if (partner.isLiked) {
          likePartnerList.add(partner);
        }
      }

      // Sort partners by total likes in descending order
      hardcodedPartners.sort((a, b) => b.totalLikes!.compareTo(a.totalLikes!));

      // Extract unique categories
      Set<String> categories = hardcodedPartners.map((p) => p.category).toSet();
      
      // Update observable lists
      partnerList.assignAll(hardcodedPartners);
      partnerCategories.assignAll(categories.toList());
      
      // Initialize search list
      updateSearchList('');
      
    } catch (e) {
      print('Error loading hardcoded partners: $e');
    }
  }

  void likePartner(PartnerModel currentPartner) {
    try {
      likePartnerList.add(currentPartner);
      currentPartner.isLiked = true;
      update();
    } catch (e) {
      print('Error liking partner: $e');
    }
  }

  void dislikePartner(PartnerModel currentPartner) {
    try {
      likePartnerList.remove(currentPartner);
      currentPartner.isLiked = false;
      update();
    } catch (e) {
      print('Error disliking partner: $e');
    }
  }

  void updateSearchList(String searchText) {
    searchList = partnerList
        .where((element) =>
            element.name.toLowerCase().contains(searchText.toLowerCase()) ||
            element.category.toLowerCase().contains(searchText.toLowerCase()))
        .toList();
  }

  void launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $phoneNumber';
    }
  }
}
