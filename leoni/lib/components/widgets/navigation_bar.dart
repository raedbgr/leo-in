import '/imports.dart';

class MyNavBar extends StatelessWidget {
  final NavigationController controller = Get.find();
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: themeController.currentTheme.value.hintColor,
              width: 1,
            ),
          ),
        ),
        child: NavigationBar(
          height: 70,
          elevation: 0,
          overlayColor: WidgetStateColor.transparent,
          backgroundColor: themeController.currentTheme.value.highlightColor,
          indicatorColor: Colors.transparent,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex:
              controller.getSelectedIndex(controller.selectedPage.value),
          onDestinationSelected: (index) {
            final page = controller.getPageFromIndex(index);
            if (page != null) {
              controller.navigateToPage(page);
            }
          },
          destinations: [
            // NavigationDestination(
            //   icon: Icon(
            //     Iconsax.message5,
            //     size: 30,
            //     color: themeController.currentTheme.value.focusColor,
            //   ),
            //   selectedIcon: Icon(
            //     Iconsax.message5,
            //     size: 30,
            //     color: themeController.currentTheme.value.primaryColor,
            //   ),
            //   label: 'Chat',
            // ),
            NavigationDestination(
              icon: Icon(
                Iconsax.home_15,
                size: 30,
                color: themeController.currentTheme.value.focusColor,
              ),
              selectedIcon: Icon(
                Iconsax.home_15,
                size: 30,
                color: themeController.currentTheme.value.primaryColor,
              ),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.calendar5,
                size: 30,
                color: themeController.currentTheme.value.focusColor,
              ),
              selectedIcon: Icon(
                Iconsax.calendar5,
                size: 30,
                color: themeController.currentTheme.value.primaryColor,
              ),
              label: 'Calendar',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.people5,
                size: 30,
                color: themeController.currentTheme.value.focusColor,
              ),
              selectedIcon: Icon(
                Iconsax.people5,
                size: 30,
                color: themeController.currentTheme.value.primaryColor,
              ),
              label: 'Partners',
            ),
            NavigationDestination(
              icon: Icon(
                Iconsax.frame5,
                size: 30,
                color: themeController.currentTheme.value.focusColor,
              ),
              selectedIcon: Icon(
                Iconsax.frame5,
                size: 30,
                color: themeController.currentTheme.value.primaryColor,
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
