import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

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
          'Terms of Use',
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
                  'Terms of Use',
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
                  '1. Acceptance of Terms',
                  'By accessing and using the Fixteck application, you accept and agree to be bound by the terms and provision of this agreement. If you do not agree to abide by the above, please do not use this service.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '2. Use License',
                  'Permission is granted to temporarily download one copy of the materials on Fixteck\'s application for personal, non-commercial transitory viewing only. This is the grant of a license, not a transfer of title, and under this license you may not:\n\n• Modify or copy the materials\n• Use the materials for any commercial purpose or for any public display\n• Attempt to decompile or reverse engineer any software contained in the application\n• Remove any copyright or other proprietary notations from the materials',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '3. Service Description',
                  'Fixteck provides a platform that connects users with service providers for various home maintenance and repair services. We facilitate the connection between users and service providers but are not responsible for the quality of services provided by third-party service providers.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '4. User Account',
                  'You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account or password. You must notify us immediately of any unauthorized use of your account.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '5. Payment Terms',
                  'All payments for services booked through Fixteck must be made through the application\'s payment system. By making a payment, you agree to our refund and cancellation policy. Prices are subject to change without notice.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '6. Limitation of Liability',
                  'In no event shall Fixteck or its suppliers be liable for any damages (including, without limitation, damages for loss of data or profit, or due to business interruption) arising out of the use or inability to use the materials on Fixteck\'s application, even if Fixteck or a Fixteck authorized representative has been notified orally or in writing of the possibility of such damage.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '7. Revisions and Errata',
                  'The materials appearing on Fixteck\'s application could include technical, typographical, or photographic errors. Fixteck does not warrant that any of the materials on its application are accurate, complete, or current. Fixteck may make changes to the materials contained on its application at any time without notice.',
                ),
                const SizedBox(height: 20),
                _buildSection(
                  context,
                  textTheme,
                  '8. Contact Information',
                  'If you have any questions about these Terms of Use, please contact us at support@fixteck.com or through the Help & Support section in the application.',
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

