import 'package:flutter/material.dart';
import 'package:designsmith/poster_details.dart';
import 'package:designsmith/poster.dart';
import 'package:designsmith/product_card.dart';

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
  int currentPage = 0;

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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'My Designs',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 80,
              child: ListView.builder(
                itemCount: categories.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Chip(
                          elevation: 20,
                          side: BorderSide(
                            color: const Color.fromARGB(255, 255, 255, 255),
                          ),
                          backgroundColor:
                              selectedCategory == category
                                  ? Colors.black
                                  : const Color.fromARGB(39, 0, 0, 0),
                          label: Text(category),
                          labelStyle:
                              selectedCategory == category
                                  ? TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(
                                      255,
                                      255,
                                      255,
                                      255,
                                    ),
                                  )
                                  : TextStyle(
                                    fontSize: 16,
                                    color: const Color.fromARGB(255, 0, 0, 0),
                                  ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child:
                    isLoading
                        ? Center(
                          child: CircularProgressIndicator(),
                        ) // Show loading spinner
                        : ListView.builder(
                          itemCount: getFilteredThings().length,
                          itemBuilder: (context, index) {
                            final poster = getFilteredThings()[index];
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return PosterDetails(posters: poster);
                                      },
                                    ),
                                  );
                                },
                                child: productCard(
                                  title: poster['title'] ?? 'No Title',
                                  image: poster['imageurl'] ?? '',
                                  tools: poster['description'] ?? '',
                                  bgColor:
                                      index.isEven
                                          ? Color.fromARGB(105, 109, 129, 130)
                                          : Color.fromARGB(45, 0, 0, 0),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
