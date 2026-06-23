import 'package:flutter/material.dart';
import 'package:designsmith/poster_details.dart';
import 'package:designsmith/poster.dart';
import 'package:designsmith/product_card.dart';
import 'package:designsmith/app_theme.dart';
import 'package:designsmith/responsive.dart';

class ProductLst extends StatefulWidget {
  const ProductLst({super.key});

  @override
  State<ProductLst> createState() => _ProductLstState();
}

class _ProductLstState extends State<ProductLst> {
  void preloadImages(BuildContext context) async {
    final imagePaths = [
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

  final List<String> categories = [
    'All',
    'Posters',
    'Logos',
    'Posts',
    'Others',
  ];
  late String selectedCategory;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      preloadImages(context);
    });
    selectedCategory = categories[0];
  }

  List<Map<String, dynamic>> getFilteredThings() {
    if (selectedCategory == 'All') {
      return posters;
    } else {
      return posters
          .where((poster) => poster['category'] == selectedCategory)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final filteredItems = getFilteredThings();
    final crossAxisCount = Responsive.gridCount(context);
    final horizontalPadding = Responsive.value<double>(
      context,
      mobile: 12,
      tablet: 24,
      desktop: 40,
    );

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Designs',
            style: TextStyle(
              fontSize: isMobile ? 22 : 28,
              fontWeight: FontWeight.w800,
              color: AppTheme.textPrimary,
            ),
          ),
        ),
        body: Column(
          children: [
            // ── Category Filter Chips ───────────────────────
            SizedBox(
              height: isMobile ? 56 : 64,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 8,
                    ),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 16 : 24,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.primary
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusXl),
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.primary
                                  : AppTheme.divider,
                              width: 1.5,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                fontSize: isMobile ? 14 : 16,
                                fontWeight: isSelected
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                                color: isSelected
                                    ? AppTheme.white
                                    : AppTheme.textSecondary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // ── Grid / List of Posters ──────────────────────
            Expanded(
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(color: AppTheme.accent),
                    )
                  : filteredItems.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.palette_outlined,
                                size: 64,
                                color: AppTheme.textSecondary.withValues(alpha: 0.4),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No designs in this category',
                                style: AppTheme.bodyMedium,
                              ),
                            ],
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: horizontalPadding,
                          ),
                          child: crossAxisCount == 1
                              ? _buildListView(filteredItems)
                              : _buildGridView(
                                  filteredItems, crossAxisCount),
                        ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List<Map<String, dynamic>> items) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final poster = items[index];
        final imagesList = poster['images'] as List<dynamic>?;
        final String imageToDisplay = (imagesList != null && imagesList.isNotEmpty)
            ? imagesList[0].toString()
            : (poster['imageurl']?.toString() ?? '');

        return GestureDetector(
          onTap: () => _openDetails(poster),
          child: ProductCard(
            title: poster['title']?.toString() ?? 'No Title',
            image: imageToDisplay,
            tools: poster['description']?.toString() ?? '',
            bgColor: index.isEven ? AppTheme.cardLight : AppTheme.cardAlt,
          ),
        );
      },
    );
  }

  Widget _buildGridView(
      List<Map<String, dynamic>> items, int crossAxisCount) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: 0.75,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final poster = items[index];
        final imagesList = poster['images'] as List<dynamic>?;
        final String imageToDisplay = (imagesList != null && imagesList.isNotEmpty)
            ? imagesList[0].toString()
            : (poster['imageurl']?.toString() ?? '');

        return GestureDetector(
          onTap: () => _openDetails(poster),
          child: ProductCard(
            title: poster['title']?.toString() ?? 'No Title',
            image: imageToDisplay,
            tools: poster['description']?.toString() ?? '',
            bgColor: index.isEven ? AppTheme.cardLight : AppTheme.cardAlt,
          ),
        );
      },
    );
  }

  void _openDetails(Map<String, dynamic> poster) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PosterDetails(posters: poster),
      ),
    );
  }
}
