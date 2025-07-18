import 'package:flutter/material.dart';

class productCard extends StatelessWidget {
  final String title;
  final String image;
  final String tools;
  final Color bgColor;

  const productCard({
    super.key,
    required this.title,
    required this.image,
    required this.tools,
    required this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              width: 400,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: bgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(child: Image.asset(image, height: 250)),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      tools,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: bgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8, left: 19, right: 8),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(child: Image.asset(image, height: 250)),
                  SizedBox(height: 5),
                  Center(
                    child: Text(
                      tools,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
