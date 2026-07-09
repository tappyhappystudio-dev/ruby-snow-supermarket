import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'home_screen.dart';

class WellDoneScreen extends StatelessWidget {
  final AudioPlayer audioPlayer;
  const WellDoneScreen({super.key, required this.audioPlayer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Main Celebration Banner Graphic Node
              Center(
                child: BounceInRaster(
                  duration: const Duration(milliseconds: 1500),
                  child: Image.asset('assets/points/well_done.png', height: 220),
                ),
              ),

              // Restart game action button panel context 
              Positioned(
                bottom: 40,
                child: FadeInUp(
                  delay: const Duration(milliseconds: 1000),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
                    ),
                    onPressed: () {
                      audioPlayer.stop();
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                        (route) => false,
                      );
                    },
                    child: const Text(
                      'PLAY AGAIN ↻',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
