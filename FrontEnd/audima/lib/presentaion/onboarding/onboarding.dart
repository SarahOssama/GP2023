import 'package:audima/app/constants.dart';
import 'package:audima/presentaion/resources/routes_manager.dart';
import 'package:audima/responsive.dart';
import 'package:flutter/material.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  late PageController _pageController;
  int _pageIndex = 0;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/mainthemevertical.jpg'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      itemCount: demo_data.length,
                      controller: _pageController,
                      onPageChanged: (index) {
                        if (index == 4) {
                          Navigator.pushReplacementNamed(context, Routes.home);
                        } else {
                          setState(() {
                            _pageIndex = index;
                          });
                        }
                      },
                      itemBuilder: (context, index) => OnBoardingContent(
                        title: demo_data[index].title,
                        description: demo_data[index].description,
                        image: demo_data[index].image,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ...List.generate(
                          demo_data.length,
                          (index) => Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: DotsIndicator(
                                  isActive: index == _pageIndex,
                                ),
                              )),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(context, Routes.home);
                        },
                        child: Text(
                          "Skip",
                          style: ResponsiveTextStyles.skipTextStyle(context),
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (_pageIndex == 3) {
                            Navigator.pushReplacementNamed(
                                context, Routes.home);
                          }
                          _pageController.nextPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut);
                        },
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 30,
                          color: Constants.yellowColorTheme,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

class DotsIndicator extends StatelessWidget {
  const DotsIndicator({super.key, this.isActive = false});
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: isActive ? 15 : 6,
      width: 6,
      decoration: BoxDecoration(
        color: isActive
            ? Constants.yellowColorTheme
            : Constants.yellowColorTheme.withOpacity(0.5),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

class OnBoard {
  String title;
  String? description;
  String image;
  OnBoard({required this.title, this.description, required this.image});
}

final List<OnBoard> demo_data = [
  OnBoard(
    title: 'Let\'s get to know Audima',
    image: 'assets/images/audimabluelogo.png',
  ),
  OnBoard(
    title: 'Generate business statement',
    description:
        'Craft your compelling business statement with ease and utilize it wherever you want',
    image: 'assets/images/thinking1.png',
  ),
  OnBoard(
    title: 'Speech to text',
    description:
        'Harness the power of voice commands for seamless control and interaction.',
    image: 'assets/images/voicecommand.png',
  ),
  OnBoard(
    title: 'Seamless video editing',
    description:
        'Transform your videos and images into captivating masterpieces with Audima\'s video editing tools.',
    image: 'assets/images/cameraman.png',
  ),
];

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({
    super.key,
    this.description,
    required this.image,
    required this.title,
  });
  final String title;
  final String? description;
  final String image;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        Image.asset(
          image,
          height: 250,
        ),
        const Spacer(),
        Text(
          title,
          textAlign: TextAlign.center,
          style: ResponsiveTextStyles.onBoardingFirstTitle(context),
        ),
        const SizedBox(
          height: 10,
        ),
        description != null
            ? Text(
                description!,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Constants.darkBlueColorTheme.withOpacity(0.7),
                ),
              )
            : SizedBox.shrink(),
        Spacer(),
      ],
    );
  }
}
