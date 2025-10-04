import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

void main() {
  runApp(const MyPortfolioApp());
}

class MyPortfolioApp extends StatelessWidget {
  const MyPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ekanth Portfolio',
      theme: _buildLightTheme(),
      darkTheme: _buildDarkTheme(),
      themeMode: ThemeMode.system,
      home: const PortfolioPage(),
      debugShowCheckedModeBanner: false,
    );
  }

  ThemeData _buildLightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1),
        brightness: Brightness.light,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }

  ThemeData _buildDarkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF6366F1),
        brightness: Brightness.dark,
      ),
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

class PortfolioPage extends StatefulWidget {
  const PortfolioPage({super.key});

  @override
  State<PortfolioPage> createState() => _PortfolioPageState();
}

class _PortfolioPageState extends State<PortfolioPage> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(4, (index) => GlobalKey());

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        title: FadeInDown(
          child: Text(
            MediaQuery.of(context).size.width < 600
                ? 'Ekanth'
                : 'Ekanth Portfolio',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.width < 600 ? 20 : 24,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          FadeInRight(
            child: IconButton(
              onPressed: () => _scrollToSection(3),
              icon: const Icon(Icons.contact_mail),
              tooltip: 'Contact',
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary.withOpacity(0.1),
                Theme.of(context).colorScheme.secondary.withOpacity(0.05),
                Theme.of(context).colorScheme.tertiary.withOpacity(0.1),
              ],
            ),
          ),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const ClampingScrollPhysics(),
            child: Column(
              children: [
                HomeSection(key: _sectionKeys[0]),
                ProjectsSection(key: _sectionKeys[1]),
                SkillsSection(key: _sectionKeys[2]),
                ContactSection(key: _sectionKeys[3]),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:
          MediaQuery.of(context).size.width > 400
              ? _buildNavigationFAB()
              : null,
    );
  }

  Widget _buildNavigationFAB() {
    return SlideInUp(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton.small(
            heroTag: "home",
            onPressed: () => _scrollToSection(0),
            child: const Icon(Icons.home),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: "projects",
            onPressed: () => _scrollToSection(1),
            child: const Icon(Icons.work),
          ),
          const SizedBox(height: 8),
          FloatingActionButton.small(
            heroTag: "skills",
            onPressed: () => _scrollToSection(2),
            child: const Icon(Icons.star),
          ),
        ],
      ),
    );
  }
}

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Container(
      constraints: BoxConstraints(
        minHeight:
            isSmallScreen
                ? MediaQuery.of(context).size.height * 0.9
                : MediaQuery.of(context).size.height,
      ),
      padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInDown(
            duration: const Duration(milliseconds: 1000),
            child: Hero(
              tag: 'profile',
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(
                        context,
                      ).colorScheme.primary.withOpacity(0.3),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: CircleAvatar(
                  radius: isSmallScreen ? 60 : 80,
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primary.withOpacity(0.1),
                  child: CircleAvatar(
                    radius: isSmallScreen ? 55 : 75,
                    backgroundImage: const AssetImage(
                      'assets/images/profile.jpeg',
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          FadeInUp(
            delay: const Duration(milliseconds: 300),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'Ekanth Gundanahalli Prakash',
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 24 : 32,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
              ),
            ),
          ),
          const SizedBox(height: 15),
          FadeInUp(
            delay: const Duration(milliseconds: 500),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                isSmallScreen
                    ? 'Flutter Developer'
                    : 'Software Engineer | Flutter Developer',
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 14 : 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 30),
          FadeInUp(
            delay: const Duration(milliseconds: 700),
            child: Container(
              width: double.infinity,
              constraints: BoxConstraints(
                minHeight: isSmallScreen ? 160 : 140,
                maxHeight: isSmallScreen ? 200 : 180,
              ),
              child: GlassmorphicContainer(
                width: double.infinity,
                height: isSmallScreen ? 180 : 150,
                borderRadius: 20,
                blur: 20,
                alignment: Alignment.center,
                border: 2,
                linearGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.1),
                    Colors.white.withOpacity(0.05),
                  ],
                ),
                borderGradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white.withOpacity(0.2),
                    Colors.white.withOpacity(0.1),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                  child: SingleChildScrollView(
                    child: Text(
                      'Software Engineer with 3+ years of experience in cross-platform development using Flutter, Kotlin, and Swift. Skilled in CI/CD, scalable cloud integration (Firebase, GCP), and performance optimization across iOS and Android. Strong focus on clean architecture, testing, and building platform-level tools.',
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 13 : 16,
                        height: isSmallScreen ? 1.4 : 1.5,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: isSmallScreen ? 5 : null,
                      overflow: isSmallScreen ? TextOverflow.fade : null,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          FadeInUp(
            delay: const Duration(milliseconds: 900),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: isSmallScreen ? 12 : 20,
              runSpacing: 12,
              children: [
                _buildSocialButton(
                  context,
                  FontAwesomeIcons.linkedin,
                  'https://www.linkedin.com/in/ekanth-gp-5b65481a5/',
                  const Color(0xFF0077B5),
                  isSmallScreen,
                ),
                _buildSocialButton(
                  context,
                  FontAwesomeIcons.envelope,
                  'mailto:ekanthgp57@gmail.com',
                  Theme.of(context).colorScheme.primary,
                  isSmallScreen,
                ),
                _buildSocialButton(
                  context,
                  FontAwesomeIcons.github,
                  'https://github.com/Ekanth57',
                  const Color(0xFF333333),
                  isSmallScreen,
                ),
              ],
            ),
          ),
          SizedBox(height: isSmallScreen ? 40 : 20),
        ],
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context,
    IconData icon,
    String url,
    Color color,
    bool isSmallScreen,
  ) {
    return GestureDetector(
      onTap: () => _launchUrl(url),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.all(isSmallScreen ? 10 : 15),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 15),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: FaIcon(icon, color: color, size: isSmallScreen ? 18 : 24),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final projects = [
      Project(
        title: 'Japanese Restaurant Management System',
        summary:
            'Flutter web application for restaurant operations (Freelancing)',
        description:
            'Developed a comprehensive restaurant management system for a Japanese restaurant as a freelancing project. The application streamlines restaurant operations with table booking management, real-time notifications, and automated communication systems. Features include customer booking interface, admin dashboard for restaurant owners, FCM push notifications to mobile devices, automated email triggers for booking confirmations and updates. Built with Flutter for cross-platform compatibility and integrated with Firebase for real-time data synchronization and reliable backend services.',
        tech: [
          'Flutter',
          'Dart',
          'Firebase',
          'FCM (Push Notifications)',
          'Email Integration',
          'Firestore Database',
          'Firebase Hosting',
          'Responsive Web Design',
          'Real-time Updates',
          'Admin Dashboard',
          'Booking System',
          'Authentication',
        ],
        images: [
          'assets/images/web-project-1.png',
          'assets/images/web-project-2.png',
          'assets/images/web-project-3.png',
          'assets/images/web-project-4.png',
          'assets/images/web-project-5.png',
          'assets/images/web-project-6.png',
          'assets/images/web-project-7.png',
          'assets/images/web-project-8.png',
        ],
        logoPath: 'assets/images/logo-web-project.png',
        color: const Color(0xFF9C27B0),
        websiteUrl: 'https://web-project-46bb2.firebaseapp.com',
      ),
      Project(
        title: 'Restaurant Manager Mobile App',
        summary: 'Mobile app for restaurant owner to manage bookings.',
        description:
            'Developed a companion mobile application specifically for the Japanese restaurant owner to efficiently manage table bookings and customer interactions. This native mobile app provides real-time booking management, push notifications for new reservations, customer communication tools, and comprehensive analytics dashboard. Features include booking status updates, customer details management, table availability control, and direct communication with customers through in-app messaging. Seamlessly integrates with the web-based restaurant management system for unified operations.',
        tech: [
          'Flutter',
          'Dart',
          'Firebase',
          'FCM (Push Notifications)',
          'Firestore Database',
          'Real-time Sync',
          'Authentication',
          'Material Design 3',
          'Provider State Management',
          'Cloud Functions',
          'Analytics Dashboard',
          'In-app Messaging',
        ],
        images: [
          'assets/images/mobile-project-1.jpeg',
          'assets/images/mobile-project-2.jpeg',
          'assets/images/mobile-project-3.jpeg',
          'assets/images/mobile-project-4.jpeg',
          'assets/images/mobile-project-5.jpeg',
          'assets/images/mobile-project-6.jpeg',
          'assets/images/mobile-project-7.jpeg',
        ],
        logoPath: 'assets/images/logo-web-project.png',
        color: const Color(0xFFFF5722),
        websiteUrl: null,
      ),
      Project(
        title: 'ParkON - Parking App',
        summary: 'Hassle-free parking booking platform.',
        description:
            'Designed and developed a crowd-sourced parking solution allowing users to reserve and navigate to available parking spots across homes, apartments, malls, airports, and multilevel complexes. Integrated EV charging points onboarding, live availability status, secure payment gateway, and map-based spot discovery.',
        tech: [
          'Flutter',
          'Firebase',
          'Google Maps',
          'Cloud Functions',
          'REST APIs',
          'Provider',
          'GitHub Actions',
          'Docker',
          'GCP',
        ],
        images: [
          'assets/images/parkon-1.jpg',
          'assets/images/parkon-2.jpg',
          'assets/images/parkon-3.jpg',
          'assets/images/parkon-4.jpg',
          'assets/images/parkon-5.jpg',
        ],
        logoPath: 'assets/images/logo-parkon.png',
        color: const Color(0xFF4CAF50),
        websiteUrl: null,
      ),
      Project(
        title: 'EPod - EV Charging App',
        summary: 'AI-assisted futuristic EV charging experience.',
        description:
            'Built a futuristic AI-assisted EV charging app with real-time location discovery, booking, and crowd-sourced onboarding of EV chargers. Implemented predictive availability based on usage data, automated notifications, dynamic charger management for hosts, and wallet integration for payments.',
        tech: [
          'Flutter',
          'Firebase',
          'Google Maps',
          'Cloud Functions',
          'Provider',
          'WebSockets',
          'AI/ML',
        ],
        images: [
          'assets/images/epod-1.jpg',
          'assets/images/epod-2.jpg',
          'assets/images/epod-3.jpg',
          'assets/images/epod-4.jpg',
          'assets/images/epod-5.jpg',
        ],
        logoPath: 'assets/images/logo-epod.png',
        color: const Color(0xFF2196F3),
        websiteUrl: null,
      ),
      Project(
        title: 'Rentl - Property Searching App',
        summary: 'Map-based transparent rental search platform.',
        description:
            'Developed a user-friendly mobile platform allowing property owners to list rentals directly. Integrated precise geolocation search, route calculation, and map-based browsing. Enabled users to find rental homes, PGs, apartments, and commercial spaces with transparent pricing and no brokerage',
        tech: [
          'Flutter',
          'Google Maps',
          'Firestore',
          'Cloud Functions',
          'Stripe API',
          'Provider',
          'Bloc',
        ],
        images: [
          'assets/images/rentl-1.jpg',
          'assets/images/rentl-2.jpg',
          'assets/images/rentl-3.jpg',
          'assets/images/rentl-4.jpg',
        ],
        logoPath: 'assets/images/logo-rentl.png',
        color: const Color(0xFFFF9800),
        websiteUrl: null,
      ),
      Project(
        title: 'ATG - Farmers Marketplace App',
        summary: 'One-stop agriculture solution for African farmers.',
        description:
            'Built a digital platform providing weather forecasting, crop advisory, fertilizer recommendation, seed sourcing, agri-product purchasing, and news updates for farmers. Deployed live weather APIs, built offline-first architecture, and integrated farmer training modules to enhance agricultural productivity',
        tech: [
          'Kotlin',
          'ROOM Database',
          'Retrofit',
          'Firebase',
          'REST APIs',
          'LiveData',
          'ViewModel',
          'Hilt DI',
        ],
        images: [
          'assets/images/ATG-1.jpg',
          'assets/images/ATG-2.jpg',
          'assets/images/ATG-3.jpg',
          'assets/images/ATG-4.jpg',
        ],
        logoPath: 'assets/images/logo-atg.png',
        color: const Color(0xFF8BC34A),
        websiteUrl: null,
      ),
    ];

    return Container(
      padding: EdgeInsets.only(
        top: isSmallScreen ? 60 : 80,
        bottom: isSmallScreen ? 40 : 60,
        left: isSmallScreen ? 16 : 20,
        right: isSmallScreen ? 16 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeInDown(
            child: Text(
              'Featured Projects',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width < 600 ? 28 : 36,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 10),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 40),
          AnimationLimiter(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: ModernProjectCard(
                        project: projects[index],
                        index: index,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Project {
  final String title;
  final String summary;
  final String description;
  final List<String> tech;
  final List<String> images;
  final String logoPath;
  final Color color;
  final String? websiteUrl;

  Project({
    required this.title,
    required this.summary,
    required this.description,
    required this.tech,
    required this.images,
    required this.logoPath,
    required this.color,
    this.websiteUrl,
  });
}

class ModernProjectCard extends StatefulWidget {
  final Project project;
  final int index;

  const ModernProjectCard({
    super.key,
    required this.project,
    required this.index,
  });

  @override
  State<ModernProjectCard> createState() => _ModernProjectCardState();
}

class _ModernProjectCardState extends State<ModernProjectCard>
    with SingleTickerProviderStateMixin {
  int activeIndex = 0;
  final CarouselSliderController carouselController =
      CarouselSliderController();
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Container(
      margin: EdgeInsets.only(bottom: isSmallScreen ? 30 : 40),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform: Matrix4.identity()..scale(isHovered ? 1.02 : 1.0),
          child: Container(
            width: double.infinity,
            constraints: BoxConstraints(minHeight: isSmallScreen ? 500 : 600),
            child: GlassmorphicContainer(
              width: double.infinity,
              height: isSmallScreen ? 600 : 700,
              borderRadius: isSmallScreen ? 20 : 25,
              blur: 20,
              alignment: Alignment.topCenter,
              border: 2,
              linearGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.05),
                ],
              ),
              borderGradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.project.color.withOpacity(0.3),
                  widget.project.color.withOpacity(0.1),
                ],
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: widget.project.color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Image.asset(
                            widget.project.logoPath,
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.project.title,
                                style: GoogleFonts.poppins(
                                  fontSize: isSmallScreen ? 18 : 24,
                                  fontWeight: FontWeight.w700,
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.project.summary,
                                style: GoogleFonts.poppins(
                                  fontSize: isSmallScreen ? 14 : 16,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface.withOpacity(0.7),
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        CarouselSlider.builder(
                          carouselController: carouselController,
                          itemCount: widget.project.images.length,
                          itemBuilder: (context, index, realIndex) {
                            final img = widget.project.images[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: widget.project.color.withOpacity(
                                      0.2,
                                    ),
                                    blurRadius: 15,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(img, fit: BoxFit.cover),
                              ),
                            );
                          },
                          options: CarouselOptions(
                            height: isSmallScreen ? 300 : 400,
                            enlargeCenterPage: true,
                            enableInfiniteScroll: true,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 4),
                            viewportFraction: isSmallScreen ? 0.85 : 0.7,
                            enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                            onPageChanged: (index, reason) {
                              setState(() {
                                activeIndex = index;
                              });
                            },
                          ),
                        ),
                        // Left Navigation Button
                        Positioned(
                          left: isSmallScreen ? 8 : 16,
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.project.color.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                carouselController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                                size: isSmallScreen ? 18 : 20,
                              ),
                              padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                            ),
                          ),
                        ),
                        // Right Navigation Button
                        Positioned(
                          right: isSmallScreen ? 8 : 16,
                          child: Container(
                            decoration: BoxDecoration(
                              color: widget.project.color.withOpacity(0.9),
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 8,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            child: IconButton(
                              onPressed: () {
                                carouselController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: isSmallScreen ? 18 : 20,
                              ),
                              padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Center(
                      child: AnimatedSmoothIndicator(
                        activeIndex: activeIndex,
                        count: widget.project.images.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: widget.project.color,
                          dotColor: widget.project.color.withOpacity(0.3),
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 3,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.project.description,
                      style: GoogleFonts.poppins(
                        fontSize: isSmallScreen ? 14 : 16,
                        height: 1.6,
                        color: Theme.of(
                          context,
                        ).colorScheme.onSurface.withOpacity(0.8),
                      ),
                      maxLines: isSmallScreen ? 4 : null,
                      overflow: isSmallScreen ? TextOverflow.ellipsis : null,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Technologies Used:',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: isSmallScreen ? 6 : 8,
                      runSpacing: isSmallScreen ? 6 : 8,
                      children:
                          widget.project.tech
                              .map(
                                (tech) => _buildTechChip(tech, isSmallScreen),
                              )
                              .toList(),
                    ),
                    if (widget.project.websiteUrl != null) ...[
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton.icon(
                          onPressed:
                              () => _launchUrl(widget.project.websiteUrl!),
                          icon: const FaIcon(FontAwesomeIcons.globe, size: 16),
                          label: Text(
                            'Visit Website',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: widget.project.color,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(
                              horizontal: isSmallScreen ? 20 : 24,
                              vertical: isSmallScreen ? 12 : 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildTechChip(String tech, bool isSmallScreen) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      margin: const EdgeInsets.only(right: 6, bottom: 6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            widget.project.color.withOpacity(0.2),
            widget.project.color.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: widget.project.color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        tech,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: widget.project.color,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  Map<String, SkillData> get skills => {
    'Flutter': SkillData(
      0.95,
      FontAwesomeIcons.mobile,
      const Color(0xFF02569B),
    ),
    'Dart': SkillData(0.90, FontAwesomeIcons.code, const Color(0xFF0175C2)),
    'Firebase': SkillData(0.85, FontAwesomeIcons.fire, const Color(0xFFFFCA28)),
    'Google Cloud': SkillData(
      0.80,
      FontAwesomeIcons.cloud,
      const Color(0xFF4285F4),
    ),
    'Kotlin': SkillData(
      0.85,
      FontAwesomeIcons.android,
      const Color(0xFF7F52FF),
    ),
    'Swift': SkillData(0.75, FontAwesomeIcons.apple, const Color(0xFFFA7343)),
    'AWS': SkillData(0.70, FontAwesomeIcons.aws, const Color(0xFFFF9900)),
    'Python': SkillData(0.80, FontAwesomeIcons.python, const Color(0xFF3776AB)),
    'CI/CD': SkillData(0.85, FontAwesomeIcons.github, const Color(0xFF181717)),
  };

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 40 : 60,
        horizontal: isSmallScreen ? 16 : 20,
      ),
      child: Column(
        children: [
          FadeInDown(
            child: Text(
              'Technical Skills',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width < 600 ? 28 : 36,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 50),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isSmallScreen ? 3 : 4,
              crossAxisSpacing: isSmallScreen ? 12 : 20,
              mainAxisSpacing: isSmallScreen ? 12 : 20,
              childAspectRatio: isSmallScreen ? 1.1 : 1.3,
            ),
            itemCount: skills.length,
            itemBuilder: (context, index) {
              final skillName = skills.keys.elementAt(index);
              final skillData = skills[skillName]!;
              return SlideInUp(
                delay: Duration(milliseconds: index * 100),
                child: _buildSkillCard(
                  context,
                  skillName,
                  skillData,
                  isSmallScreen,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSkillCard(
    BuildContext context,
    String skillName,
    SkillData skillData,
    bool isSmallScreen,
  ) {
    return Container(
      width: double.infinity,
      height: isSmallScreen ? 120 : 140,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: isSmallScreen ? 120 : 140,
        borderRadius: isSmallScreen ? 16 : 20,
        blur: 20,
        alignment: Alignment.center,
        border: 2,
        linearGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
        ),
        borderGradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            skillData.color.withOpacity(0.3),
            skillData.color.withOpacity(0.1),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 15 : 18),
                decoration: BoxDecoration(
                  color: skillData.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FaIcon(
                  skillData.icon,
                  color: skillData.color,
                  size: isSmallScreen ? 28 : 32,
                ),
              ),
              SizedBox(height: isSmallScreen ? 12 : 15),
              Text(
                skillName,
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SkillData {
  final double proficiency;
  final IconData icon;
  final Color color;

  SkillData(this.proficiency, this.icon, this.color);
}

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    final contactItems = [
      ContactItem(
        icon: FontAwesomeIcons.envelope,
        title: 'Email',
        subtitle: 'ekanthgp57@gmail.com',
        url: 'mailto:ekanthgp57@gmail.com',
        color: const Color(0xFFEA4335),
      ),
      ContactItem(
        icon: FontAwesomeIcons.linkedin,
        title: 'LinkedIn',
        subtitle: 'Connect with me',
        url: 'https://www.linkedin.com/in/ekanth-gp-5b65481a5/',
        color: const Color(0xFF0077B5),
      ),
      ContactItem(
        icon: FontAwesomeIcons.github,
        title: 'GitHub',
        subtitle: 'View my code',
        url: 'https://github.com/Ekanth57',
        color: const Color(0xFF333333),
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 40 : 60,
        horizontal: isSmallScreen ? 16 : 20,
      ),
      child: Column(
        children: [
          FadeInDown(
            child: Text(
              'Let\'s Connect',
              style: GoogleFonts.poppins(
                fontSize: MediaQuery.of(context).size.width < 600 ? 28 : 36,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          FadeInDown(
            delay: const Duration(milliseconds: 200),
            child: Container(
              height: 4,
              width: 60,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary,
                    Theme.of(context).colorScheme.secondary,
                  ],
                ),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInUp(
            delay: const Duration(milliseconds: 400),
            child: Text(
              'I\'m always open to discussing new opportunities and interesting projects.',
              style: GoogleFonts.poppins(
                fontSize: isSmallScreen ? 14 : 16,
                color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 40),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isSmallScreen ? 1 : 3,
              crossAxisSpacing: isSmallScreen ? 12 : 20,
              mainAxisSpacing: isSmallScreen ? 12 : 20,
              childAspectRatio: isSmallScreen ? 2.0 : 1.2,
            ),
            itemCount: contactItems.length,
            itemBuilder: (context, index) {
              return SlideInUp(
                delay: Duration(milliseconds: 600 + (index * 200)),
                child: _buildContactCard(
                  context,
                  contactItems[index],
                  isSmallScreen,
                ),
              );
            },
          ),
          const SizedBox(height: 40),
          FadeInUp(
            delay: const Duration(milliseconds: 1200),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primary.withOpacity(0.1),
                    Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'Thank you for visiting my portfolio! 🚀',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _buildContactCard(
    BuildContext context,
    ContactItem item,
    bool isSmallScreen,
  ) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => _launchUrl(item.url),
        child: Container(
          width: double.infinity,
          height: isSmallScreen ? 120 : 140,
          child: GlassmorphicContainer(
            width: double.infinity,
            height: isSmallScreen ? 120 : 140,
            borderRadius: isSmallScreen ? 16 : 20,
            blur: 20,
            alignment: Alignment.center,
            border: 2,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.05),
              ],
            ),
            borderGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                item.color.withOpacity(0.3),
                item.color.withOpacity(0.1),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(isSmallScreen ? 12 : 15),
                    decoration: BoxDecoration(
                      color: item.color.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: FaIcon(
                      item.icon,
                      color: item.color,
                      size: isSmallScreen ? 20 : 24,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 8 : 12),
                  Text(
                    item.title,
                    style: GoogleFonts.poppins(
                      fontSize: isSmallScreen ? 16 : 18,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: isSmallScreen ? 2 : 4),
                  Text(
                    item.subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: isSmallScreen ? 12 : 14,
                      color: Theme.of(
                        context,
                      ).colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContactItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final String url;
  final Color color;

  ContactItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.url,
    required this.color,
  });
}
