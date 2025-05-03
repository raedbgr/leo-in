import '/imports.dart';

class SupportPage extends StatefulWidget {
  @override
  _SupportPageState createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  int selectedValue = 0;
  final ThemeController themeController = Get.find();
  late final TextEditingController _titleController = TextEditingController();
  late final TextEditingController _descriptionController = TextEditingController();
  bool isSubmitting = false;
  bool isSubmitted = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitTicket() {
    if (_titleController.text.isEmpty || _descriptionController.text.isEmpty || selectedValue == 0) {
      Get.snackbar(
        'Error',
        'Please fill out all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    setState(() {
      isSubmitting = true;
    });
    
    // Simulate API call
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isSubmitting = false;
        isSubmitted = true;
      });
      
      // Show ticket number
      Get.snackbar(
        'Success',
        'Your ticket #${DateTime.now().millisecondsSinceEpoch.toString().substring(5, 13)} has been submitted',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: const Duration(seconds: 5),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          themeController.currentTheme.value.scaffoldBackgroundColor,
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
                      imagePath: 'assets/images/support.png',
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
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
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Center(
                              child: Text(
                                'Submit Support Ticket',
                                textAlign: TextAlign.center,
                                style: TextStyle(
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
            buildShadowedContainer(
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  child: Center(
                    child: Column(
                      children: [
                        Text(
                          'Open a New Support Ticket',
                          style: TextStyle(
                              color:
                                  themeController.currentTheme.value.focusColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Please fill out the form below to submit a support ticket. Our team will respond as soon as possible.',
                          style: TextStyle(
                            color:
                                themeController.currentTheme.value.focusColor,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  )),
            ),
            Expanded(
              child: isSubmitted 
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 80,
                        color: themeController.currentTheme.value.primaryColor,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Ticket Submitted Successfully',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Thank you for your submission.\nOur support team will contact you shortly.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isSubmitted = false;
                            _titleController.clear();
                            _descriptionController.clear();
                            selectedValue = 0;
                          });
                        },
                        child: Text(
                          'Submit Another Ticket',
                          style: TextStyle(
                            color: themeController.currentTheme.value.primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Container(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                color:
                    themeController.currentTheme.value.scaffoldBackgroundColor,
                child: Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ticket Title:',
                          style: TextStyle(
                              color:
                                  themeController.currentTheme.value.focusColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _titleController,
                          style: TextStyle(
                            color: themeController.currentTheme.value.focusColor,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Enter a title for your ticket',
                            hintStyle: TextStyle(
                              color: themeController.currentTheme.value.hintColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          'Ticket Category:',
                          style: TextStyle(
                              color:
                                  themeController.currentTheme.value.focusColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        MyRadioBox(
                          text: 'App Functionality Issue',
                          value: 1,
                          groupValue: selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                        MyRadioBox(
                          text: 'Technical Support',
                          value: 2,
                          groupValue: selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                        MyRadioBox(
                          text: 'Account/Login Issues',
                          value: 3,
                          groupValue: selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                        MyRadioBox(
                          text: 'Other',
                          value: 4,
                          groupValue: selectedValue,
                          onChanged: (int? value) {
                            setState(() {
                              selectedValue = value!;
                            });
                          },
                        ),
                        Text(
                          'Description:',
                          style: TextStyle(
                              color:
                                  themeController.currentTheme.value.focusColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 5),
                        TextField(
                          controller: _descriptionController,
                          style: TextStyle(
                            color: themeController.currentTheme.value.focusColor,
                          ),
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: 'Describe your issue in detail...',
                            hintStyle: TextStyle(
                              color: themeController.currentTheme.value.hintColor,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isSubmitting
                                ? const CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: _submitTicket,
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: themeController
                                          .currentTheme.value.primaryColor,
                                      minimumSize: const Size(175, 50),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: const Text(
                                      'Submit Ticket',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
