import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:music_application/mainScreen/main_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class ScanMusic extends StatefulWidget {
  const ScanMusic({super.key});

  @override
  State<ScanMusic> createState() => _ScanMusicState();
}

class _ScanMusicState extends State<ScanMusic> {
  bool startscan = false;

  bool changeUi = false;

  final OnAudioQuery audioQuery = OnAudioQuery();

  int allsong = 0;

  @override
  void initState() {
    super.initState();
    fetchSongs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: const Text('Scan music'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: changeUi == false
          ? Column(
              children: [
                startscan
                    ? Center(
                        child: Lottie.asset(
                          'animation/99946-searching.json',
                          height: 250,
                        ),
                      )
                    : const SizedBox(),
                const SizedBox(height: 300),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        startscan = true;
                      });
                      scanSuccess();
                    },
                    child: Container(
                      height: 50,
                      width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange[900],
                      ),
                      child: Center(
                        child: startscan
                            ? const Text(
                                'SCANNING....',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Itim',
                                ),
                              )
                            : const Text(
                                'SCAN',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'Itim',
                                ),
                              ),
                      ),
                    ),
                  ),
                )
              ],
            )
          : Column(
              children: [
                Center(
                  child: Lottie.asset(
                    'animation/1708-success.json',
                    height: 300,
                    repeat: false,
                  ),
                ),
                const SizedBox(height: 40),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$allsong ',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 35, 244, 45),
                            fontSize: 25,
                          ),
                        ),
                        const TextSpan(
                          text: 'Songs added to Music Player',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
    );
  }

  scanSuccess() async {
    await Future.delayed(const Duration(seconds: 4));

    setState(() {
      changeUi = true;
    });
  }

  Future<void> fetchSongs() async {
    final List<SongModel> songs = await audioQuery.querySongs();

    setState(() {
      allsong = songs.length;
    });
  }
}
