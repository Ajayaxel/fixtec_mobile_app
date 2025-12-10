import 'package:fixteck/const/fixtec_btn.dart';
import 'package:fixteck/const/reward_conatiner.dart';
import 'package:fixteck/const/themes/app_themes.dart';
import 'package:fixteck/ui/servicedetails/service_details_screen.dart';
import 'package:fixteck/ui/wallet/wallet_screen.dart';
import 'package:fixteck/bloc/wallet_bloc.dart';
import 'package:fixteck/bloc/profile_bloc.dart';
import 'package:fixteck/bloc/profile_event.dart';
import 'package:fixteck/bloc/profile_state.dart';
import 'package:fixteck/data/repositories/wallet_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:async';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  final ScrollController _scrollController = ScrollController();
  Timer? _scrollTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startAutoScroll();
      // Fetch profile data when screen loads
      context.read<ProfileBloc>().add(const FetchProfile());
    });
  }

  void _startAutoScroll() {
    _scrollTimer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.position.pixels;

        if (currentScroll >= maxScroll) {
          // Reset to beginning for seamless loop
          _scrollController.jumpTo(0);
        } else {
          // Smooth scroll forward
          _scrollController.animateTo(
            currentScroll + 0.5,
            duration: const Duration(milliseconds: 30),
            curve: Curves.linear,
          );
        }
      }
    });
  }

  @override
  void dispose() {
    _scrollTimer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppThemes.bgColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 80,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 12.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Address Section
                Expanded(
                  child: BlocBuilder<ProfileBloc, ProfileState>(
                    builder: (context, state) {
                      String address = 'Loading...';
                      if (state is ProfileSuccess) {
                        address = state.response.data.customer.address;
                      } else if (state is ProfileFailure) {
                        address = 'Address not available';
                      }
                      
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Address',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            address,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(width: 12),

                // Wallet Section
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider(
                        create: (context) => WalletBloc(
                          walletRepository: context.read<WalletRepository>(),
                        ),
                        child: const WalletScreen(),
                      ),
                    ),
                  ),
                  child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Color(0xFFF1EDFB), // Light purple color
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assets/home/wallet.png",
                        height: 25,
                        width: 25,
                      ),
                      SizedBox(width: 6),
                      Text(
                        'AED 0',
                        style: TextStyle(
                          color: Color(0xFF1F2937), // Dark grey/black
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,

          children: [
            SizedBox(height: 15),
            Center(
              child: Text(
                "FIXTEK",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                "MAINTENANCE",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  letterSpacing: 1.7,
                ),
              ),
            ),
            Image.asset(
              "assets/home/cleaner2.svg fill.png",
              height: 300,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xff00343D).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/home/bi_lightning-charge-fill.png",
                      height: 18,
                      width: 18,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "House Help at your doorstep in 10 min",
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: AppThemes.bgBtnColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            // "We are currently live in" Section
            _buildLiveInSection(),

            Padding(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                top: 18,
                bottom: 18,
              ),
              child: Column(
                children: [
                  FixtecBtn(
                    onPressed: () {},
                    bgColor: AppThemes.bgBtnColor,
                    textColor: Colors.white,
                    child: Text("Request Fixtek in your area"),
                  ),
                  SizedBox(height: 25),
                  Text(
                    "See how FIXTEK can help you ",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Lorem Ipsum is simply dummy text of the printing industry.",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff747579),
                    ),
                  ),
                  SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailsScreen(serviceName: 'Plumbing'),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xffE5E7EB),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 12,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Plumbing",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "10.3k+",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff02A102),
                                            ),
                                          ),
                                          WidgetSpan(child: SizedBox(width: 4)),
                                          TextSpan(
                                            text: "Bookings",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff212529),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: 4,
                                  right: 6,
                                  child: Image.asset(
                                    "assets/home/Plumbing.png",
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ServiceDetailsScreen(serviceName: 'Electrical'),
                            ),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(left: 10, top: 10),
                            height: 120,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: Color(0xffE5E7EB),
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 12,
                                  offset: Offset(0, 8),
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Electrical",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: "10.3k+",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                              color: Color(0xff02A102),
                                            ),
                                          ),
                                          WidgetSpan(child: SizedBox(width: 4)),
                                          TextSpan(
                                            text: "Bookings",
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w500,
                                              color: Color(0xff212529),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Image.asset(
                                    "assets/home/Electrical.png",
                                    height: 70,
                                    width: 70,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Center(child: _buildQuickAccessServices()),
                  SizedBox(height: 30),
                  BannerWidget(),
                  SizedBox(height: 30),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Most booked services",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,

                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: MostBookedServices(),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                RewardConatiner()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLiveInSection() {
    const locations = [
      'SHARJAH',
      'ABU DHABI',
      'FUJAIRAH',
      'AJMAN',
      'BUR DUBAI',
    ];
    final tealColor = AppThemes.bgBtnColor; // Using the theme color for teal

    return Column(
      children: [
        // Title
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            children: [
              const TextSpan(text: 'We are currently '),
              TextSpan(
                text: 'live in',
                style: TextStyle(color: tealColor, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        // Auto-scrolling locations list
        Container(
          height: 30,
          child: ClipRect(
            child: SingleChildScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Render locations multiple times for seamless scroll
                  ...List.generate(3, (repeatIndex) {
                    return Row(
                      mainAxisSize: MainAxisSize.min,
                      children: locations.asMap().entries.map((entry) {
                        final index = entry.key;
                        final location = entry.value;
                        final isLast = index == locations.length - 1;

                        return Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              location,
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.normal,
                                color: Color(0xff70767E),
                                letterSpacing: 1.2,
                              ),
                            ),
                            if (!isLast || repeatIndex < 2)
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                ),
                                child: Text(
                                  '+',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: tealColor,
                                  ),
                                ),
                              ),
                          ],
                        );
                      }).toList(),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickAccessServices() {
    const services = <_QuickServiceCardData>[
      _QuickServiceCardData(
        title: 'Carpentry',
        assetPath: 'assets/home/Carpentry.png',
      ),
      _QuickServiceCardData(
        title: 'Cleaning',
        assetPath: 'assets/home/Cleaning.png',
      ),
      _QuickServiceCardData(
        title: 'Microwave Oven',
        assetPath: 'assets/home/Microwave Oven.png',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth == double.infinity
            ? MediaQuery.of(context).size.width
            : constraints.maxWidth;
        const double spacing = 12.0;
        final double cardWidth =
            ((screenWidth - spacing * (services.length - 1)) / services.length)
                .clamp(110.0, 220.0);
        final double cardHeight = (cardWidth * 0.90).clamp(130.0, 220.0);

        final cardWidgets = <Widget>[];
        for (int i = 0; i < services.length; i++) {
          final service = services[i];
          cardWidgets.add(
            SizedBox(
              width: cardWidth,
              child: GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ServiceDetailsScreen(serviceName: service.title),
                  ),
                ),
                child: Container(
                  height: cardHeight,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: const Color(0xffE5E7EB)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 12,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        service.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          service.assetPath,
                          width: cardWidth * 0.5,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
          if (i < services.length - 1) {
            cardWidgets.add(const SizedBox(width: spacing));
          }
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: cardWidgets,
        );
      },
    );
  }
}

class _QuickServiceCardData {
  final String title;
  final String assetPath;

  const _QuickServiceCardData({required this.title, required this.assetPath});
}

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final PageController _controller = PageController(viewportFraction: 0.92);
  final List<_BannerData> _items = const [
    _BannerData(
      subtitle: 'Turn Your',
      title: 'Door Into a',
      highlight: 'Smart One!',
      asset: 'assets/home/carousleimage.png',
    ),
    _BannerData(
      subtitle: 'Secure Your',
      title: 'Home With',
      highlight: 'Smart Locks!',
      asset: 'assets/home/carousleimage.png',
    ),
    _BannerData(
      subtitle: 'Upgrade To',
      title: 'Touch Access',
      highlight: 'Today!',
      asset: 'assets/home/carousleimage.png',
    ),
  ];

  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: SizedBox(
            height: 171,
            width: double.infinity,
            child: PageView.builder(
              controller: _controller,
              itemCount: _items.length,
              onPageChanged: (index) => setState(() => _currentPage = index),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: _BannerCard(data: _items[index]),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_items.length, (index) {
            final bool isActive = index == _currentPage;
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              height: 6,
              width: isActive ? 22 : 6,
              decoration: BoxDecoration(
                color: isActive
                    ? const Color(0xff00343D)
                    : const Color(0xffD1D5DB),
                borderRadius: BorderRadius.circular(12),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({required this.data});

  final _BannerData data;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(data.asset),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            data.subtitle,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Text(
            data.title,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            data.highlight,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
              color: Color(0xffF7941D),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: 80,
            height: 26,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff00343D),
                foregroundColor: Colors.white,
                elevation: 0,
                minimumSize: const Size(65, 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
              child: const FittedBox(
                child: Text(
                  'Explore',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerData {
  final String subtitle;
  final String title;
  final String highlight;
  final String asset;

  const _BannerData({
    required this.subtitle,
    required this.title,
    required this.highlight,
    required this.asset,
  });
}

class MostBookedServices extends StatelessWidget {
  const MostBookedServices({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ServiceDetailsScreen(serviceName: 'Pest control'),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Image.asset(
            "assets/home/Container (2).png",
            height: 145,
            width: 145,
            fit: BoxFit.cover,
          ),
          SizedBox(height: 5),
          Text(
            "Pest control (includes\nutensil removal ",
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 5),
          Row(
            children: [
              Icon(Icons.star, color: CupertinoColors.inactiveGray, size: 16),
              Text(
                "4.79 (117K)",
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff0F0F0F),
                ),
              ),
            ],
          ),
          SizedBox(height: 5),
          Text(
            "  ₹1,098 ",
            style: TextStyle(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: Color(0xff0F0F0F),
            ),
          ),
        ],
      ),
    );
  }
}
