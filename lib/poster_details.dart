import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:designsmith/app_theme.dart';
import 'package:designsmith/responsive.dart';

class PosterDetails extends StatefulWidget {
  final Map<String, dynamic> posters;
  const PosterDetails({super.key, required this.posters});

  @override
  State<PosterDetails> createState() => _PosterDetailsState();
}

class _PosterDetailsState extends State<PosterDetails> with SingleTickerProviderStateMixin {
  int _currentImageIndex = 0;
  late PageController _pageController;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutCubic),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _instaUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Instagram!');
    }
  }

  Widget _buildImage(String src, {double? height, BoxFit fit = BoxFit.contain}) {
    final isNetwork = src.startsWith('http://') || src.startsWith('https://');
    if (isNetwork) {
      return Image.network(
        src,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: height,
            child: const Center(
              child: Icon(Icons.broken_image, size: 80, color: Colors.grey),
            ),
          );
        },
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            height: height,
            child: Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
                strokeWidth: 2,
                color: AppTheme.accent,
              ),
            ),
          );
        },
      );
    }
    return Image.asset(src, height: height, fit: fit);
  }

  Widget _buildAmbientBackground(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) return const SizedBox.shrink();
    return Positioned.fill(
      child: Stack(
        fit: StackFit.expand,
        children: [
          _buildImage(imageUrl, fit: BoxFit.cover),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                color: AppTheme.surface.withValues(alpha: 0.75),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.surface.withValues(alpha: 0.3),
                    AppTheme.surface.withValues(alpha: 0.95),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCarousel(List<String> images, {required double height}) {
    if (images.isEmpty) {
      return Container(
        height: height,
        color: AppTheme.cardLight,
        child: const Icon(Icons.image_not_supported, size: 80),
      );
    }

    if (images.length == 1) {
      return _buildImage(images[0], height: height);
    }

    return SizedBox(
      height: height,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (index) {
              setState(() {
                _currentImageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildImage(images[index], height: height);
            },
          ),
          
          // Dark gradient at the bottom for indicator visibility
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.6),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Bottom dot indicators
          Positioned(
            bottom: 24,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                final isSelected = _currentImageIndex == index;
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  height: 8,
                  width: isSelected ? 28 : 8,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppTheme.white
                        : Colors.white.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.5),
                              blurRadius: 8,
                              spreadRadius: 1,
                            )
                          ]
                        : null,
                  ),
                );
              }),
            ),
          ),

          // Left Arrow
          if (_currentImageIndex > 0)
            Positioned(
              left: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildNavArrow(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                    );
                  },
                ),
              ),
            ),

          // Right Arrow
          if (_currentImageIndex < images.length - 1)
            Positioned(
              right: 12,
              top: 0,
              bottom: 0,
              child: Center(
                child: _buildNavArrow(
                  icon: Icons.arrow_forward_ios_rounded,
                  onTap: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOutCubic,
                    );
                  },
                ),
              ),
            ),

          // Counter Badge
          Positioned(
            top: 20,
            right: 20,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                  ),
                  child: Text(
                    '${_currentImageIndex + 1} / ${images.length}',
                    style: const TextStyle(
                      color: AppTheme.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavArrow({required IconData icon, required VoidCallback onTap}) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.3),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withValues(alpha: 0.3), width: 1.5),
              ),
              child: Icon(
                icon,
                color: AppTheme.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final isDesktop = Responsive.isDesktop(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final imageHeight = isMobile
        ? screenHeight * 0.45
        : isDesktop
            ? screenHeight * 0.65
            : screenHeight * 0.50;

    final title = widget.posters['title']?.toString() ?? 'No Title';
    final imagesList = widget.posters['images'] as List<dynamic>?;
    final List<String> images = imagesList != null
        ? imagesList.map((e) => e.toString()).toList()
        : (widget.posters['imageurl'] != null && widget.posters['imageurl'].toString().isNotEmpty)
            ? [widget.posters['imageurl'].toString()]
            : [];
    final details = widget.posters['details']?.toString() ?? widget.posters['description']?.toString() ?? '';
    final link = widget.posters['link']?.toString() ?? '';

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppTheme.surface.withValues(alpha: 0.8),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded, color: AppTheme.textPrimary),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          _buildAmbientBackground(images.isNotEmpty ? images.first : null),
          SafeArea(
            bottom: false,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: isDesktop 
                    ? _buildDesktopLayout(
                        title: title,
                        images: images,
                        details: details,
                        link: link,
                        imageHeight: imageHeight,
                        screenWidth: screenWidth,
                      ) 
                    : _buildMobileLayout(
                        title: title,
                        images: images,
                        details: details,
                        link: link,
                        imageHeight: imageHeight,
                        isMobile: isMobile,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Side-by-side layout for desktop
  Widget _buildDesktopLayout({
    required String title,
    required List<String> images,
    required String details,
    required String link,
    required double imageHeight,
    required double screenWidth,
  }) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingXxl, vertical: AppTheme.spacingLg),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Image
              Expanded(
                flex: 5,
                child: Container(
                  height: imageHeight,
                  decoration: BoxDecoration(
                    color: AppTheme.white.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 40,
                        offset: const Offset(0, 20),
                      )
                    ],
                    border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 2),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: _buildCarousel(images, height: imageHeight),
                ),
              ),

              const SizedBox(width: AppTheme.spacingXxl),

              // Right: Details
              Expanded(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                    child: Container(
                      padding: const EdgeInsets.all(AppTheme.spacingXxl),
                      decoration: BoxDecoration(
                        color: AppTheme.white.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(AppTheme.radiusXl),
                        border: Border.all(color: Colors.white.withValues(alpha: 0.8), width: 1.5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ShaderMask(
                            shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                            child: Text(
                              title, 
                              style: AppTheme.headingLarge.copyWith(
                                color: Colors.white, 
                                fontSize: 48,
                                fontWeight: FontWeight.w900,
                              )
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingMd),
                          Container(
                            width: 80,
                            height: 6,
                            decoration: BoxDecoration(
                              gradient: AppTheme.accentGradient,
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          const SizedBox(height: AppTheme.spacingXl),
                          Flexible(
                            child: SingleChildScrollView(
                              child: Text(
                                details, 
                                style: AppTheme.bodyLarge.copyWith(
                                  height: 1.8,
                                  color: AppTheme.textPrimary.withValues(alpha: 0.85),
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          if (link.isNotEmpty) ...[
                            const SizedBox(height: AppTheme.spacingXxl),
                            _buildWatchButton(),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Stacked layout for mobile & tablet
  Widget _buildMobileLayout({
    required String title,
    required List<String> images,
    required String details,
    required String link,
    required double imageHeight,
    required bool isMobile,
  }) {
    return Column(
      children: [
        // Image
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? AppTheme.spacingMd : AppTheme.spacingXl,
            vertical: AppTheme.spacingSm,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: AppTheme.white.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 30,
                  offset: const Offset(0, 15),
                )
              ],
              border: Border.all(color: Colors.white.withValues(alpha: 0.6), width: 1.5),
            ),
            clipBehavior: Clip.antiAlias,
            child: _buildCarousel(images, height: imageHeight),
          ),
        ),

        const SizedBox(height: AppTheme.spacingMd),

        // Details section
        Expanded(
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppTheme.radiusXl),
              topRight: Radius.circular(AppTheme.radiusXl),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.white.withValues(alpha: 0.75),
                  border: Border(
                    top: BorderSide(color: Colors.white.withValues(alpha: 0.8), width: 1.5),
                  ),
                ),
                child: Column(
                  children: [
                    // Drag handle indicator
                    Container(
                      margin: const EdgeInsets.only(top: 16, bottom: 8),
                      width: 48,
                      height: 5,
                      decoration: BoxDecoration(
                        color: AppTheme.textSecondary.withValues(alpha: 0.4),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),

                    Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            padding: EdgeInsets.fromLTRB(
                              isMobile ? AppTheme.spacingLg : AppTheme.spacingXl,
                              AppTheme.spacingMd,
                              isMobile ? AppTheme.spacingLg : AppTheme.spacingXl,
                              link.isNotEmpty ? 120 : AppTheme.spacingXl,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ShaderMask(
                                  shaderCallback: (bounds) => AppTheme.primaryGradient.createShader(bounds),
                                  child: Text(
                                    title,
                                    style: (isMobile ? AppTheme.headingMedium : AppTheme.headingLarge).copyWith(
                                      color: Colors.white, 
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: AppTheme.spacingMd),
                                Text(
                                  details,
                                  style: (isMobile ? AppTheme.bodyMedium : AppTheme.bodyLarge).copyWith(
                                    height: 1.7,
                                    color: AppTheme.textPrimary.withValues(alpha: 0.85),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (link.isNotEmpty)
                            Positioned(
                              bottom: AppTheme.spacingLg,
                              left: 0,
                              right: 0,
                              child: SafeArea(
                                top: false,
                                child: _buildWatchButton(),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWatchButton() {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _instaUrl(widget.posters['link']),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
              borderRadius: BorderRadius.circular(AppTheme.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primary.withValues(alpha: 0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.play_arrow_rounded, color: AppTheme.white, size: 20),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Watch the Making',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    color: AppTheme.white,
                    fontSize: 16,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
