import '/imports.dart';

class LeaveRequestPage extends StatefulWidget {
  @override
  _LeaveRequestPageState createState() => _LeaveRequestPageState();
}

class _LeaveRequestPageState extends State<LeaveRequestPage> {
  final ThemeController themeController = Get.find();
  DateTime? startDate;
  DateTime? endDate;
  String? leaveType;
  bool isSubmitting = false;
  bool isSubmitted = false;
  late final TextEditingController _reasonController = TextEditingController();
  
  List<String> leaveTypes = [
    'Annual Leave',
    'Sick Leave',
    'Personal Leave',
    'Family Emergency',
    'Other'
  ];

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _submitLeaveRequest() {
    if (startDate == null || endDate == null || leaveType == null || _reasonController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please fill out all fields',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    if (endDate!.isBefore(startDate!)) {
      Get.snackbar(
        'Error',
        'End date cannot be before start date',
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
        'Your leave request has been submitted',
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
                                'Leave Request',
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
                        'Leave Request Submitted',
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
                          'Your leave request has been submitted for approval. You will be notified once it is processed.',
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
                            startDate = null;
                            endDate = null;
                            leaveType = null;
                            _reasonController.clear();
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
                        'Please fill out the form below to request leave',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Leave Type Selection
                      Text(
                        'Leave Type:',
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
                            value: leaveType,
                            hint: Text(
                              'Select leave type',
                              style: TextStyle(
                                color: themeController.currentTheme.value.hintColor,
                              ),
                            ),
                            dropdownColor: themeController.currentTheme.value.scaffoldBackgroundColor,
                            items: leaveTypes.map((String value) {
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
                                leaveType = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      
                      // Date Selection
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Start Date:',
                                  style: TextStyle(
                                    color: themeController.currentTheme.value.focusColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () async {
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.now().add(const Duration(days: 365)),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: themeController.currentTheme.value.primaryColor,
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        startDate = picked;
                                        // If end date is before start date, update it
                                        if (endDate != null && endDate!.isBefore(startDate!)) {
                                          endDate = startDate;
                                        }
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: themeController.currentTheme.value.hintColor.withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          startDate != null
                                              ? DateFormat('MMM d, yyyy').format(startDate!)
                                              : 'Select Date',
                                          style: TextStyle(
                                            color: startDate != null
                                                ? themeController.currentTheme.value.focusColor
                                                : themeController.currentTheme.value.hintColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_today,
                                          color: themeController.currentTheme.value.hintColor,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'End Date:',
                                  style: TextStyle(
                                    color: themeController.currentTheme.value.focusColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () async {
                                    // Don't allow end date selection if start date isn't set
                                    if (startDate == null) {
                                      Get.snackbar(
                                        'Error',
                                        'Please select a start date first',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                      return;
                                    }
                                    
                                    final picked = await showDatePicker(
                                      context: context,
                                      initialDate: endDate ?? startDate!,
                                      firstDate: startDate!,
                                      lastDate: startDate!.add(const Duration(days: 365)),
                                      builder: (context, child) {
                                        return Theme(
                                          data: Theme.of(context).copyWith(
                                            colorScheme: ColorScheme.light(
                                              primary: themeController.currentTheme.value.primaryColor,
                                            ),
                                          ),
                                          child: child!,
                                        );
                                      },
                                    );
                                    if (picked != null) {
                                      setState(() {
                                        endDate = picked;
                                      });
                                    }
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: themeController.currentTheme.value.hintColor.withOpacity(0.5),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          endDate != null
                                              ? DateFormat('MMM d, yyyy').format(endDate!)
                                              : 'Select Date',
                                          style: TextStyle(
                                            color: endDate != null
                                                ? themeController.currentTheme.value.focusColor
                                                : themeController.currentTheme.value.hintColor,
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_today,
                                          color: themeController.currentTheme.value.hintColor,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      // Reason
                      Text(
                        'Reason for Leave:',
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: _reasonController,
                        style: TextStyle(
                          color: themeController.currentTheme.value.focusColor,
                        ),
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Enter your reason for requesting leave...',
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
                      
                      // Submit Button
                      Center(
                        child: isSubmitting
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: _submitLeaveRequest,
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