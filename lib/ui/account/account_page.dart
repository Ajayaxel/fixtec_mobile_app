import 'package:flutter/material.dart';
import 'package:fixteck/ui/profile/profile_page.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  static const Color _backgroundColor = Color(0xFFF5F6FB);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).maybePop(),
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
        ),
        title: Text(
          'Settings',
          style: textTheme.titleMedium?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double horizontalPadding;
          if (constraints.maxWidth < 480) {
            horizontalPadding = 16;
          } else if (constraints.maxWidth < 768) {
            horizontalPadding = 24;
          } else {
            horizontalPadding = 48;
          }

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                horizontalPadding,
                24,
                horizontalPadding,
                24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _ReferralCard(textTheme: textTheme),
                  const SizedBox(height: 16),
                  _SettingsCard(textTheme: textTheme, items: _settingsItems),
                  const SizedBox(height: 16),
                  _LogoutButton(textTheme: textTheme),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ReferralCard extends StatelessWidget {
  const _ReferralCard({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),

      child: Row(
        children: [
          Image.asset(
            "assets/home/gift.png",
            height: 30,
            width: 30,
            fit: BoxFit.cover,
          ),
          SizedBox(width: 10),
          Text(
            "Earn",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(width: 5),
          Text(
            "AED 50",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Color(0xffF89900),
            ),
          ),
          SizedBox(width: 5),
          Text(
            "for every referral",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: Color(0xff4D4D4D),
            ),
          ),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              side: BorderSide(color: Colors.black, width: 1),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              elevation: 0,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              "refer now",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsCard extends StatelessWidget {
  const _SettingsCard({required this.textTheme, required this.items});

  final TextTheme textTheme;
  final List<_SettingItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          for (int index = 0; index < items.length; index++) ...[
            _SettingsTile(
              textTheme: textTheme,
              item: items[index],
              isLast: index == items.length - 1,
              onTap: () {
                if (items[index].title == 'Profile') {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ProfilePage(),
                    ),
                  );
                }
              },
            ),
          ],
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.textTheme,
    required this.item,
    required this.isLast,
    this.onTap,
  });

  final TextTheme textTheme;
  final _SettingItem item;
  final bool isLast;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: item.iconBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(item.icon, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.subtitle,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          indent: 20,
          endIndent: 20,
          color: Colors.grey.withOpacity(0.2),
        ),
      ],
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: 180,
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: Colors.white,
            side: const BorderSide(color: Colors.black26),
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          onPressed: () {},
          child: Text(
            'Log out',
            style: textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class _SettingItem {
  const _SettingItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.iconBackground,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color iconBackground;
}

const List<_SettingItem> _settingsItems = [
  _SettingItem(
    icon: Icons.person_outline,
    title: 'Profile',
    subtitle: 'Update personal information',
    iconBackground: Color(0xFF5C8BFF),
  ),
  _SettingItem(
    icon: Icons.favorite,
    title: 'Favourites',
    subtitle: 'Manage your favourite experts',
    iconBackground: Color(0xFFFFC857),
  ),
  _SettingItem(
    icon: Icons.block,
    title: 'Blocklist',
    subtitle: 'Manage your blocked experts',
    iconBackground: Color(0xFFFF7B7B),
  ),
  _SettingItem(
    icon: Icons.home_outlined,
    title: 'Addresses',
    subtitle: 'Manage saved addresses',
    iconBackground: Color(0xFFFFB16C),
  ),
  _SettingItem(
    icon: Icons.article_outlined,
    title: 'Policies',
    subtitle: 'Terms of us, Privacy policy and others',
    iconBackground: Color(0xFF6FC2FF),
  ),
  _SettingItem(
    icon: Icons.help_outline,
    title: 'Help & support',
    subtitle: 'Reach out to us in case you have a question',
    iconBackground: Color(0xFF8A9EFF),
  ),
];
