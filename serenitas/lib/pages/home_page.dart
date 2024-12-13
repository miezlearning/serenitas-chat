import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serenitas/controller/chat.dart';
import 'package:serenitas/controller/predict.dart';
import 'package:serenitas/widgets/side_navbar.dart';
import 'package:serenitas/controller/account.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<String> _mentalHealthSuggestions = [
    "Bagaimana saya bisa manajemen stress dengan efektif?",
    "Apa saja tips untuk tidur yang lebih nyenyak?",
    "Bagaimana cara mengatasi kecemasan?",
    "Apa saja cara untuk tetap termotivasi?",
    "Dapatkah Anda membantu saya melatih perhatian penuh?",
    "Bagaimana cara meningkatkan kesehatan mental saya?",
    "Apa saja tanda-tanda kelelahan?",
    "Bagaimana cara membangun rutinitas harian yang positif?",
  ];

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _checkIfFirstTime(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.data == true) {
          _showIntroScreen(context);
        }

        return Consumer2<ChatController, AccountData>(
          builder: (context, chatController, accountData, child) {
            final isInChatRoom = chatController.isInChatRoom;
            final isLoggedIn = accountData.currentUser != null;

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.purpleAccent,
                title: Text(isInChatRoom ? 'Chat Room' : 'Serenitas'),
                centerTitle: true,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: TextButton(
                      onPressed: () {
                        if (isLoggedIn) {
                          _logout(context, accountData, chatController);
                        } else {
                          Navigator.pushNamed(context, '/login');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          isLoggedIn ? 'Logout' : 'Login',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              body: isInChatRoom
                  ? Stack(
                      children: [
                        _buildChatRoom(context),
                        Positioned(
                          bottom: 100,
                          right: MediaQuery.of(context).size.width / 2 -
                              28, // Center the button
                          child: FloatingActionButton(
                            onPressed: () {
                              chatController.switchToHomePage();
                              chatController.resetConversation();
                            },
                            backgroundColor: Colors.red,
                            child: const Icon(Icons.home),
                          ),
                        ),
                      ],
                    )
                  : _buildWelcomeScreen(context, chatController),
              drawer: CustomDrawer(
                boxColor: Colors.purple,
                buttons: [
                  {'name': 'Pengaturan', 'target': '/setting'},
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<bool> _checkIfFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
    if (isFirstTime) {
      prefs.setBool('isFirstTime', false);
    }
    return isFirstTime;
  }

  void _showIntroScreen(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final introKey = GlobalKey<IntroductionScreenState>();

      final pages = <PageViewModel>[
        PageViewModel(
          title: "Welcome",
          body:
              "Selamat datang di aplikasi Serenitas, dimana aku adalah teman curhat kamu.",
          image: Center(child: Icon(Icons.info, size: 100.0)),
        ),
        PageViewModel(
          title: "Fitur",
          body:
              "Aku bisa membantu kamu dalam berbagai hal, seperti memberikan saran atau sekedar mendengarkan.",
          image: Center(child: Icon(Icons.featured_play_list, size: 100.0)),
        ),
        PageViewModel(
          title: "Get Started",
          body: "Let's get started!",
          image: Center(child: Icon(Icons.start, size: 100.0)),
        ),
      ];

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => IntroductionScreen(
            key: introKey,
            pages: pages,
            onDone: () {
              Navigator.of(context).pushReplacementNamed('/home');
            },
            showNextButton: true,
            showSkipButton: true,
            next: const Icon(Icons.arrow_forward),
            skip: const Text("Skip"),
            done: const Text("Done",
                style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator: DotsDecorator(
              size: const Size(10.0, 10.0),
              activeSize: const Size(22.0, 10.0),
              color: Colors.blueAccent,
              activeColor: Colors.blue,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
        ),
      );
    });
  }

  Widget _buildWelcomeScreen(
      BuildContext context, ChatController chatController) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.chat_bubble_outline,
                  size: 100,
                  color: Colors.grey,
                ),
                const SizedBox(height: 20),
                Text(
                  'Selamat datang di Serenitas!',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  'Ketik pesan untuk memulai atau pilih pertanyaan di bawah!',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.grey,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _buildSuggestions(context, chatController),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _chatController,
            decoration: InputDecoration(
              hintText: 'Ketik pesan anda...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handlePrediction(
                  context,
                  _chatController.text,
                  chatController,
                ),
              ),
            ),
            onSubmitted: (value) =>
                _handlePrediction(context, value, chatController),
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestions(
      BuildContext context, ChatController chatController) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 58, 58, 58),
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8.0,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: _mentalHealthSuggestions.map((suggestion) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Material(
                  elevation: 4.0,
                  borderRadius: BorderRadius.circular(12.0),
                  color: const Color.fromARGB(255, 41, 0, 88),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12.0),
                    onTap: () => _handlePrediction(
                      context,
                      suggestion,
                      chatController,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Text(
                        suggestion,
                        style: const TextStyle(),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  void _handlePrediction(
      BuildContext context, String input, ChatController chatController) async {
    if (input.isEmpty) return;

    final predictionProvider =
        Provider.of<PredictionProvider>(context, listen: false);

    chatController.switchToChatRoom();
    chatController.addMessage(input, "User");

    // Clear TextField
    _chatController.clear();

    // Fetch prediction
    await predictionProvider.getPrediction(input);
    final response = predictionProvider.lastResponse ?? "Tidak ada respon.";
    chatController.addMessage(response, "Serenitas");

    // Scroll ke bawah setelah menambahkan pesan baru
    _scrollToBottom();
  }

  Widget _buildChatRoom(BuildContext context) {
    final chatController = Provider.of<ChatController>(context);
    final messages = chatController.messages;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController, // Menambahkan ScrollController
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return _buildChatBubble(
                messages[index]['text']!,
                messages[index]['sender']!,
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _chatController,
            decoration: InputDecoration(
              hintText: 'Ketik pesan anda...',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              suffixIcon: IconButton(
                icon: const Icon(Icons.send),
                onPressed: () => _handlePrediction(
                  context,
                  _chatController.text,
                  chatController,
                ),
              ),
            ),
            onSubmitted: (value) =>
                _handlePrediction(context, value, chatController),
          ),
        ),
      ],
    );
  }

  Widget _buildChatBubble(String message, String sender) {
    bool isUser = sender == "User";
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              sender,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isUser ? Colors.blueAccent : Colors.grey[600],
                fontSize: 12.0,
              ),
            ),
            const SizedBox(height: 4.0),
            Material(
              color: isUser ? Colors.blueAccent : Colors.grey[300]!,
              borderRadius: BorderRadius.circular(12.0),
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  message,
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black87,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context, AccountData accountData,
      ChatController chatController) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Apakah anda ingin logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () {
                chatController.resetConversation();
                accountData.logout();
                chatController.switchToHomePage();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
