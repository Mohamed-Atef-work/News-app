import 'package:flutter/material.dart';
import 'package:news/core/components/navigateAndFinish.dart';
import 'package:news/core/cubit/controller.dart';
import 'package:news/screens/HomeScreens/drawer/widgets/drawerItem.dart';

import 'controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    late AppDrawerController controller = AppDrawerController(
      context: context,
    );
    print("--------------------");

    return SafeArea(
      child: Drawer(
        backgroundColor: Colors.grey.shade300,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    AppController.get(context).userModel!.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  CircleAvatar(
                    radius: 30,
                    foregroundImage: NetworkImage(
                        AppController.get(context).userModel!.image),
                  ),
                ],
              ),
            ),
            Container(
              height: 300,
              clipBehavior: Clip.antiAlias,
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.grey.shade200,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) => DrawerItem(
                  title: controller.titles[index],
                  icon: controller.icons[index],
                  onPressed: () {
                    if (index != 3) {
                      navigateAndFinish(
                        context: context,
                        widget: controller.screens[index],
                      );
                    } else {
                      AppController.get(context).logOut(context: context);
                    }
                  },
                ),
                separatorBuilder: (context, index) => const Divider(
                  color: Colors.grey,
                  endIndent: 30,
                  indent: 30,
                ),
                itemCount: controller.titles.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
