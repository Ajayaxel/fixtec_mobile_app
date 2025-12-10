import 'package:fixteck/ui/helpandsupport/help_support_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fixteck/bloc/login_bloc.dart';
import 'package:fixteck/bloc/login_event.dart';
import 'package:fixteck/bloc/login_state.dart';
import 'package:fixteck/bloc/profile_bloc.dart';
import 'package:fixteck/data/repositories/profile_repository.dart';
import 'package:fixteck/ui/profile/profile_page.dart';
import 'package:fixteck/ui/login/login_page.dart';
import 'package:fixteck/ui/favourites/favourites_screen.dart';
import 'package:fixteck/ui/blocklist/blocklist_screen.dart';
import 'package:fixteck/ui/bookings/select_address_page.dart';
import 'package:fixteck/ui/policies/policies_screen.dart';
import 'package:fixteck/core/utils/loading_helper.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  static const Color _backgroundColor = Color(0xFFF5F6FB);

  @override
  void initState() {
    super.initState();
    // Check authentication when page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LoginBloc>().add(const CheckAuthentication());
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LogoutLoading) {
          LoadingHelper.show(context: context, message: 'Logging out...');
        } else if (state is LogoutSuccess) {
          LoadingHelper.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.response.message),
              backgroundColor: Colors.green,
            ),
          );
          // Navigate to login page and clear navigation stack
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
          );
        } else if (state is LogoutFailure) {
          LoadingHelper.hide();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        } else if (state is Unauthenticated) {
          // Unauthenticated state is handled globally in main.dart
          // But we can show a message here if needed
          LoadingHelper.hide();
        }
      },
      child: Scaffold(
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
                final item = items[index];
                switch (item.title) {
                  case 'Profile':
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BlocProvider(
                          create: (context) => ProfileBloc(
                            profileRepository: context.read<ProfileRepository>(),
                          ),
                          child: const ProfilePage(),
                        ),
                      ),
                    );
                    break;
                  case 'Favourites':
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const FavouritesScreen(),
                      ),
                    );
                    break;
                  case 'Blocklist':
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const BlocklistScreen(),
                      ),
                    );
                    break;
                  case 'Addresses':
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SelectAddressPage(),
                      ),
                    );
                    break;
                  case 'Policies':
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const PoliciesScreen(),
                      ),
                    );
                    break;
                  case 'Help & support':
                 
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const HelpSupportScreen(),
                      ),
                    );
                    break;
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
                  width: 28,
                  height: 28,
                  child: item.imagePath != null
                      ? Image.asset(
                          item.imagePath!,
                          fit: BoxFit.contain,
                        )
                      : Icon(item.icon, color: Colors.black87),
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
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final isLoading = state is LogoutLoading;
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
              onPressed: isLoading
                  ? null
                  : () {
                      context.read<LoginBloc>().add(const LogoutRequested());
                    },
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
      },
    );
  }
}

class _SettingItem {
  const _SettingItem({
    this.icon,
    this.imagePath,
    required this.title,
    required this.subtitle,
  }) : assert(icon != null || imagePath != null, 'Either icon or imagePath must be provided');

  final IconData? icon;
  final String? imagePath;
  final String title;
  final String subtitle;
}

const List<_SettingItem> _settingsItems = [
  _SettingItem(
    imagePath: 'assets/account/tdesign_user-circle-filled.png',
    title: 'Profile',
    subtitle: 'Update personal information',
  ),
  _SettingItem(
    imagePath: 'assets/account/emojione-v1_crown (1).png',
    title: 'Favourites',
    subtitle: 'Manage your favourite experts',
  ),
  _SettingItem(
    imagePath: 'assets/account/fluent_presence-blocked-16-regular.png',
    title: 'Blocklist',
    subtitle: 'Manage your blocked experts',
  ),
  _SettingItem(
    imagePath: 'assets/account/fluent-color_home-48.png',
    title: 'Addresses',
    subtitle: 'Manage saved addresses',
  ),
  _SettingItem(
    imagePath: 'assets/account/lets-icons_file-dock-fill.png',
    title: 'Policies',
    subtitle: 'Terms of us, Privacy policy and others',
  ),
  _SettingItem(
    imagePath: "assets/account/Group.png",
    title: 'Help & support',
    subtitle: 'Reach out to us in case you have a question',
  ),
];
