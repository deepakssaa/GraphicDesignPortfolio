import 'package:flutter/material.dart';
import 'package:designsmith/app_theme.dart';

class ProductCard extends StatefulWidget {
  final String title;
  final String image;
  final String tools;
  final Color bgColor;

  const ProductCard({
    super.key,
    required this.title,
    required this.image,
    required this.tools,
    required this.bgColor,
  });

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  bool _isHovered = false;

  Widget _buildImage(String src, {double? height}) {
    final isNetwork = src.startsWith('http://') || src.startsWith('https://');
    if (isNetwork) {
      return Image.network(
        src,
        height: height,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: height,
            child: const Center(
              child: Icon(Icons.broken_image, size: 60, color: Colors.grey),
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
    return Image.asset(
      src,
      height: height,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final imageHeight = screenWidth < 600
        ? 220.0
        : screenWidth < 1100
            ? 280.0
            : 320.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: Matrix4.identity()
          ..scale(_isHovered ? 1.02 : 1.0),
        transformAlignment: Alignment.center,
        margin: EdgeInsets.symmetric(
          horizontal: screenWidth < 600 ? 4 : 8,
          vertical: screenWidth < 600 ? 4 : 6,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          color: widget.bgColor,
          boxShadow: _isHovered ? AppTheme.elevatedShadow : AppTheme.cardShadow,
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Image section
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLg),
                topRight: Radius.circular(AppTheme.radiusLg),
              ),
              child: _buildImage(widget.image, height: imageHeight),
            ),

            // Text section
            Padding(
              padding: EdgeInsets.all(screenWidth < 600 ? 12 : 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth < 600 ? 18 : 20,
                      color: AppTheme.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        Icons.brush_outlined,
                        size: 14,
                        color: AppTheme.textSecondary,
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          widget.tools,
                          style: AppTheme.caption,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
