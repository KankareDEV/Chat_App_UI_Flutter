import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';

import '../models/chat_model.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../widgets/custom_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    List<Chat> chats = Chat.chats;

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
      child: Scaffold(
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_home,
          foregroundColor: Theme.of(context).colorScheme.background,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.message_rounded, color: Colors.white),
              backgroundColor: Colors.black,
              label: 'New message',
            ),
            SpeedDialChild(
              child: const Icon(Icons.group_add, color: Colors.white),
              backgroundColor: Colors.black,
              label: 'Add group',
            ),
          ],
        ),
        drawer: Opacity(
          opacity: 0.95,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
            child: Drawer(
              width: 275,
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
                child: Column(
                  children: [
                    Row(
                      children: const [
                        Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(
                          width: 56,
                        ),
                        Text(
                          'Settings',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 29,
                            backgroundImage: NetworkImage(
                                'https://img.freepik.com/free-photo/young-bearded-man-with-striped-shirt_273609-5677.jpg?w=2000'),
                          ),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'James Berry',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.key,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Account',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.chat_bubble,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Chats',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Notifications',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.storage,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Data and Storage',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.help,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 40),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Help',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      height: 35,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: const [
                        Icon(
                          Icons.people_outline,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Invite a Friend',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: const [
                        Icon(
                          Icons.logout,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 40),
                        Text(
                          'Log out',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        appBar: const _CustomAppBar(),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  _ChatMessages(height: height, chats: chats),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatMessages extends StatelessWidget {
  const _ChatMessages({
    required this.height,
    required this.chats,
  });

  final double height;
  final List<Chat> chats;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      height: height,
      child: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          // Get the other user profile
          User user = chats[index].users!.where((user) => user.id != '1').first;

          // Sort the message based on the creation time
          chats[index]
              .messages
              .sort((a, b) => b.createdAt.compareTo(a.createdAt));

          // Get the last message for the chat preview
          Message lastMessage = chats[index].messages.first;

          return Slidable(
            startActionPane: ActionPane(
              motion: const StretchMotion(),
              children: [
                SlidableAction(
                  onPressed: ((context) {
                    // call to someone
                  }),
                  backgroundColor: Colors.green,
                  icon: Icons.phone,
                ),
                SlidableAction(
                  onPressed: ((context) {
                    // text to someone
                  }),
                  backgroundColor: Colors.blue,
                  icon: Icons.chat,
                ),
              ],
            ),
            child: ListTile(
              onTap: () {
                Get.toNamed('/chat', arguments: [
                  user,
                  chats[index],
                ]);
              },
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(user.imageUrl),
              ),
              title: Text(
                user.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                lastMessage.text,
                maxLines: 1,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              trailing: Text(
                '${lastMessage.createdAt.hour}:${lastMessage.createdAt.minute}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
          );
        },
      ),
    );
  }
}

class _CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 50, left: 5, right: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(
                  Get.isDarkMode ? Icons.menu : Icons.menu,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                  );
                },
                icon: Lottie.network(
                  Get.isDarkMode
                      ? 'https://assets9.lottiefiles.com/packages/lf20_sCwGNr.json'
                      : 'https://assets5.lottiefiles.com/datafiles/ugFV3T9Zi676bvx/data.json',
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 10),
            children: [
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Messages',
                  style: TextStyle(fontSize: 18),
                ),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.background,
                ),
              ),
              const SizedBox(
                width: 35,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Online',
                  style: TextStyle(fontSize: 18),
                ),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                width: 35,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'Groups',
                  style: TextStyle(fontSize: 18),
                ),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                width: 35,
              ),
              TextButton(
                onPressed: () {},
                child: const Text(
                  'More',
                  style: TextStyle(fontSize: 18),
                ),
                style: TextButton.styleFrom(
                  primary: Theme.of(context).colorScheme.surface,
                ),
              ),
              const SizedBox(
                width: 35,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}
