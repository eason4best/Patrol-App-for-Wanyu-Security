import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:security_wanyu/widget/take_document_image_frame.dart';

class TakeDocumentImageScreen extends StatefulWidget {
  final double documentAspectRatio;
  final Future<void> Function({required CameraController cameraController})
      onShutterPressed;
  const TakeDocumentImageScreen({
    Key? key,
    required this.documentAspectRatio,
    required this.onShutterPressed,
  }) : super(key: key);

  @override
  State<TakeDocumentImageScreen> createState() =>
      _TakeDocumentImageScreenState();
}

class _TakeDocumentImageScreenState extends State<TakeDocumentImageScreen> {
  CameraController? _cameraController;

  @override
  void initState() {
    availableCameras().then(
      (cameras) {
        _cameraController = CameraController(
          cameras[0],
          ResolutionPreset.max,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );
        _cameraController!.initialize().then((_) {
          if (!mounted) return;
          setState(() {});
        });
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    _cameraController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _cameraController != null && _cameraController!.value.isInitialized
          ? Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CameraPreview(_cameraController!),
                    TakeDocumentImageFrame(
                        documentAspectRatio: widget.documentAspectRatio),
                  ],
                ),
                Expanded(
                  child: FloatingActionButton.large(
                    onPressed: () => widget
                        .onShutterPressed(cameraController: _cameraController!)
                        .then(
                          (_) => Navigator.of(context).pop(),
                        ),
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.flashlight_on_outlined,
                      size: 40,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
