import 'package:flutter/material.dart';
import 'package:meetyarah/assetsPath/image_url.dart';
import 'package:meetyarah/assetsPath/textColors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(ImagePath.appLogo),

            Textfromfield(
              icon: Icons.account_box,
              text: 'Email or Phone Number',
            ),
            SizedBox(height: 8),
            Textfromfield(icon: Icons.lock, text: 'Password'),
            TextButton(onPressed: (){},
                child: Text("Forgot Password",style: TextStyle(
                    color: ColorPath.deepBlue,fontSize: 16
                ),)),
            SizedBox(height: 16),
            containnerBox(
              bgColors: ColorPath.deepBlue,
              text: "LOGIN",
              textColors: Colors.white,
            ),
            SizedBox(height: 14),
            Text("-------------------------or-------------------------",
              style: TextStyle(color: Colors.grey,
              fontSize: 18
              ),),
            SizedBox(height: 14),
            containnerBox(bgColors: Colors.white,
                text: 'Sign up by google',
                prefixIcons: ImagePath.gogoleIcon,
                textColors: Colors.black),

          ],
        ),
      ),
    );
  }
}

class containnerBox extends StatelessWidget {
  const containnerBox({
    super.key,
    required this.bgColors,
    required this.text,
    this.prefixIcons,
    required this.textColors,
  });

  final Color bgColors;
  final String text;
  final String? prefixIcons;
  final Color textColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: bgColors,
        borderRadius: BorderRadius.circular(15)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (prefixIcons != null) ...[
            Image.asset(prefixIcons!, height: 24, width: 24),
            SizedBox(width: 8),
          ],
          Text(text,style: TextStyle(color: textColors,
          fontSize: 16,fontWeight: FontWeight.bold),)
        ],
      )
    );
  }
}

class Textfromfield extends StatelessWidget {
  const Textfromfield({super.key, this.icon, this.text});

  final icon;
  final text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        prefixIcon: Icon(icon),
        labelText: text,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20)
        ),
      ),
    );
  }
}
