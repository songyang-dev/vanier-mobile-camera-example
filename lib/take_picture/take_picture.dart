import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({super.key, required this.camera});

  final CameraDescription camera;

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeCameraController;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    _initializeCameraController = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Take a picture"),
      ),
      body: FutureBuilder(
        future: _initializeCameraController,
        builder: (context, snapshot) {
          // because it is void, we need to use a connection state
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeCameraController;
            final image = await _controller.takePicture();
            await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => DisplayImageScreen(image: image),
            ));
          } catch (error) {
            print(error);
          }
        },
        child: const Icon(Icons.camera_alt),
      ),
    );
  }
}

class DisplayImageScreen extends StatelessWidget {
  const DisplayImageScreen({
    super.key,
    required this.image,
  });

  final XFile image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Your picture")),
      body: Center(
        // File is for anything else on the system that is not an asset
        child: Image.file(
          File(image.path),
        ),
      ),
    );
  }
}
