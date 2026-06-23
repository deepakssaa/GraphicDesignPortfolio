import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/svg.dart';
import 'package:designsmith/app_theme.dart';
import 'package:designsmith/responsive.dart';

class About extends StatelessWidget {
  const About({super.key});

  void _instaUrl() async {
    final Uri url = Uri.parse(
      'https://www.instagram.com/designsmithh?igsh=MTl1eGdqMXB3a2syZA==',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Instagram!');
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

  static const String _aboutText =
      '🎨 I\'m a passionate designer with a love for creating visually appealing digital products—right from scratch!\n\nWhether it\'s a logo that defines your brand, a poster that communicates your message, a banner that grabs attention, or a seamless UI/UX design for your website or app, I bring ideas to life with creative precision and meaningful color.\n\nI\'m not claiming perfection—but I do bring professionalism, theme consistency, and visually striking aesthetics to every screen I touch.\n\nI\'m continuously learning and evolving, because in design, perfection is a process—and I\'ve set mine to run at 2x speed. 😌\n\nIf it\'s digital and visual—I\'d love to design it. 😉';

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final screenWidth = MediaQuery.of(context).size.width;

    final contentMaxWidth = Responsive.contentMaxWidth(context);
    final avatarRadius = isMobile ? 50.0 : isDesktop ? 100.0 : 80.0;
    final bannerOverlap = isMobile ? 25.0 : isDesktop ? 60.0 : 45.0;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'About me',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: isMobile ? 20 : 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: contentMaxWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ── Banner + Avatar ─────────────────────────
                _buildBannerSection(
                  avatarRadius: avatarRadius,
                  bannerOverlap: bannerOverlap,
                  isMobile: isMobile,
                ),

                const SizedBox(height: 12),

                // ── Name & Title ────────────────────────────
                _buildProfileInfo(isMobile: isMobile, isDesktop: isDesktop),

                const SizedBox(height: AppTheme.spacingLg),

                // ── About Section ───────────────────────────
                _buildAboutSection(
                  isMobile: isMobile,
                  isDesktop: isDesktop,
                  screenWidth: screenWidth,
                ),

                const SizedBox(height: AppTheme.spacingLg),

                // ── Contact Section ─────────────────────────
                _buildContactSection(isMobile: isMobile),

                SizedBox(height: isMobile ? 24 : 48),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBannerSection({
    required double avatarRadius,
    required double bannerOverlap,
    required bool isMobile,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Banner
        ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.asset(
            'assets/images/BANNER.png',
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),

        // Avatar overlapping the banner bottom
        Positioned(
          bottom: -(avatarRadius - bannerOverlap),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppTheme.surface, width: 4),
              boxShadow: AppTheme.elevatedShadow,
            ),
            child: CircleAvatar(
              radius: avatarRadius,
              backgroundImage: const AssetImage('assets/images/profile.jpg'),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileInfo({
    required bool isMobile,
    required bool isDesktop,
  }) {
    // Extra top padding to account for avatar overlap
    final topPadding = isMobile ? 30.0 : isDesktop ? 50.0 : 40.0;

    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        children: [
          Text(
            'Deepak A',
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: isMobile ? 24 : isDesktop ? 40 : 32,
              color: AppTheme.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Studying B.Tech CSE',
            style: TextStyle(
              fontSize: isMobile ? 15 : isDesktop ? 22 : 18,
              color: AppTheme.textSecondary,
              height: 1.3,
            ),
          ),
          Text(
            'Puducherry Technological University',
            style: TextStyle(
              fontSize: isMobile ? 14 : isDesktop ? 20 : 16,
              color: AppTheme.textSecondary,
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAboutSection({
    required bool isMobile,
    required bool isDesktop,
    required double screenWidth,
  }) {
    final horizontalPadding = isMobile ? 20.0 : 40.0;
    final maxTextWidth = isDesktop ? 700.0 : screenWidth - (horizontalPadding * 2);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Container(
        width: maxTextWidth,
        padding: EdgeInsets.all(isMobile ? 20 : 32),
        decoration: BoxDecoration(
          color: AppTheme.cardLight,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          boxShadow: AppTheme.cardShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 28,
                  decoration: BoxDecoration(
                    gradient: AppTheme.accentGradient,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'About',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: isMobile ? 20 : isDesktop ? 32 : 26,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _aboutText,
              style: TextStyle(
                fontSize: isMobile ? 15 : isDesktop ? 20 : 17,
                height: 1.6,
                color: AppTheme.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection({required bool isMobile}) {
    final iconSize = isMobile ? 24.0 : 32.0;

    return Column(
      children: [
        Text(
          'Contact',
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: isMobile ? 20 : 28,
            color: AppTheme.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _contactButton(
              onTap: _launchCall,
              icon: Icons.call,
              label: 'Call',
              iconSize: iconSize,
              isMobile: isMobile,
            ),
            SizedBox(width: isMobile ? 12 : 20),
            _contactButton(
              onTap: _launchEmail,
              icon: Icons.mail_outline,
              label: 'Email',
              iconSize: iconSize,
              isMobile: isMobile,
            ),
            SizedBox(width: isMobile ? 12 : 20),
            _contactButtonSvg(
              onTap: _instaUrl,
              assetPath: 'assets/images/linkedin.svg',
              label: 'LinkedIn',
              iconSize: iconSize - 4,
              isMobile: isMobile,
            ),
          ],
        ),
      ],
    );
  }

  Widget _contactButton({
    required VoidCallback onTap,
    required IconData icon,
    required String label,
    required double iconSize,
    required bool isMobile,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 12 : 16,
          ),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            boxShadow: AppTheme.cardShadow,
            border: Border.all(color: AppTheme.divider),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: iconSize, color: AppTheme.primary),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 11 : 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _contactButtonSvg({
    required VoidCallback onTap,
    required String assetPath,
    required String label,
    required double iconSize,
    required bool isMobile,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 16 : 24,
            vertical: isMobile ? 12 : 16,
          ),
          decoration: BoxDecoration(
            color: AppTheme.white,
            borderRadius: BorderRadius.circular(AppTheme.radiusMd),
            boxShadow: AppTheme.cardShadow,
            border: Border.all(color: AppTheme.divider),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                assetPath,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.contain,
                colorFilter: const ColorFilter.mode(
                  AppTheme.primary,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: isMobile ? 11 : 13,
                  fontWeight: FontWeight.w500,
                  color: AppTheme.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
