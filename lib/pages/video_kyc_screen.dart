import 'dart:async';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'video_kyc_style.dart';

class VideoKYCScreen extends StatefulWidget {
  const VideoKYCScreen({super.key});

  @override
  State<VideoKYCScreen> createState() => _VideoKYCScreenState();
}

class _VideoKYCScreenState extends State<VideoKYCScreen>
    with SingleTickerProviderStateMixin {
  CameraController? _cameraController;
  bool _isRecording = false;
  bool _isBlinking = false;
  XFile? _recordedVideo;
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    _initCamera();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);
    _blinkAnimation = Tween<double>(
      begin: 1.0,
      end: 0.2,
    ).animate(_blinkController);
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
      orElse: () => cameras.first,
    );

    _cameraController = CameraController(frontCamera, ResolutionPreset.medium);
    await _cameraController!.initialize();
    if (mounted) setState(() {});
  }

  Future<void> _startRecording() async {
    if (_cameraController == null || _isRecording) return;

    await _cameraController!.startVideoRecording();
    setState(() {
      _isRecording = true;
      _isBlinking = true;
    });

    // Simulate a 3-second recording like the React example
    Timer(const Duration(seconds: 3), () async {
      if (!_isRecording) return;
      final video = await _cameraController!.stopVideoRecording();
      setState(() {
        _isRecording = false;
        _isBlinking = false;
        _recordedVideo = video;
      });

      // TODO: Handle video upload / save user data here
      // e.g., navigate to next screen or update KYC state
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: VideoKYCStyle.containerGradient,
        ),
        padding: VideoKYCStyle.containerPadding,
        child: SafeArea(
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Back",
                    style: VideoKYCStyle.backButtonText,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Container(
                  decoration: VideoKYCStyle.kycCardDecoration,
                  padding: VideoKYCStyle.kycCardPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Icon(
                          Icons.videocam,
                          size: 70,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "Video KYC",
                          style: VideoKYCStyle.kycTitleText,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          "Complete your verification with a quick video",
                          style: VideoKYCStyle.kycSubtitleText,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),

                        // ============ VIDEO PREVIEW ============
                        Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: _cameraController == null
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : _recordedVideo == null
                              ? CameraPreview(_cameraController!)
                              : const Center(
                                  child: Icon(
                                    Icons.play_circle_fill,
                                    color: Colors.white,
                                    size: 64,
                                  ),
                                ),
                        ),

                        const SizedBox(height: 30),

                        // ============ INSTRUCTIONS ============
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Instructions:",
                                style: VideoKYCStyle.instructionTitle,
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "• Ensure good lighting and clear background",
                                style: VideoKYCStyle.instructionText,
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "• Hold your PAN card next to your face",
                                style: VideoKYCStyle.instructionText,
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                "• Say \"I agree to open an account with NeoBank\"",
                                style: VideoKYCStyle.instructionText,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ============ RECORD BUTTON ============
                        ElevatedButton(
                          onPressed: _isRecording ? null : _startRecording,
                          style: VideoKYCStyle.recordButtonStyle,
                          child: Text(
                            _isRecording ? "Recording..." : "Start Recording",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),

                        // ============ RECORDING INDICATOR ============
                        if (_isBlinking) ...[
                          const SizedBox(height: 16),
                          FadeTransition(
                            opacity: _blinkAnimation,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: VideoKYCStyle.recordingDotDecoration,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            "Recording in progress...",
                            style: VideoKYCStyle.recordingText,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
