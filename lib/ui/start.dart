import 'package:flutter/material.dart';
import 'login.dart';
import 'signup.dart';

class Start extends StatelessWidget {
  const Start({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const SizedBox(height: 100),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Login()),
                    );
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Signup()),
                    );
                  },
                  child: const Text('Signup'),
                ),
              ],
            ),
            const Text(
              'Information about Blood Donation',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Benefits of Blood Donation:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildBenefitItem(
              'Saves Lives:',
              'Blood donation can help save lives by providing essential blood transfusions for individuals in need, such as accident victims, surgical patients, and individuals with certain medical conditions.',
            ),
            _buildBenefitItem(
              'Health Benefits for Donors:',
              'Regular blood donation is associated with various health benefits, including a reduced risk of heart disease, improved blood flow, and the stimulation of new blood cell production.',
            ),
            _buildBenefitItem(
              'Free Health Check-up:',
              'Blood donors often receive a free health check-up as part of the donation process. This can help identify any underlying health issues and provide an opportunity for early detection and intervention.',
            ),
            _buildBenefitItem(
              'Emotional Well-being:',
              'Knowing that your blood donation can make a positive impact on someone\'s life can provide a sense of fulfillment and happiness.',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitItem(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 16),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
