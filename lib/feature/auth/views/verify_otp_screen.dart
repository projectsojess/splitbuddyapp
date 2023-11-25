import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:splitbuddy/constants/asset_constants.dart";
import "package:splitbuddy/themes/pallete.dart";

class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());
  @override
  void dispose() {
    super.dispose();
    controllers.map((e) => e.dispose());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              Image.asset(
                AssetConstants.verifyOtpScreenImage,
                height: 250,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'VERIFY OTP',
                style: TextStyle(
                  color: Pallete.inputLabelTextColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontFamily: AssetConstants.fontPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Enter the 6-digit code sent to your  phone number to verify your account.',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: AssetConstants.fontPrimary,
                  color: Pallete.inputLabelTextColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  6,
                  (index) => SizedBox(
                    width: 40,
                    child: TextFormField(
                      controller: controllers[index],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      decoration: InputDecoration(
                          counterText: "",
                          focusedBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Pallete.buttonBgcolor),
                          )),
                      cursorColor: Pallete.buttonBgcolor,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          if (index < 5) {
                            FocusScope.of(context).nextFocus();
                          }
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Retrieve OTP from controllers
                  String enteredOTP = '';
                  for (TextEditingController controller in controllers) {
                    enteredOTP += controller.text;
                  }
                  // Use enteredOTP for verification or further processing
                  print('Entered OTP: $enteredOTP');
                },
                style: ElevatedButton.styleFrom(
                    primary: Pallete.buttonBgcolor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )),
                child: Text(
                  'Verify',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: AssetConstants.fontPrimary,
                    color: Pallete.inputLabelTextColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
