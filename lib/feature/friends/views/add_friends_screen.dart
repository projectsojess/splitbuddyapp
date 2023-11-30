import 'package:flutter/material.dart';
import 'package:splitbuddy/common/common.dart';
import 'package:splitbuddy/feature/widgets/input_field.dart';
import 'package:splitbuddy/services/friends_service.dart';
import 'package:splitbuddy/themes/pallete.dart';

class AddFriendsScreen extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddFriendsScreen());

  const AddFriendsScreen({super.key});

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  final FriendsService _service = FriendsService();

  void addUser() {
    _service.addFriend(
        context: context,
        email: _emailController.text,
        phone: _phoneController.text);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _phoneController.dispose();
  }

  bool showError = false;
  String? _validateEmail(String? value) {
    if (value!.isEmpty && _phoneController.text.isEmpty) {
      setState(() {
        showError = true;
      });
      return null;
    } else {
      setState(() {
        showError = false;
      });
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InputField(
                    editingController: _emailController,
                    inputType: TextInputType.emailAddress,
                    icon: Icons.email,
                    label: 'Email',
                    validator: _validateEmail,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  InputField(
                    editingController: _phoneController,
                    inputType: TextInputType.phone,
                    icon: Icons.phone,
                    label: 'Phone',
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      _formKey.currentState!.validate();
                      if (!showError) {
                        String email = _emailController.text;
                        String phoneNumber = _phoneController.text;
                        addUser();
                      } else {
                        showSnackbar(
                            context, 'Please enter an email or phone number ');
                      }
                    },
                    label: Text('Add Friend'),
                    icon: Icon(Icons.person_add),
                    style: ElevatedButton.styleFrom(
                        primary: Pallete.secondaryColor),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
