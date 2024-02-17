import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About Us',
          style: TextStyle(color: Color(0xFF24CCCC)),
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome to Medimate – Your Personal Medication Companion!',
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 16.0),
            Text(
              'Our Mission',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10.0),
            Text(
              'At Medimate, our mission is to empower individuals to take control of their health by simplifying medication management. We believe that managing medications should be a stress-free experience, and we\'re dedicated to providing a solution that enhances the well-being of our users.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'What Sets Us Apart',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10.0),
            Text(
              '- User-Centric Approach: Medimate is designed with you in mind. We understand the challenges of medication management and have created an intuitive and user-friendly app to streamline the process.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5.0),
            Text(
              '- Personalized Medication Plans: We recognize that everyone\'s health journey is unique. Medimate allows you to create personalized medication plans, ensuring that your schedule aligns with your lifestyle.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5.0),
            Text(
              '- Smart Reminders: Never miss a dose again! Medimate sends intelligent reminders based on your medication schedule, helping you stay on track with your health routine.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5.0),
            Text(
              '- Secure and Confidential: Your health information is sensitive, and we take your privacy seriously. Medimate employs robust security measures to safeguard your data, so you can manage your health with peace of mind.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            Text(
              'How It Works',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10.0),
            Text(
              '1. Register: Create your Medimate account by providing some basic information. We prioritize a hassle-free registration process to get you started quickly.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5.0),
            Text(
              '2. Add Medications: Input your medication details into the app, including dosage, schedule, and any specific instructions. Medimate will organize this information for you.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5.0),
            Text(
              '3. Receive Smart Reminders: Medimate\'s smart reminders will notify you when it\'s time to take your medications. Customize your notification preferences for a seamless experience.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5.0),
            Text(
              '4. Track Your Progress: Monitor your medication adherence and view your health progress over time. Medimate provides insights to help you stay informed about your health journey.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            Text(
              'Join Us on the Path to Better Health',
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 10.0),
            Text(
              'Medimate is more than just an app; it\'s a partner in your health journey. We invite you to join our community of users who have embraced a simpler, more organized approach to medication management.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 5.0),
            Text(
              'Your health is your most valuable asset, and Medimate is here to support you every step of the way.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20.0),
            Text(
              'Download Medimate today and take the first step toward a healthier, more organized life.',
              style:
                  TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
