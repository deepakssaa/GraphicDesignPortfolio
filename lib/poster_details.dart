import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PosterDetails extends StatefulWidget {
  final Map<String, dynamic> posters;
  const PosterDetails({super.key, required this.posters});

  @override
  State<PosterDetails> createState() => _PosterDetailsState();
}

class _PosterDetailsState extends State<PosterDetails> {
  late String link;

  void _instaUrl(String link) async {
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch Instagram!');
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isNetworkImage =
        widget.posters['imageurl']?.startsWith('http') == true ||
        widget.posters['imageurl']?.startsWith('https') == true;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 40,
            centerTitle: true,
            title: const Text(
              'Details',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          body: Column(
            children: [
              Center(
                child: Text(
                  widget.posters['title'] ?? 'No Title',
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child:
                    isNetworkImage
                        ? Image.network(
                          widget.posters['imageurl'] ?? '',
                          height: 400,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.error,
                              size: 100,
                              color: Colors.red,
                            );
                          },
                        )
                        : widget.posters['imageurl'] != null
                        ? Image.asset(
                          widget.posters['imageurl']!,
                          height: 400,
                          fit: BoxFit.cover,
                        )
                        : Container(
                          height: 400,
                          color: Colors.grey,
                          child: const Icon(Icons.image_not_supported),
                        ),
              ),
              Expanded(
                child: Container(
                  height: 300,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(105, 109, 129, 130),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            left: 8,
                            right: 8,
                          ),
                          child: Text(
                            widget.posters['title'] ?? '',
                            style: const TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 23,
                            ),
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              widget.posters['details'] ??
                                  widget.posters['description'] ??
                                  '',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        if ((widget.posters['link'] ?? '').isNotEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                    Colors.black,
                                  ),
                                  fixedSize: MaterialStatePropertyAll(
                                    Size(205, 50),
                                  ),
                                ),
                                onPressed: () {
                                  _instaUrl(widget.posters['link']);
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.ondemand_video,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Watch the Making',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
