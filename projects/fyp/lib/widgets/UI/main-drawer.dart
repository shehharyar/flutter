import 'package:flutter/material.dart';
class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen, required this.title});
final String title;
  final void Function(String identifier) onSelectScreen;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(255, 55, 31, 117),
      child: Column(
        children: [
          DrawerHeader(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primaryContainer,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.fastfood,
                  size: 48,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 18),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.restaurant,
              size: 26,
              color: Colors.white,
            ),
            title: Text(
              'Shops',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    color: Colors.white,
                    fontSize: 24,
                  ),
            ),
            onTap: () {
              onSelectScreen('home');
            },
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.settings,
          //     size: 26,
          //     color: Theme.of(context).colorScheme.onBackground,
          //   ),
          //   title: Text(
          //     'Logout',
          //     style: Theme.of(context).textTheme.titleSmall!.copyWith(
          //           color: Theme.of(context).colorScheme.onBackground,
          //           fontSize: 24,
          //         ),
          //   ),
          //   onTap: () {
          //     FirebaseAuth.instance.signOut();
          //     // onSelectScreen('logout');
          //   },
          // ),
        ],
      ),
    );
  }
}