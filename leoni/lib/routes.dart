import 'imports.dart';

class Routes {
  static final routes = [
    GetPage(name: '/login', page: () => LoginPage()),
    GetPage(name: '/', page: () => NavigationPage()),
    GetPage(
      name: '/home', 
      page: () {
        GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
        return HomePage(scaffoldKey: key);
      }
    ),
    GetPage(
      name: '/partners', 
      page: () {
        GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
        return PartnersPage(scaffoldKey: key);
      }
    ),
    GetPage(
      name: '/account', 
      page: () {
        GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
        return AccountPage(scaffoldKey: key);
      }
    ),
    GetPage(
      name: '/calendar', 
      page: () {
        GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
        return CalendarPage(scaffoldKey: key);
      }
    ),
    GetPage(name: '/profile', page: () => ProfilePage(), transition: Transition.rightToLeft),
    GetPage(name: '/editPf', page: () => EditProfilePage()),
    GetPage(
      name: '/news', 
      page: () {
        GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
        return NewsPage(scaffoldKey: key);
      },
      transition: Transition.rightToLeft
    ),
    GetPage(name: '/notif', page: () => NotifPage(), transition: Transition.rightToLeft),
    GetPage(
      name: '/events', 
      page: () {
        GlobalKey<ScaffoldState> key = GlobalKey<ScaffoldState>();
        return EventsPage(scaffoldKey: key);
      },
      transition: Transition.rightToLeft
    ),
    GetPage(name: '/service', page: () => ServicePage(), transition: Transition.rightToLeft),
    GetPage(name: '/support', page: () => SupportPage(), transition: Transition.rightToLeft),
    GetPage(name: '/eventInfo', page: () => EventInfo(), transition: Transition.rightToLeft),
    GetPage(name: '/partnerInfo', page: () => PartnerInfo(), transition: Transition.rightToLeft),
    GetPage(name: '/newsInfo', page: () => NewsInfo(), transition: Transition.rightToLeft),
    GetPage(name: '/leaveRequest', page: () => LeaveRequestPage(), transition: Transition.rightToLeft),
    GetPage(name: '/documentRequest', page: () => DocumentRequestPage(), transition: Transition.rightToLeft),
  ];
}
