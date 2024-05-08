import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  TextEditingController idEditingController = TextEditingController();



  void _login() {
    CometChatUIKit.login(idEditingController.text, onSuccess: (User user) {
      debugPrint("User logged in successfully  ${user.name}");
      _navigateToConversations();
    }, onError: (CometChatException e) {
      CometChatUIKit.createUser(
          User(name: idEditingController.text, uid: idEditingController.text),
          onSuccess: (User user) {
            CometChatUIKit.login(idEditingController.text, onSuccess: (User user) {
              debugPrint("User logged in successfully  ${user.name}");
              _navigateToConversations();
            }, onError: (CometChatException e) {
              debugPrint("Login failed with exception: ${e.message}");
            });
            debugPrint("User created successfully ${user.name}");
          }, onError: (CometChatException e) {
        debugPrint("Creating new user failed with exception: ${e.message}");
      });
      debugPrint("Login failed with exception: ${e.message}");
    });
  }

  void _navigateToConversations() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const Conversations()));
  }



  @override
  void initState() {
    super.initState();

    UIKitSettings uiKitSettings = (UIKitSettingsBuilder()
      ..subscriptionType = CometChatSubscriptionType.allUsers
      ..autoEstablishSocketConnection = true
      ..region = "" // Replace with your region
      ..appId = "" // Replace with your app ID
      ..authKey = ""
      ..extensions = CometChatUIKitChatExtensions
          .getDefaultExtensions() // Replace this with empty array; you want to disable all extensions
    ) // Replace with your auth key
        .build();

    CometChatUIKit.init(
        uiKitSettings: uiKitSettings,
        onSuccess: (String successMessage) {
          debugPrint("Initialization completed successfully  $successMessage");
        },
        onError: (CometChatException e) {
          debugPrint("Initialization failed with exception: ${e.message}");
        });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: idEditingController,
                decoration: const InputDecoration(
                  hintText: 'Enter User Name',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
          ],
        ),
    ));
  }
}



class Conversations extends StatelessWidget {

  const Conversations({super.key});

  @override

  Widget build(BuildContext context) {

    return const Scaffold(

        body: CometChatConversationsWithMessages()

    );

  }

}


