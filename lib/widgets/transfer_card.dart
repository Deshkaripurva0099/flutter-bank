import 'package:flutter/material.dart';

class TransferCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;

  const TransferCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  @override
  State<TransferCard> createState() => _TransferCardState();
}

class _TransferCardState extends State<TransferCard> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cardWidth = size.width * 0.36;
    final cardHeight = size.height * 0.17;

    return SizedBox(
      width: cardWidth,
      height: cardHeight,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(
                widget.icon,
                size: cardHeight * 0.25,
                color: Color(0xFF900603),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: cardHeight * 0.14,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.subtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: cardHeight * 0.09,
                  color: Colors.grey[700],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF900603),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: cardWidth * 0.15,
                    vertical: cardHeight * 0.06,
                  ),
                ),
                onPressed: widget.onPressed,
                child: Text(
                  "Get Started →",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: cardHeight * 0.11,
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
