import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    const Color backgroundColor = Color(0xFFF5F6FB);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
        title: Text(
          'Privacy Policy',
          style: textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Policy',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Last updated: ${DateTime.now().toString().split(' ')[0]}',
                  style: textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  context,
                  textTheme,
                  '1. Introduction',
                  'Fixteck ("we," "our," or "us") is committed to protecting your privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application and services.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '2. Information We Collect',
                  'We collect information that you provide directly to us, including:\n\n• Personal Information: Name, email address, phone number, and address\n• Account Information: Username, password, and profile information\n• Service Information: Booking details, service history, and preferences\n• Payment Information: Payment method details (processed securely through third-party payment processors)\n• Device Information: Device type, operating system, and unique device identifiers\n• Location Information: Your location when you use location-based features',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '3. How We Use Your Information',
                  'We use the information we collect to:\n\n• Provide, maintain, and improve our services\n• Process transactions and send related information\n• Send you technical notices, updates, and support messages\n• Respond to your comments, questions, and requests\n• Monitor and analyze trends, usage, and activities\n• Personalize and improve your experience\n• Detect, prevent, and address technical issues and fraudulent activity',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '4. Information Sharing and Disclosure',
                  'We do not sell, trade, or rent your personal information to third parties. We may share your information in the following circumstances:\n\n• With service providers who perform services on our behalf\n• When required by law or to respond to legal process\n• To protect the rights, property, or safety of Fixteck, our users, or others\n• In connection with a merger, acquisition, or sale of assets',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '5. Data Security',
                  'We implement appropriate technical and organizational security measures to protect your personal information. However, no method of transmission over the Internet or electronic storage is 100% secure, and we cannot guarantee absolute security.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '6. Your Rights and Choices',
                  'You have the right to:\n\n• Access and receive a copy of your personal data\n• Rectify inaccurate or incomplete data\n• Request deletion of your personal data\n• Object to processing of your personal data\n• Request restriction of processing\n• Data portability\n• Withdraw consent at any time',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '7. Cookies and Tracking Technologies',
                  'We use cookies and similar tracking technologies to track activity on our application and hold certain information. You can instruct your device to refuse all cookies or to indicate when a cookie is being sent.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '8. Children\'s Privacy',
                  'Our services are not intended for children under the age of 18. We do not knowingly collect personal information from children under 18. If you are a parent or guardian and believe your child has provided us with personal information, please contact us.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '9. Changes to This Privacy Policy',
                  'We may update our Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last updated" date. You are advised to review this Privacy Policy periodically for any changes.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '10. Contact Us',
                  'If you have any questions about this Privacy Policy, please contact us at:\n\nEmail: privacy@fixteck.com\nSupport: support@fixteck.com\n\nOr through the Help & Support section in the application.',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    TextTheme textTheme,
    String title,
    String content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: textTheme.bodyMedium?.copyWith(
            color: Colors.black87,
            height: 1.6,
          ),
        ),
      ],
    );
  }
}

