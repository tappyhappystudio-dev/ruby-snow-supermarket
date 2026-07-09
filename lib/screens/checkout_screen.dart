import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'well_done_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final List<String> cartItems;
  final AudioPlayer audioPlayer;
  const CheckoutScreen({super.key, required this.cartItems, required this.audioPlayer});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _isPaid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              // Checkout Area Background
              Positioned.fill(
                child: Image.asset('assets/backgrounds/checkout_background.png', fit: BoxFit.cover),
              ),

              // Walmart Clerk Cashier representation
              Positioned(
                left: 40,
                bottom: 40,
                child: FadeIn(child: Image.asset('assets/characters/walmart_man.png', height: 180)),
              ),

              // Register system configuration target zone
              Positioned(
                right: 180,
                bottom: 50,
                child: DragTarget<int>(
                  onAcceptWithDetails: (details) {
                    setState(() {
                      _isPaid = true;
                    });
                    Future.delayed(const Duration(milliseconds: 1500), () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => WellDoneScreen(audioPlayer: widget.audioPlayer)),
                        (route) => false,
                      );
                    });
                  },
                  builder: (context, candidateData, rejectedData) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Image.asset('assets/props/checkout_machine.png', height: 150),
                        Image.asset('assets/props/scanner_machine.png', height: 70),
                        if (_isPaid)
                          Positioned(
                            top: -20,
                            child: FadeInUp(child: Image.asset('assets/props/receipt.png', height: 80)),
                          )
                      ],
                    );
                  },
                ),
              ),

              // Interactive Draggable Cash Counter Engine
              if (!_isPaid)
                Positioned(
                  right: 20,
                  bottom: 60,
                  child: Column(
                    children: [
                      const Text("Drag Money to Pay!", style: TextStyle(color: Colors.white, backgroundColor: Colors.black54, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Draggable<int>(
                        data: 10,
                        feedback: Material(color: Colors.transparent, child: Image.asset('assets/money/money_10_dollars.png', height: 60)),
                        childWhenDragging: Opacity(opacity: 0.5, child: Image.asset('assets/money/money_10_dollars.png', height: 50)),
                        child: Image.asset('assets/money/money_10_dollars.png', height: 50),
                      ),
                      const SizedBox(height: 10),
                      Draggable<int>(
                        data: 20,
                        feedback: Material(color: Colors.transparent, child: Image.asset('assets/money/money_20_dollars.png', height: 60)),
                        childWhenDragging: Opacity(opacity: 0.5, child: Image.asset('assets/money/money_20_dollars.png', height: 50)),
                        child: Image.asset('assets/money/money_20_dollars.png', height: 50),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
