import '/imports.dart';

class PartnerInfo extends StatefulWidget {
  final PartnerModel currentPartner = Get.arguments;
  @override
  State<PartnerInfo> createState() => _PartnerInfoState();
}

class _PartnerInfoState extends State<PartnerInfo> {
  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    final PartnerController controller = Get.find();
    return Scaffold(
      backgroundColor:
          themeController.currentTheme.value.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                color: themeController.currentTheme.value.hintColor,
              ))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12.5, 15, 12.5, 15),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Iconsax.arrow_left_2,
                        size: 30,
                        color: themeController.currentTheme.value.focusColor,
                      ),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                    ),
                    const SizedBox(width: 15),
                    Flexible(
                      child: Text(
                        widget.currentPartner.name,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: themeController.currentTheme.value.focusColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 25, horizontal: 20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: const Color(0xffC1C1C1)),
                              borderRadius: BorderRadius.circular(10),
                              color:
                                  themeController.currentTheme.value.cardColor),
                          child: Column(
                            children: [
                              Container(
                                height: 100,
                                width: 100,
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black),
                                child: ClipOval(
                                    child: Image.network(
                                      widget.currentPartner.imagePath,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          color: Colors.grey[300],
                                          child: const Center(
                                            child: Icon(
                                              Icons.image_not_supported,
                                              color: Colors.grey,
                                              size: 40,
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
                                    )),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                widget.currentPartner.name,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                    color: themeController
                                        .currentTheme.value.focusColor),
                              ),
                              Text(
                                widget.currentPartner.email,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: themeController
                                        .currentTheme.value.focusColor),
                              ),
                              Text(
                                widget.currentPartner.address,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: themeController
                                        .currentTheme.value.focusColor),
                              ),
                              const SizedBox(
                                width: 1,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                widget.currentPartner.description,
                                style: TextStyle(
                                    color: themeController
                                        .currentTheme.value.focusColor,
                                    fontSize: 16),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      controller.makePhoneCall(
                                          widget.currentPartner.phone);
                                    },
                                    child: MyButton(
                                        text: 'Contact',
                                        color: themeController
                                            .currentTheme.value.primaryColor,
                                        outline: true,
                                        width: 115,
                                        height: 30,
                                        fontSize: 14),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      if (widget.currentPartner.isLiked) {
                                        setState(() {
                                          controller.dislikePartner(
                                              widget.currentPartner);
                                          widget.currentPartner.isLiked = false;
                                        });
                                      } else {
                                        setState(() {
                                          controller.likePartner(
                                              widget.currentPartner);
                                          widget.currentPartner.isLiked = true;
                                        });
                                      }
                                    },
                                    child: MyButton(
                                        text: widget.currentPartner.isLiked
                                            ? 'Dislike'
                                            : 'Like',
                                        color: themeController
                                            .currentTheme.value.primaryColor,
                                        outline: widget.currentPartner.isLiked
                                            ? false
                                            : true,
                                        width: 115,
                                        height: 30,
                                        fontSize: 14),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListView.builder(
                            shrinkWrap: true, // Makes the ListView take up only the necessary space
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:
                                widget.currentPartner.offers.split(',').length,
                            itemBuilder: (context, index) {
                              final offer = widget.currentPartner.offers
                                  .split(',')[index]
                                  .trim();
                              return Container(
                                margin: const EdgeInsets.only(bottom: 10),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 25, horizontal: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 1,
                                        color: const Color(0xffC1C1C1)),
                                    borderRadius: BorderRadius.circular(10),
                                    color: themeController
                                        .currentTheme.value.cardColor),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        color: themeController
                                            .currentTheme.value.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Iconsax.discount_shape,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 15,
                                    ),
                                    Expanded(
                                      child: Text(
                                        offer,
                                        style: TextStyle(
                                            color: themeController.currentTheme
                                                .value.focusColor,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  (widget.currentPartner.website != null)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: IconButton(
                            onPressed: () async {
                              controller.launchURL(
                                  Uri.parse(widget.currentPartner.website!));
                            },
                            icon: Icon(Iconsax.chrome5,
                                size: 35,
                                color: themeController
                                    .currentTheme.value.primaryColor),
                          ),
                        )
                      : Container(),
                  (widget.currentPartner.facebook != null)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: IconButton(
                            onPressed: () async {
                              controller.launchURL(
                                  Uri.parse(widget.currentPartner.facebook!));
                            },
                            icon: Icon(Icons.facebook,
                                size: 35,
                                color: themeController
                                    .currentTheme.value.primaryColor),
                          ),
                        )
                      : Container(),
                  (widget.currentPartner.instagram != null)
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: IconButton(
                            onPressed: () async {
                              controller.launchURL(
                                  Uri.parse(widget.currentPartner.instagram!));
                            },
                            icon: Icon(Iconsax.instagram5,
                                size: 35,
                                color: themeController
                                    .currentTheme.value.primaryColor),
                          ),
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
