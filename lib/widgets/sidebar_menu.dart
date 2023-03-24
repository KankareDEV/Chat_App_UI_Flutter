import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class SidebarMenu extends StatefulWidget {
  const SidebarMenu({Key? key}) : super(key: key);

  @override
  _SidebarMenuState createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

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
                onPressed: _toggleSidebar,
                icon: Icon(
                  Icons.menu,
                ),
              ),
              IconButton(
                onPressed: () {
                  Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark,
                  );
                },
                icon: Icon(
                  Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
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
              SizedBox(
                width: 35,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _toggleSidebar,
                    child: AnimatedOpacity(
                      opacity: _isOpen ? 0.5 : 0,
                      duration: Duration(milliseconds: 300),
                      child: Container(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
