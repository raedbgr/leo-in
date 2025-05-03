import '/imports.dart';

class PartnersPage extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  PartnersPage({required this.scaffoldKey});

  @override
  _PartnersPageState createState() => _PartnersPageState();
}

class _PartnersPageState extends State<PartnersPage> {
  final ThemeController themeController = Get.find();
  final HomeController controller = Get.find();
  final PartnerController partController = Get.find();

  @override
  void initState() {
    super.initState();
    partController.updateSearchList('');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Container(
            color: themeController.currentTheme.value.highlightColor,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12.5, 15, 12.5, 5),
              child: Column(
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
                        'Partners',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                    child: Column(
                      children: [
                        MySearchBar(
                          controller: partController.searchController,
                          onSubmittedFunction: (covariant) {
                            setState(() {
                              partController.searchPartnerText = covariant;
                              partController.updateSearchList(partController.searchPartnerText);
                              partController.searchController.clear();
                            });
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 50,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                allPartners(''),
                                const SizedBox(
                                  width: 10,
                                ),
                                ...partController.partnerCategories
                                    .map((category) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child:
                                              singlePartnerCategory(category),
                                        )),
                              ],
                            ),
                          ),
                        )
                      ],
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
                  partController.refreshData(context);
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 15,
                            childAspectRatio: 3 / 4),
                    itemCount: partController.searchList.length,
                    itemBuilder: (BuildContext context, int index) {
                      final partner = partController.searchList[index];
                      return GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            '/partnerInfo',
                            arguments: partner,
                          );
                        },
                        child: Column(
                          children: [
                            AspectRatio(
                              aspectRatio: 1, // Makes the container square
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    partner.imagePath,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: Colors.grey[300],
                                        child: const Center(
                                          child: Icon(
                                            Icons.image_not_supported,
                                            color: Colors.grey,
                                            size: 50,
                                          ),
                                        ),
                                      );
                                    },
                                    loadingBuilder: (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return Container(
                                        color: Colors.grey[200],
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            value: loadingProgress.expectedTotalBytes != null
                                                ? loadingProgress.cumulativeBytesLoaded /
                                                    loadingProgress.expectedTotalBytes!
                                                : null,
                                            color: themeController.currentTheme.value.primaryColor,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: Text(
                                  partner.name,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: themeController
                                          .currentTheme.value.focusColor),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget allPartners(String searchText) {
    return MaterialButton(
      onPressed: () {
        setState(() {
          partController.searchPartnerText = searchText;
          partController.updateSearchList(searchText);
        });
      },
      elevation: 0,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: (searchText == partController.searchPartnerText)
          ? themeController.currentTheme.value.primaryColor
          : const Color(0xffD9D9D9),
      textColor: (searchText == partController.searchPartnerText)
          ? Colors.white
          : Colors.black,
      child: const Text('All'),
    );
  }

  Widget singlePartnerCategory(String searchText) {
    return MaterialButton(
      onPressed: () {
        setState(() {
          partController.searchPartnerText = searchText;
          partController.updateSearchList(searchText);
        });
      },
      elevation: 0,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: (searchText == partController.searchPartnerText)
          ? themeController.currentTheme.value.primaryColor
          : const Color(0xffD9D9D9),
      textColor: (searchText == partController.searchPartnerText)
          ? Colors.white
          : Colors.black,
      child: Text(searchText),
    );
  }
}
