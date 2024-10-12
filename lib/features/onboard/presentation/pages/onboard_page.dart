import 'package:fashion_flow/core/common/animations/custom_page_route.dart';
import 'package:fashion_flow/core/themes/app_pallete.dart';
import 'package:fashion_flow/features/auth/presentation/pages/auth_option_page.dart';
import 'package:fashion_flow/features/onboard/data/datasources/local_data_sources.dart';
import 'package:fashion_flow/core/common/widgets/primay_button.dart';
import 'package:flutter/material.dart';

class OnboardPage extends StatefulWidget {
  static route() => CustomePageRoute(
        child: const OnboardPage(),
      );

  const OnboardPage({super.key});

  @override
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  late PageController _pageController; // Declare PageController

  @override
  void initState() {
    super.initState();
    _pageController = PageController(); // Initialize PageController
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the controller
    super.dispose();
  }

  void _nextPage() {
    // Check if there are more pages to navigate to
    if ((_pageController.page?.toInt() ?? -1) < onboardingList.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.pushAndRemoveUntil(
          context, AuthOptionPage.route(), (_) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: PageView.builder(
        controller: _pageController, // Assign the controller here
        itemCount: onboardingList.length,
        itemBuilder: (context, index) {
          final onboarding = onboardingList[index];
          final isLast =
              index == onboardingList.length - 1; // Check if last page

          return Column(
            children: [
              Image.asset(
                onboarding.imageUrl,
                height: height * 0.7,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
              
                decoration: BoxDecoration(
                 color: Theme.of(context).primaryColor
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      onboarding.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      onboarding.description,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.w400,
                        color: AppPallete.greyColor,
                        letterSpacing: 1.2,
                      ),
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      title: isLast
                          ? 'Get Started'
                          : 'Next', // Change button title
                      onPress: _nextPage, // Call the next page function
                    ),
                   
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
