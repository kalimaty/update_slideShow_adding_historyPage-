import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:slide_show/screens/endScreen.dart';

import '../providers/slide_provider.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final wordsSlidProvider = Provider.of<SlideProvider>(context);
    return Scaffold(
      appBar: AppBar(
           leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => EndScreen()),
                  ModalRoute.withName('/'));
            },
            icon: Icon(Icons.arrow_back_rounded)),
        backgroundColor: Colors.amber.shade300,
        elevation: 4,
        centerTitle: true,
        title: Text(
          'History',
          style: TextStyle(
              color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Center(
                child: Consumer<SlideProvider>(
                  builder: (context, slideProvider, child) {
                    return DataTable(
                      decoration: BoxDecoration(color: Colors.blue.shade400),
                      sortAscending: true,
                      columnSpacing: 1.0,
                      dataRowMaxHeight: double.infinity,
                      dataRowMinHeight: 50.0,
                      dividerThickness: 1,
                      border: TableBorder.all(
                          color: Colors.grey.shade100, width: 2),
                      columns: const [
                        DataColumn(
                          label: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Word',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Align(
                            child: Text(
                              'Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Audio',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                      rows: slideProvider.database.map(
                        (e) {
                          String imageName = e
                              .substring(
                                  e.lastIndexOf('/') + 1, e.lastIndexOf('.'))
                              .toUpperCase();
                          return DataRow(
                            color: MaterialStateProperty.resolveWith(
                                _getDataRowColor),
                            cells: [
                              DataCell(Text(
                                imageName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                              DataCell(Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  e,
                                ),
                              )),
                              DataCell(
                                // IconButton(
                                //   onPressed: () {
                                //     quizProvider.speak(imageName);
                                //   },
                                //   icon: Icon(
                                //     size: 50,
                                //     color: Colors.white,
                                //     quizProvider.isPlaying(imageName)
                                //         ? Icons.pause
                                //         : IconlyLight.play,
                                //   ),
                                // ),
                                Consumer<SlideProvider>(
                                  builder: (context, ttsProvider, _) {
                                    return IconButton(
                                      onPressed: () async {
                                        await ttsProvider.speak(imageName);
                                      },
                                      icon: Icon(
                                        size: 50,
                                        color: Colors.white,
                                        ttsProvider.isPlaying(imageName)
                                            ? Icons.pause
                                            : IconlyLight.play,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ),
              ElevatedButton(
                // onPressed: () {

                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(builder: (context) => SplashScreen()),

                //   );
                //   wordsSlidProvider.stopCurrentPlaying();

                // },
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EndScreen()),
                      ModalRoute.withName('/'));
                },
                child: Text(
                  'Go To Slide',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _getDataRowColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.indigo.shade600;
}



/**
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:slide_show/screens/endScreen.dart';

import '../providers/slide_provider.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // final wordsSlidProvider = Provider.of<SlideProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => EndScreen()),
                  ModalRoute.withName('/'));
            },
            icon: Icon(Icons.arrow_back_rounded)),
        backgroundColor: Colors.amber.shade300,
        elevation: 4,
        centerTitle: true,
        title: Text(
          'History',
          style: TextStyle(
              color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Center(
                child: Consumer<SlideProvider>(
                  builder: (context, slideProvider, child) {
                    return DataTable(
                      decoration: BoxDecoration(color: Colors.blue.shade400),
                      sortAscending: true,
                      columnSpacing: 1.0,
                      dataRowMaxHeight: double.infinity,
                      dataRowMinHeight: 50.0,
                      dividerThickness: 1,
                      border: TableBorder.all(
                          color: Colors.grey.shade100, width: 2),
                      columns: const [
                        DataColumn(
                          label: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Word',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Align(
                            child: Text(
                              'Image',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Audio',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ],
                      rows: slideProvider.database.map(
                        (e) {
                          String imageName = e
                              .substring(
                                  e.lastIndexOf('/') + 1, e.lastIndexOf('.'))
                              .toUpperCase();
                          return DataRow(
                            color: MaterialStateProperty.resolveWith(
                                _getDataRowColor),
                            cells: [
                              DataCell(Text(
                                imageName,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              )),
                              DataCell(Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset(
                                  e,
                                ),
                              )),
                              DataCell(
                                // IconButton(
                                //   onPressed: () {
                                //     quizProvider.speak(imageName);
                                //   },
                                //   icon: Icon(
                                //     size: 50,
                                //     color: Colors.white,
                                //     quizProvider.isPlaying(imageName)
                                //         ? Icons.pause
                                //         : IconlyLight.play,
                                //   ),
                                // ),
                                Consumer<SlideProvider>(
                                  builder: (context, ttsProvider, _) {
                                    return IconButton(
                                      onPressed: () async {
                                        await ttsProvider.speak(imageName);
                                      },
                                      icon: Icon(
                                        size: 50,
                                        color: Colors.white,
                                        ttsProvider.isPlaying(imageName)
                                            ? Icons.pause
                                            : IconlyLight.play,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                    );
                  },
                ),
              ),
              ElevatedButton(
                // onPressed: () {

                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(builder: (context) => SplashScreen()),

                //   );
                //   wordsSlidProvider.stopCurrentPlaying();

                // },
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => EndScreen()),
                      ModalRoute.withName('/'));
                },
                child: Text(
                  'Back',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color _getDataRowColor(Set<MaterialState> states) {
  const Set<MaterialState> interactiveStates = <MaterialState>{
    MaterialState.pressed,
    MaterialState.hovered,
    MaterialState.focused,
  };

  if (states.any(interactiveStates.contains)) {
    return Colors.blue;
  }
  return Colors.indigo.shade600;
}

 */