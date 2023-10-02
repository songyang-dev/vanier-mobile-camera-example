import 'package:flutter/material.dart';

import '../services/camera.dart';
import '../take_picture/take_picture.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Camera description")),
      body: Center(
        child: FutureBuilder(
          future: CameraService().getCamera(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text("Error");
            } else if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${snapshot.data}"),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              TakePictureScreen(camera: snapshot.data!),
                        ));
                      },
                      child: const Text("Take a picture!")),
                ],
              );
            }
            return const Text("Wait");
          },
        ),
      ),
    );
  }
}
