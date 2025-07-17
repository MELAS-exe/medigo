import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medigo/core/theme/spacing.dart';
import 'package:medigo/presentation/features/auth/view_models/auth_view_models.dart';
import 'package:medigo/presentation/features/auth/widgets/page_view_element.dart';
import 'package:medigo/presentation/shared/widgets/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../widgets/Login.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController _pageController = PageController();
  final int _numPages = 4;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() => _currentPage = _pageController.page!.round());
    });
  }

  @override
  Widget build(BuildContext context) {
    AuthViewModel authViewModel = Provider.of<AuthViewModel>(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Positioned(
                left: 20,
                top: 40,
                child: Row(
                  children: [
                    Image.asset("assets/logo-medigo.png", height: 48,),
                    SizedBox(width: AppSpacing.space16(context),),
                    Text("MediGo", style: Theme.of(context).textTheme.titleLarge,)
                  ],
                )
            ),
            PageView(
              controller: _pageController,
              children: [
                PageViewElement(
                  imagePath: "assets/time-management-intro.png",
                  text:
                      "Gérez vos traitements et plannifiez vos rendez-vous medicaux",
                ),
                PageViewElement(
                  imagePath: "assets/pharmacist-intro.png",
                  text:
                      "Localisez les structures proches et consultez leur stock",
                ),
                PageViewElement(
                  imagePath: "assets/calling-intro.png",
                  text:
                      "Faites vous consulter en ligne et discutez avec les médecins",
                ),
                PageViewElement(
                  imagePath: "assets/help-intro.png",
                  text: "Recevez de l’aide pour payer vos médicaments",
                ),
              ],
            ),
            Positioned(
              bottom: 40.0,
              left: 0,
              right: 0,
              child: Center(
                child: Column(
                  children: [
                    SmoothPageIndicator(
                      controller: _pageController, // PageController
                      count: _numPages,
                      effect: WormEffect(
                        dotHeight: 10,
                        dotWidth: 10,
                        activeDotColor: Theme.of(context).colorScheme.onSurface,
                      ),
                      onDotClicked: (index) {
                        _pageController.animateToPage(
                          index,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease,
                        );
                      },
                    ),
                    SizedBox(height: AppSpacing.space16(context)),
                    CustomButton(
                      text:
                          _currentPage == _numPages - 1
                              ? "Commencer"
                              : "Suivant",
                      onTap: () {
                        if (_currentPage != _numPages - 1) {
                            _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                        } else {
                          showModalBottomSheet(
                            useSafeArea: true,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
                              ),
                              showDragHandle: true,
                              context: context, builder: (BuildContext context) => Padding(
                            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Login(),
                                    ],
                                  ),
                                ),
                              ));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
