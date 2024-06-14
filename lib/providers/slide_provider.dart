// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// class SlideProvider with ChangeNotifier {

//   List<String> _database = [
//     "assets/images/apples.png",
//     "assets/images/bear.png",
//     "assets/images/key.png",
//     "assets/images/dog.png",
//     "assets/images/pen.png",
//   ];

//   List<String> get database => _database;

//   bool isPlaying(String text) {
//     // منطق تحديد ما إذا كان الصوت قيد التشغيل
//     return false;
//   }

//   Future<void> speak(String text) async {
//     FlutterTts flutterTts = FlutterTts();
//     await flutterTts.setLanguage("en-US");
//     await flutterTts.setPitch(1);
//     await flutterTts.speak(text);
//   }

// }
//_________________________________________________
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

// import 'package:provider/provider.dart';
// import 'package:iconly/iconly.dart';
enum TtsState { playing, stopped }

class SlideProvider with ChangeNotifier {
  SlideProvider() {
    _initTts();
    _initializeTts();
  }
  String currentWord = '';
  List<dynamic> allSounds = [];
  final FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  Future<void> _initializeTts() async {
    flutterTts.setStartHandler(() {
      ttsState = TtsState.playing;
      notifyListeners();
    });

    flutterTts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
      notifyListeners();
    });

    flutterTts.setErrorHandler((msg) {
      ttsState = TtsState.stopped;
      notifyListeners();
    });

    flutterTts.getVoices.then((voices) {
      allSounds = voices.where((voice) => voice['locale'] == 'en-US').toList();
      notifyListeners();
    });
  }

  void _initTts() async {
    await flutterTts.awaitSpeakCompletion(true);
    notifyListeners();
  }

  // Future<void> speak(String word) async {

  //   if (ttsState == TtsState.stopped) {
  //     // Play new word
  //     currentWord = word;
  //     await flutterTts.speak(word);
  //     ttsState = TtsState.playing;
  //   } else if (ttsState == TtsState.playing && currentWord == word) {
  //     // If playing current word then stop
  //     await flutterTts.stop();
  //     ttsState = TtsState.stopped;
  //   } else if (ttsState == TtsState.playing && currentWord != word) {
  //     // If switching new word stop current word then play new word
  //     await flutterTts.stop();
  //     ttsState = TtsState.stopped;
  //     currentWord = word;
  //     await flutterTts.speak(word);
  //     ttsState = TtsState.playing;
  //   }
  //   notifyListeners();
  // }

  // Future<void> speak(String word) async {
  //   if (ttsState == TtsState.stopped) {
  //     // Play new word
  //     currentWord = word;
  //     await flutterTts.speak(word);
  //     ttsState = TtsState.playing;
  //   } else if (ttsState == TtsState.playing && currentWord == word) {
  //     // If playing current word then stop
  //     await flutterTts.stop();
  //     ttsState = TtsState.stopped;
  //   } else if (ttsState == TtsState.playing && currentWord != word) {
  //     // If switching new word stop current word then play new word
  //     await flutterTts.stop();
  //     ttsState = TtsState.stopped;
  //     currentWord = word;
  //     await flutterTts.speak(word);
  //     ttsState = TtsState.playing;
  //   }
  //   notifyListeners();
  // }

  Future<void> speak(String word) async {
    if (ttsState == TtsState.stopped) {
      currentWord = word;
      await flutterTts.speak(word);
    } else if (ttsState == TtsState.playing && currentWord == word) {
      await flutterTts.stop();
    } else if (ttsState == TtsState.playing && currentWord != word) {
      await flutterTts.stop();
      currentWord = word;
      await flutterTts.speak(word);
    }
    notifyListeners();
  }

  bool isPlaying(String word) {
    // notifyListeners();
    // stopCurrentPlaying();
    return ttsState == TtsState.playing && currentWord == word;
  }

  Future<void> stopCurrentPlaying() async {
    if (ttsState == TtsState.playing) {
      await flutterTts.stop();
      ttsState = TtsState.stopped;
      currentWord = '';
      notifyListeners();
    }
  }

  final List<String> _database = [
    "assets/images/apples.png",
    "assets/images/bear.png",
    "assets/images/key.png",
    "assets/images/dog.png",
    "assets/images/pen.png",
  ];

  List<String> get database => _database;

  // bool isPlaying(String text) {
  //   // منطق تحديد ما إذا كان الصوت قيد التشغيل
  //   return false;
  // }

  // Future<void> speak(String text) async {
  //   // FlutterTts flutterTts = FlutterTts();
  //   await flutterTts.setLanguage("en-US");
  //   await flutterTts.setPitch(1);
  //   await flutterTts.speak(text);
  // }
}
