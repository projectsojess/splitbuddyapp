import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:splitbuddy/constants/asset_constants.dart';
import 'package:splitbuddy/constants/ui_constants.dart';
import 'package:splitbuddy/themes/theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AssetConstants.welcomeScreenImage,
                  height: 300,
                ),
                SizedBox(
                  height: 40,
                ),
                UIConstants.getAppTitle(32.0),
                SizedBox(
                  height: 10,
                ),
                UIConstants.getText('Split expenses with friends', 16.0),
                SizedBox(
                  height: 80,
                ),
                Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Pallete.buttonBgcolor,
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Center(
                        child: SvgPicture.asset(
                          AssetConstants.arrowRight,
                          width: 40,
                          height: 40,
                          color: Pallete.inputLabelTextColor,
                        ),
                      ),
                    ))
              ],
            )),
      ),
    );
  }
}
