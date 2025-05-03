import '/imports.dart';

class DocumentRequestPage extends StatefulWidget {
  @override
  _DocumentRequestPageState createState() => _DocumentRequestPageState();
}

class _DocumentRequestPageState extends State<DocumentRequestPage> {
  final ThemeController themeController = Get.find();
  String? documentType;
  bool isSubmitting = false;
  bool isSubmitted = false;
  late final TextEditingController _detailsController = TextEditingController();
  
  List<String> documentTypes = [
    'Work Certificate',
    'Salary Certificate',
    'Experience Certificate',
    'Employment Letter',
    'Tax Documents',
    'Other'
  ];

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  void _submitDocumentRequest() {
    if (documentType == null || _detailsController.text.isEmpty) {
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
      
      // Show confirmation
      Get.snackbar(
        'Success',
        'Your document request has been submitted',
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
                      imagePath: 'assets/images/service.png',
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
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 30),
                            child: Center(
                              child: Text(
                                'Document Request',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
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
                        'Document Request Submitted',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Text(
                          'Your document request has been submitted. You will be notified once it is processed and ready for collection.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: themeController.currentTheme.value.focusColor,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isSubmitted = false;
                            documentType = null;
                            _detailsController.clear();
                          });
                        },
                        child: Text(
                          'Submit Another Request',
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
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Please fill out the form below to request official documents',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Document Type Selection
                      Text(
                        'Document Type:',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: themeController.currentTheme.value.hintColor.withOpacity(0.5),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: documentType,
                            hint: Text(
                              'Select document type',
                              style: TextStyle(
                                color: themeController.currentTheme.value.hintColor,
                              ),
                            ),
                            dropdownColor: themeController.currentTheme.value.scaffoldBackgroundColor,
                            items: documentTypes.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: themeController.currentTheme.value.focusColor,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (newValue) {
                              setState(() {
                                documentType = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      
                      // Document Details
                      Text(
                        'Additional Details:',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _detailsController,
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                        ),
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Provide any specific requirements or details about the document you need...',
                          hintStyle: TextStyle(
                            color: themeController.currentTheme.value.hintColor,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: themeController.currentTheme.value.hintColor.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      
                      // Document Purpose
                      Text(
                        'Delivery Preference:',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      RadioListTile(
                        title: Text(
                          'Digital Copy (Email)',
                          style: TextStyle(
                            color: themeController.currentTheme.value.focusColor,
                          ),
                        ),
                        value: 'digital',
                        groupValue: 'digital',
                        onChanged: (_) {},
                        activeColor: themeController.currentTheme.value.primaryColor,
                      ),
                      RadioListTile(
                        title: Text(
                          'Physical Copy (Collection)',
                          style: TextStyle(
                            color: themeController.currentTheme.value.focusColor,
                          ),
                        ),
                        value: 'physical',
                        groupValue: 'digital',
                        onChanged: (_) {},
                        activeColor: themeController.currentTheme.value.primaryColor,
                      ),
                      
                      const SizedBox(height: 30),
                      
                      // Submit Button
                      Center(
                        child: isSubmitting
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _submitDocumentRequest,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: themeController.currentTheme.value.primaryColor,
                                  minimumSize: const Size(200, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  'Submit Request',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }
} 