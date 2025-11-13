import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoKYCPage extends StatefulWidget {
  const VideoKYCPage({super.key});

  @override
  State<VideoKYCPage> createState() => _VideoKYCPageState();
}

class _VideoKYCPageState extends State<VideoKYCPage> {
  late VideoPlayerController _controller;
  bool isVerifying = false;
  String kycStatus = "pending";
  String message = "";

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse(
        "https://assets.mixkit.co/videos/preview/mixkit-online-learning-with-laptop-and-coffee-4161-large.mp4",
      ),
    )
      ..initialize().then((_) {
        setState(() {});
        _controller.setLooping(true);
      });
  }

  void startKyc() {
    setState(() {
      isVerifying = true;
      kycStatus = "in_progress";
      message =
          "Connecting with a verification officer... This is a simulated process.";
    });

    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        isVerifying = false;
        kycStatus = "completed";
        message = "🎉 Your Video KYC has been successfully completed!";
      });
    });
  }

  String getButtonText() {
    switch (kycStatus) {
      case "pending":
        return "Start KYC";
      case "in_progress":
        return "Verifying...";
      case "completed":
        return "KYC Completed";
      default:
        return "Start KYC";
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildStep(String label, int step, bool isActive) {
    return Column(
      children: [
        CircleAvatar(
          radius: 16,
          backgroundColor: isActive ? const Color(0xFF900603) : Colors.grey,
          child: Text(
            "$step",
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.black54),
        ),
      ],
    );
  }

  Widget buildProgressBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        buildStep("Personal", 1, true),
        Expanded(
          child: Divider(
            color: Colors.red.shade700,
            thickness: 2,
            indent: 5,
            endIndent: 5,
          ),
        ),
        buildStep("Aadhar", 2, true),
        Expanded(
          child: Divider(
            color: Colors.red.shade700,
            thickness: 2,
            indent: 5,
            endIndent: 5,
          ),
        ),
        buildStep("PAN", 3, true),
        Expanded(
          child: Divider(
            color: Colors.red.shade700,
            thickness: 2,
            indent: 5,
            endIndent: 5,
          ),
        ),
        buildStep("Video KYC", 4, true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      // 🔥 Removed the AppBar completely
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 480, // ✅ Reduced width for perfect balance
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "NeoBank Account Open",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF900603),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  "Complete your account setup in easy steps",
                  style: TextStyle(color: Colors.black54, fontSize: 14),
                ),
                const SizedBox(height: 25),

                // 🧭 Step Progress Bar
                buildProgressBar(),

                const SizedBox(height: 25),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Video KYC',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Complete your video KYC to finish your account setup. This is a crucial step for identity verification.',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 20),

                // 🎥 Video Preview Box
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade700,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (_controller.value.isInitialized)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: AspectRatio(
                            aspectRatio: _controller.value.aspectRatio,
                            child: VideoPlayer(_controller),
                          ),
                        ),
                      if (kycStatus == "pending")
                        const Text(
                          'Click "Start KYC" to begin...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                if (message.isNotEmpty)
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: kycStatus == "completed"
                          ? Colors.green
                          : Colors.blueGrey,
                      fontSize: 14,
                    ),
                  ),

                const SizedBox(height: 25),

                // 🔘 Buttons Row
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey.shade300,
                          foregroundColor: Colors.black,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: (isVerifying || kycStatus == "completed")
                            ? null
                            : startKyc,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF900603),
                          foregroundColor: Colors.white,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: Text(getButtonText()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
