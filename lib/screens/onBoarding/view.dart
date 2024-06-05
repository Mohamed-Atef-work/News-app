import 'package:flutter/material.dart';
import 'package:news/core/components/navigateAndFinish.dart';
import 'package:news/screens/login/view.dart';
import '../../core/components/appText.dart';
import '../../l10n/app_localizations.dart';
import 'controller.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller = OnBoardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFfb7f01),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  onPressed: () => navigateAndFinish(
                    context: context,
                    widget: const LoginScreen(),
                  ),
                  child: DefaultText(
                    text: AppLocalizations.of(context)!.skip,
                    textColor: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: SizedBox(
                    height: 450,
                    child: PageView(
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (index) {
                        controller.currentIndex = index;
                        setState(() {});
                      },
                      children: List.generate(
                        controller.images.length,
                        (index) => Column(
                          children: [
                            Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Image.asset(
                                controller.images[controller.currentIndex],
                                width: double.infinity,
                                fit: BoxFit.contain,
                                height: 250,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DefaultText(
                                fontWeight: FontWeight.w600,
                                textColor: Colors.white,
                                text: controller.getTitle(
                                  context: context,
                                  index: index,
                                ),
                                fontSize: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  controller.images.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 5,
                    ),
                    child: CircleAvatar(
                      radius: controller.currentIndex == index ? 10 : 8,
                      backgroundColor: controller.currentIndex == index
                          ? Colors.white
                          : Colors.orange,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
