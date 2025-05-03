import '/imports.dart';

class ServicePage extends StatefulWidget {
  @override
  _ServicePageState createState() => _ServicePageState();
}

class _ServicePageState extends State<ServicePage> {
  final ThemeController themeController = Get.find();
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  // Hardcoded chat messages
  List<Map<String, dynamic>> messages = [
    {
      'isUser': false,
      'message': 'Hello! I\'m Maria from Employee Services. How can I help you today?',
      'time': DateTime.now().subtract(const Duration(minutes: 5)),
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    final userMessage = {
      'isUser': true,
      'message': _messageController.text.trim(),
      'time': DateTime.now(),
    };

    setState(() {
      messages.add(userMessage);
      _messageController.clear();
      _isTyping = true;
    });

    // Scroll to bottom
    _scrollToBottom();

    // Simulate agent typing
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isTyping = false;
      });
      
      // Add agent response - fix type error by casting to String
      _respondToMessage(userMessage['message'] as String);
    });
  }

  void _respondToMessage(String userMessage) {
    final lowerMessage = userMessage.toLowerCase();
    String response;

    if (lowerMessage.contains('leave') || lowerMessage.contains('vacation') || lowerMessage.contains('time off')) {
      response = 'For leave requests, you can use our Leave Request feature in the app menu. Would you like me to explain how to submit a leave request?';
    } else if (lowerMessage.contains('document') || lowerMessage.contains('certificate') || lowerMessage.contains('paperwork')) {
      response = 'If you need any official documents or certificates, you can request them through the Document Request feature. Is there a specific document you need?';
    } else if (lowerMessage.contains('salary') || lowerMessage.contains('pay') || lowerMessage.contains('payslip')) {
      response = 'For salary-related inquiries or payslip requests, please contact our payroll department at payroll@leoni.com or use the Document Request feature to request your payslips.';
    } else if (lowerMessage.contains('hello') || lowerMessage.contains('hi')) {
      response = 'Hello! How can I assist you today with employee services?';
    } else {
      response = 'Thank you for your message. Our team will look into this matter. Is there anything else I can help you with?';
    }

    final agentMessage = {
      'isUser': false,
      'message': response,
      'time': DateTime.now(),
    };

    setState(() {
      messages.add(agentMessage);
    });

    // Scroll to bottom after adding message
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeController.currentTheme.value.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 120,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              const Expanded(
                                child: Center(
                                  child: Text(
                                    'Employee Services Chat',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 40),
                            ],
                          ),
                        ],
                      ),
                    )
                  ]),
                ),
              ],
            ),
            // Agent profile card
            buildShadowedContainer(
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: themeController.currentTheme.value.primaryColor.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.user,
                          color: themeController.currentTheme.value.primaryColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Maria Lopez',
                          style: TextStyle(
                            color: themeController.currentTheme.value.focusColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Employee Services Agent',
                          style: TextStyle(
                            color: themeController.currentTheme.value.hintColor,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Online',
                      style: TextStyle(
                        color: themeController.currentTheme.value.hintColor,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Chat messages
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return _buildMessageBubble(message);
                },
              ),
            ),
            // Typing indicator
            if (_isTyping)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    'Maria is typing...',
                    style: TextStyle(
                      color: themeController.currentTheme.value.hintColor,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            // Message input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: themeController.currentTheme.value.cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      style: TextStyle(
                        color: themeController.currentTheme.value.focusColor,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: TextStyle(
                          color: themeController.currentTheme.value.hintColor,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: themeController.currentTheme.value.scaffoldBackgroundColor,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      ),
                      maxLines: null,
                      textInputAction: TextInputAction.send,
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FloatingActionButton(
                    onPressed: _sendMessage,
                    mini: true,
                    backgroundColor: themeController.currentTheme.value.primaryColor,
                    child: const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isUser = message['isUser'] as bool;
    final messageTime = message['time'] as DateTime;
    final formattedTime = '${messageTime.hour}:${messageTime.minute.toString().padLeft(2, '0')}';
    
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: isUser 
            ? themeController.currentTheme.value.primaryColor 
            : themeController.currentTheme.value.cardColor,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['message'],
              style: TextStyle(
                color: isUser 
                  ? Colors.white 
                  : themeController.currentTheme.value.focusColor,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              formattedTime,
              style: TextStyle(
                color: isUser 
                  ? Colors.white.withOpacity(0.7) 
                  : themeController.currentTheme.value.hintColor,
                fontSize: 12,
              ),
              textAlign: TextAlign.right,
            ),
          ],
        ),
      ),
    );
  }
}
