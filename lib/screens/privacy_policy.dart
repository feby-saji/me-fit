import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'This Privacy Policy explains how Flutter Fitness App (the "App") collects, uses, and discloses your personal information. By using the App, you agree to the terms of this Privacy Policy.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'Information We Collect',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'We collect the following types of information from you:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '* Personal information: This is information that can be used to identify you, such as your name, email address, and phone number. You provide us with personal information when you create an account, sign up for our newsletter, or contact customer support.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '* Usage data: This is information about how you use the App, such as the features you access, the workouts you do, and the data you sync with the App. We collect usage data automatically when you use the App.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'How We Use Your Information',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'We use your personal information to provide you with the App\'s services, such as to:',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '* Create and manage your account',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '* Provide you with access to the App\'s features',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '* Send you notifications about your workouts and progress',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '* Provide you with customer support',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                'We use your usage data to improve the App and to provide you with a more personalized experience. We may also use your usage data for research purposes, but we will always anonymize your data before using it for research.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 16.0),
              Text(
                'How We Disclose Your Information',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'We do not sell or rent your personal information to third parties. We may share your personal information with third-party service providers who help us to operate the App and to provide you with the App\'s services. For example, we may share your personal information with a third-party service provider that helps us to send you notifications or to provide you with customer support.',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(height: 8.0),
              Text(
                  'We may also disclose your personal information if we are required to do so by law or if we believe that it is necessary to'),
            ],
          ),
        ),
      ),
    );
  }
}
