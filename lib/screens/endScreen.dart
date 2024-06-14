import 'package:flutter/material.dart';
import 'package:slide_show/screens/history_widget.dart';
import 'package:slide_show/screens/imageSlideshow%20.dart';
import 'package:slide_show/screens/splash_screen.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ImageSlideshow()),
                  ModalRoute.withName('/'));
            },
            icon: Icon(Icons.arrow_back_rounded)),
        title: Text('End of Slideshow'),
      ),
      //       backgroundColor: Colors.grey[850],
//       appBar: AppBar(
//        backgroundColor: Colors.amber.shade100,
//         elevation: 10,
//         title: Text('End of Slideshow'),
//       ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('End of Slideshow'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => HistoryWidget()),
                    ModalRoute.withName('/'));
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => HistoryWidget(),
                //   ),
                // );
              },
              child: Text('go to histopry'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SplashScreen()),
                    ModalRoute.withName('/'));
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => SplashScreen(),
                //   ),
                // );
              },
              child: Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:slide_show/screens/history_widget.dart';
// import 'package:slide_show/screens/splash_screen.dart';

// class EndScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.grey[850],
//       appBar: AppBar(
//        backgroundColor: Colors.amber.shade100,
//         elevation: 10,
//         title: Text('End of Slideshow'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('End of Slideshow'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => HistoryWidget(),
//                   ),
//                 );
//               },
//               child: Text(
//                 'go to history',
//                 style: TextStyle(fontSize: 25),
//               ),
//             ),
//             SizedBox(
//               height: 50,
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => SplashScreen(),
//                   ),
//                 );
//               },
//               child: Text(
//                 'Restart',
//                 style: TextStyle(fontSize: 25),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
