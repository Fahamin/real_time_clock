import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class chatPage extends StatelessWidget {
  chatPage({super.key});

  final List<ChatMessage> _chatMessages = [];

  Stream<ChatMessage> _chat() async* {
    await Future<void>.delayed(const Duration(seconds: 3));
    yield ChatMessage(username: 'Trump', message: "Hello");

    await Future<void>.delayed(const Duration(seconds: 3));
    yield ChatMessage(username: "Biden", message: "Hi baby");

    await Future<void>.delayed(const Duration(seconds: 3));
    yield ChatMessage(
        username: "Trump", message: "Would you like to have dinner with me?");

    await Future<void>.delayed(const Duration(seconds: 3));
    yield ChatMessage(
        username: "Biden", message: "Great. I am very happy to accompany you.");

    await Future<void>.delayed(const Duration(seconds: 3));
    yield ChatMessage(
        username: "Trump", message: "Nice. I love you, my honney!");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kindacode.com'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: StreamBuilder(
          stream: _chat(),
          builder: (context, AsyncSnapshot<ChatMessage> snapshot) {
            if (snapshot.hasData) {
              _chatMessages.add(snapshot.data!);

              return ListView.builder(
                itemCount: _chatMessages.length,
                itemBuilder: (context, index) {
                  final ChatMessage chatItem = _chatMessages[index];
                  return ListTile(
                    // user name
                    leading: Text(
                      chatItem.username,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    // message
                    title: Text(
                      chatItem.message,
                      style: TextStyle(
                          fontSize: 20,
                          // use different colors for different people
                          color: chatItem.username == 'Trump'
                              ? Colors.pink
                              : Colors.blue),
                    ),
                  );
                },
              );
            }
            return const LinearProgressIndicator();
          },
        ),
      ),
    );
  }
}

class ChatMessage {
  String username;
  String message;

  ChatMessage({required this.username, required this.message});
}
