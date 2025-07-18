import 'package:designsmith/about.dart';
import 'package:designsmith/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
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

    Future.delayed(Duration.zero, () {
      preloadImages(context);
    });
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/welcome.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 90),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _linkedinUrl,
                            child: Container(
                              width: 50,
                              height: 50,
                              child: SvgPicture.asset(
                                'assets/images/insta.svg',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 80),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _instaUrl,
                            child: Container(
                              width: 50,
                              height: 50,
                              child: SvgPicture.asset(
                                'assets/images/linkedin.svg',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 80),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _launchCall,
                            child: Container(
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 80),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _launchEmail,
                            child: Container(
                              child: Icon(
                                Icons.mail,
                                color: Colors.white,
                                size: 50,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 40, top: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          HomePage(),
                                ),
                              );
                            },
                            child: Text(
                              'MY DESIGNS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 40),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          About(),
                                ),
                              );
                            },
                            child: Text(
                              'ABOUT',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/mobile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 37, bottom: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _linkedinUrl,
                            child: Container(
                              width: 25,
                              height: 25,
                              child: SvgPicture.asset(
                                'assets/images/insta.svg',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 25),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _instaUrl,
                            child: Container(
                              width: 25,
                              height: 25,
                              child: SvgPicture.asset(
                                'assets/images/linkedin.svg',
                                fit: BoxFit.contain,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 25),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _launchCall,
                            child: Container(
                              child: Icon(
                                Icons.call,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 25),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: _launchEmail,
                            child: Container(
                              child: Icon(
                                Icons.mail,
                                color: Colors.white,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40, bottom: 120),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          HomePage(),
                                ),
                              );
                            },
                            child: Text(
                              'MY DESIGNS',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          About(),
                                ),
                              );
                            },
                            child: Text(
                              'ABOUT',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
