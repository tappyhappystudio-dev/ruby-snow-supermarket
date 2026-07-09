import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'buy_things_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer _audioPlayer;

  @override
  void initState() {
    super.dynamic;
    _audioPlayer = AudioPlayer();
    _playBackgroundMusic();
  }

  void _playBackgroundMusic() async {
    await _audioPlayer.setReleaseMode(ReleaseMode.loop);
    await _audioPlayer.play(AssetSource('audio/this_old_man_the_green_orbs.mp3'));
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              // Background
              Positioned.fill(
                child: Image.asset(
                  'assets/backgrounds/home_screen_background.png',
                  fit: BoxFit.cover,
                ),
              ),
              // Logo
              Align(
                alignment: const Alignment(0, -0.4),
                child: BounceInDown(
                  duration: const Duration(milliseconds: 1200),
                  child: Image.asset('assets/logos_and_buttons/logo.png', height: 180),
                ),
              ),
              // Play Button
              Align(
                alignment: const Alignment(0, 0.5),
                child: Pulse(
                  infinite: true,
                  duration: const Duration(seconds: 2),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BuyThingsScreen(audioPlayer: _audioPlayer)),
                      );
                    },
                    child: Image.asset('assets/logos_and_buttons/play_button.png', height: 90),
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
