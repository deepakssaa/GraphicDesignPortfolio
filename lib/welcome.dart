import 'package:designsmith/about.dart';
import 'package:designsmith/home_page.dart';
import 'package:designsmith/app_theme.dart';
import 'package:designsmith/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;
  late Animation<Offset> _slideAnim;

  void _instaUrl() async {
    final Uri url = Uri.parse(
      'https://www.instagram.com/designsmithh?igsh=MTl1eGdqMXB3a2syZA==',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Instagram!');
    }
  }

  void _linkedinUrl() async {
    final Uri url = Uri.parse(
      'https://www.linkedin.com/in/deepak-a-b41b49280?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=android_app',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch LinkedIn!');
    }
  }

  void _launchEmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: '2301107023@ptuniv.edu.in',
      query: Uri.encodeFull('subject=Hello Designsmith'),
    );

    if (!await launchUrl(
      emailLaunchUri,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch email!');
    }
  }

  void _launchCall() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: '+919790213560');

    if (!await launchUrl(phoneUri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch phone call!');
    }
  }

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _fadeAnim = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animController, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
    );
    _animController.forward();

    Future.delayed(Duration.zero, () {
      preloadImages(context);
    });
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void preloadImages(BuildContext context) async {
    final imagePaths = [
      'assets/images/Vellosa-Bites.png',
      'assets/images/gdr.png',
      'assets/images/welcome.png',
      'assets/images/mobile.png',
      'assets/images/ai.png',
      'assets/images/BANNER.png',
      'assets/images/profile.jpg',
      'assets/images/cgpage1.png',
      'assets/images/designsmithh.png',
      'assets/images/mustang.png',
      'assets/images/firstspider.png',
    ];

    await Future.wait(
      imagePaths.map((path) => precacheImage(AssetImage(path), context)),
    );
  }

  void _navigateTo(Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final bgImage =
        isMobile ? 'assets/images/mobile.png' : 'assets/images/welcome.png';

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(bgImage, fit: BoxFit.cover),

          // Dark overlay for better contrast
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.1),
                  Colors.black.withValues(alpha: 0.5),
                ],
              ),
            ),
          ),

          // Content
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 28 : 80,
                vertical: isMobile ? 24 : 40,
              ),
              child: Column(
                crossAxisAlignment:
                    isMobile
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.start,
                children: isMobile
                    ? [
                        SizedBox(height: MediaQuery.of(context).size.height * 0.42),
                        _buildSocialRow(isMobile),
                        const Spacer(),
                        _buildNavButtons(isMobile),
                        SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                      ]
                    : [
                        const Spacer(),
                        _buildSocialRow(isMobile),
                        const SizedBox(height: 50),
                        _buildNavButtons(isMobile),
                        const SizedBox(height: 260),
                      ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialRow(bool isMobile) {
    final iconSize = isMobile ? 28.0 : 42.0;
    final spacing = isMobile ? 20.0 : 40.0;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _socialIcon(
          onTap: _linkedinUrl,
          child: SvgPicture.asset(
            'assets/images/insta.svg',
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              AppTheme.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: spacing),
        _socialIcon(
          onTap: _instaUrl,
          child: SvgPicture.asset(
            'assets/images/linkedin.svg',
            width: iconSize,
            height: iconSize,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(
              AppTheme.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        SizedBox(width: spacing),
        _socialIcon(
          onTap: _launchCall,
          child: Icon(Icons.call, color: AppTheme.white, size: iconSize),
        ),
        SizedBox(width: spacing),
        _socialIcon(
          onTap: _launchEmail,
          child: Icon(
            Icons.mail_outline,
            color: AppTheme.white,
            size: iconSize,
          ),
        ),
      ],
    );
  }

  Widget _socialIcon({required VoidCallback onTap, required Widget child}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withValues(alpha: 0.1),
          ),
          child: child,
        ),
      ),
    );
  }

  Widget _buildNavButtons(bool isMobile) {
    final fontSize = isMobile ? 16.0 : 22.0;

    return Wrap(
      spacing: isMobile ? 16 : 32,
      runSpacing: 12,
      children: [
        _navButton(
          label: 'MY DESIGNS',
          fontSize: fontSize,
          onTap: () => _navigateTo(const HomePage()),
        ),
        _navButton(
          label: 'ABOUT',
          fontSize: fontSize,
          onTap: () => _navigateTo(const About()),
        ),
      ],
    );
  }

  Widget _navButton({
    required String label,
    required double fontSize,
    required VoidCallback onTap,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: fontSize * 1.2,
            vertical: fontSize * 0.6,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: AppTheme.white.withValues(alpha: 0.6),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusXl),
            color: Colors.white.withValues(alpha: 0.08),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: fontSize,
              color: AppTheme.white,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
