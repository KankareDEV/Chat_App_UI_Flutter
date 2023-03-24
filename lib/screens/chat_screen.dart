import 'package:chat_ui/models/message_model.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat_model.dart';
import '../models/user_model.dart';
import '../widgets/custom_container.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController scrollController = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  bool _showEmoji = false;

  late User user;
  late Chat chat;
  late String text = '';

  @override
  void initState() {
    user = Get.arguments[0];
    chat = Get.arguments[1];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: WillPopScope(
        onWillPop: () {
          if (_showEmoji) {
            setState(() {
              _showEmoji = !_showEmoji;
            });
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Scaffold(
          appBar: _CustomAppBar(
            user: user,
          ),
          body: CustomContainer(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                _ChatMessages(
                  chat: chat,
                  scrollController: scrollController,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.transparent),
                        child: IconButton(
                          onPressed: () {
                            setState(() => _showEmoji = !_showEmoji);
                          },
                          icon: Icon(
                            Icons.emoji_emotions,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        onTap: () {
                          if (_showEmoji) {
                            setState(() => _showEmoji = !_showEmoji);
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            text = textEditingController.text;
                          });
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Theme.of(context)
                              .colorScheme
                              .secondary
                              .withAlpha(150),
                          hintText: 'Type here ...',
                          hintStyle: Theme.of(context).textTheme.bodyMedium,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.all(20),
                          suffixIcon: IconButton(
                            onPressed: () {
                              if (_showEmoji) {
                                Message message = Message(
                                  senderId: '1',
                                  recipientId: user.id,
                                  text: textEditingController.text,
                                  createdAt: DateTime.now(),
                                );

                                List<Message> messages =
                                    List.from(chat.messages)..add(message);

                                messages.sort((a, b) =>
                                    b.createdAt.compareTo(a.createdAt));

                                setState(() {
                                  chat = chat.copyWith(messages: messages);
                                  textEditingController.clear();
                                  text = '';
                                  _showEmoji =
                                      false; // set emoji picker to false after sending emoji
                                });

                                scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );

                                textEditingController.clear();
                                text = '';
                              } else if (text.isNotEmpty) {
                                Message message = Message(
                                  senderId: '1',
                                  recipientId: user.id,
                                  text: textEditingController.text,
                                  createdAt: DateTime.now(),
                                );

                                List<Message> messages =
                                    List.from(chat.messages)..add(message);

                                messages.sort((a, b) =>
                                    b.createdAt.compareTo(a.createdAt));

                                setState(() {
                                  chat = chat.copyWith(messages: messages);
                                  textEditingController.clear();
                                  text = '';
                                });

                                scrollController.animateTo(
                                  scrollController.position.maxScrollExtent,
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.easeIn,
                                );

                                textEditingController.clear();
                                text = '';
                              }
                            },
                            icon: const Icon(Icons.send),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_showEmoji)
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: EmojiPicker(
                      onEmojiSelected: (Category? category, Emoji emoji) {
                        textEditingController.text =
                            textEditingController.text + emoji.emoji;
                        textEditingController.selection =
                            TextSelection.fromPosition(
                          TextPosition(
                              offset: textEditingController.text.length),
                        );
                      },
                      config: const Config(
                        bgColor: Colors.transparent,
                        columns: 7,
                        emojiSizeMax: 32,
                      ),
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ChatMessages extends StatelessWidget {
  const _ChatMessages({
    super.key,
    required this.chat,
    required this.scrollController,
  });

  final Chat chat;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          controller: scrollController,
          reverse: true,
          itemCount: chat.messages.length,
          itemBuilder: (context, index) {
            Message message = chat.messages[index];
            return Align(
              alignment: (message.senderId == '1')
                  ? Alignment.centerLeft
                  : Alignment.centerRight,
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * 0.66,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (message.senderId == '1')
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.symmetric(vertical: 5.0),
                child: Text(
                  message.text,
                ),
              ),
            );
          }),
    );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar({super.key, this.user});

  final user;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Column(
        children: [
          Text(
            '${user.name}',
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            'Online',
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
      elevation: 0,
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 10),
          child: CircleAvatar(
            backgroundImage: NetworkImage(user.imageUrl),
          ),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56.0);
}
