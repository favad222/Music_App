import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:music_application/allsongs_screen/all_songs.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Mostlycontroller extends ChangeNotifier {
  static ValueNotifier<List<SongModel>> mostPlayedSongsNotifier = ValueNotifier([]);
  static List<dynamic> mostlyPlayed = [];

  static Future<void> addMostlyPlayed(item) async {
    final recentDb = await Hive.openBox('MostSongNotifier');
    await recentDb.add(item);
    getMostlyPlayed();
    mostPlayedSongsNotifier.notifyListeners();
  }

  static Future<void> getMostlyPlayed() async {
    final recentDb = await Hive.openBox('MostSongNotifier');
    mostlyPlayed = recentDb.values.toList();
    displayRecents();
    mostPlayedSongsNotifier.notifyListeners();
  }

  static Future<List> displayRecents() async {
    final recentDb = await Hive.openBox('MostSongNotifier');
    final mostlySongs = recentDb.values.toList();
    mostPlayedSongsNotifier.value.clear();
    mostlyPlayed.clear();
    int counter = 0;

    for (var i = 0; i < mostlySongs.length; i++) {
      for (var k = 0; k < mostlySongs.length; k++) {
        if (mostlySongs[i] == mostlySongs[k]) {
          counter++;
        }
      }
      if (counter > 3) {
        for (var l = 0; l < allsongs.length; l++) {
          if (mostlySongs[i] == allsongs[l].id) {
            mostPlayedSongsNotifier.value.add(allsongs[l]);
            mostlyPlayed.add(allsongs[l]);
          }
        }
        counter = 0;
      }
    }

    return mostlyPlayed;
  }
}
