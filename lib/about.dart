import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/svg.dart';

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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'About me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            SafeArea(
                              child: Image.asset('assets/images/BANNER.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 500),
                              child: Center(
                                child: Stack(
                                  children: [
                                    CircleAvatar(
                                      radius: 150,
                                      backgroundColor: const Color.fromARGB(
                                        255,
                                        0,
                                        0,
                                        0,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: CircleAvatar(
                                        radius: 140,
                                        backgroundImage: AssetImage(
                                          'assets/images/profile.jpg',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 13),
                          child: Text(
                            'Deepak A',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            'Studying B.Tech CSE',
                            style: TextStyle(fontSize: 25, height: 1.2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            'Puducherry Technological University',
                            style: TextStyle(fontSize: 25, height: 1.2),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 13),
                          child: Text(
                            'About',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 13),
                          child: Container(
                            width: 500,
                            child: Text(
                              '🎨 I\'m a passionate designer with a love for creating visually appealing digital products—right from scratch!\n\nWhether it\'s a logo that defines your brand, a poster that communicates your message, a banner that grabs attention, or a seamless UI/UX design for your website or app, I bring ideas to life with creative precision and meaningful color.\n\nI\'m not claiming perfection—but I do bring professionalism, theme consistency, and visually striking aesthetics to every screen I touch.\n\nI\'m continuously learning and evolving, because in design, perfection is a process—and I\'ve set mine to run at 2x speed. 😌\n\nIf it\'s digital and visual—I\'d love to design it. 😉',
                              style: TextStyle(fontSize: 25, height: 1.2),
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Contact',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                              ),
                            ),
                            SizedBox(width: 20),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _launchCall,
                                child: Icon(Icons.call, size: 35),
                              ),
                            ),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _launchEmail,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.mail, size: 35),
                                ),
                              ),
                            ),
                            SizedBox(width: 10),
                            MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: GestureDetector(
                                onTap: _instaUrl,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  child: SvgPicture.asset(
                                    'assets/images/linkedin.svg',
                                    fit: BoxFit.contain,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
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
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                'About me',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.topStart,
                          children: [
                            SafeArea(
                              child: Image.asset('assets/images/BANNER.png'),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 120, left: 8),
                              child: CircleAvatar(
                                radius: 50,
                                backgroundColor: const Color.fromARGB(
                                  255,
                                  0,
                                  0,
                                  0,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 125,
                                left: 13,
                              ),
                              child: CircleAvatar(
                                radius: 45,
                                backgroundImage: AssetImage(
                                  'assets/images/profile.jpg',
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 13),
                          child: Text(
                            'Deepak A',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            'Studying B.Tech CSE\nPuducherry Technological University',
                            style: TextStyle(fontSize: 15, height: 1.2),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 20, left: 13),
                          child: Text(
                            'About',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 13),
                          child: Text(
                            '🎨 I\'m a passionate designer with a love for creating visually appealing digital products—right from scratch!\n\nWhether it\'s a logo that defines your brand, a poster that communicates your message, a banner that grabs attention, or a seamless UI/UX design for your website or app, I bring ideas to life with creative precision and meaningful color.\n\nI\'m not claiming perfection—but I do bring professionalism, theme consistency, and visually striking aesthetics to every screen I touch.\n\nI\'m continuously learning and evolving, because in design, perfection is a process—and I\'ve set mine to run at 2x speed. 😌\n\nIf it\'s digital and visual—I\'d love to design it. 😉',
                            style: TextStyle(fontSize: 15, height: 1.2),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Text(
                            'Contact',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 13),
                          child: Row(
                            children: [
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: _launchCall,
                                  child: Icon(Icons.call, size: 22),
                                ),
                              ),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  onTap: _launchEmail,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Icon(Icons.mail, size: 22),
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: GestureDetector(
                                  onTap: _instaUrl,
                                  child: Container(
                                    width: 17,
                                    height: 17,
                                    child: SvgPicture.asset(
                                      'assets/images/linkedin.svg',
                                      fit: BoxFit.contain,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
