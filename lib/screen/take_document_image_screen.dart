import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:security_wanyu/widget/take_document_image_frame.dart';

class TakeDocumentImageScreen extends StatefulWidget {
  final CameraLensDirection cameraLensDirection;
  final Future<void> Function({required CameraController cameraController})
      onShutterPressed;
  final double? documentAspectRatio;
  const TakeDocumentImageScreen({
    Key? key,
    required this.cameraLensDirection,
    required this.onShutterPressed,
    this.documentAspectRatio,
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
          cameras
              .firstWhere((c) => c.lensDirection == widget.cameraLensDirection),
          ResolutionPreset.max,
          enableAudio: false,
          imageFormatGroup: ImageFormatGroup.jpeg,
        );
        _cameraController!.initialize().then((_) {
          if (!mounted) return;
          _cameraController!.addListener(
            () => setState(() {}),
          );
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
                    widget.documentAspectRatio != null
                        ? TakeDocumentImageFrame(
                            documentAspectRatio: widget.documentAspectRatio!)
                        : Container(),
                  ],
                ),
                Expanded(
                  child: FloatingActionButton.large(
                    onPressed: !_cameraController!.value.isTakingPicture
                        ? () => widget
                            .onShutterPressed(
                                cameraController: _cameraController!)
                            .then(
                              (_) => Navigator.of(context).pop(),
                            )
                        : null,
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.camera_alt_outlined,
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
