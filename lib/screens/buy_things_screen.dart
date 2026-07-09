import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:audioplayers/audioplayers.dart';
import 'checkout_screen.dart';

class BuyThingsScreen extends StatefulWidget {
  final AudioPlayer audioPlayer;
  const BuyThingsScreen({super.key, required this.audioPlayer});

  @override
  State<BuyThingsScreen> createState() => _BuyThingsScreenState();
}

class _BuyThingsScreenState extends State<BuyThingsScreen> {
  final List<String> _cart = [];
  
  // Game database linking table layouts to food assets
  final List<Map<String, String>> _items = [
    {'img': 'assets/foods_and_props/ipad.png', 'table': 'assets/walmart_tables_store/devices_ios_table.png', 'name': 'iPad'},
    {'img': 'assets/foods_and_props/chocolate_milka.png', 'table': 'assets/walmart_tables_store/candies_table.png', 'name': 'Milka'},
    {'img': 'assets/foods_and_props/baby_bottle_nuk.png', 'table': 'assets/walmart_tables_store/baby_items_table.png', 'name': 'Nuk Bottle'},
    {'img': 'assets/foods_and_props/kettle.png', 'table': 'assets/walmart_tables_store/kitchen_furnitures_table.png', 'name': 'Kettle'},
    {'img': 'assets/foods_and_props/plastic_bottle_water.png', 'table': 'assets/walmart_tables_store/plastic_bottles_table.png', 'name': 'Water'},
    {'img': 'assets/foods_and_props/pork_ribs.png', 'table': 'assets/walmart_tables_store/raw_foods_table.png', 'name': 'Pork Ribs'},
  ];

  void _addItemToCart(String itemName) {
    if (_cart.length < 3) {
      setState(() {
        _cart.add(itemName);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: Stack(
            children: [
              // Aisles Background
              Positioned.fill(
                child: Image.asset('assets/backgrounds/walmart_background.png', fit: BoxFit.cover),
              ),

              // Mommy Nish Guidance Alert
              Positioned(
                left: 20,
                top: 20,
                child: FadeIn(
                  child: Row(
                    children: [
                      Image.asset('assets/characters_and_props/mommy_nish.png', height: 100),
                      const SizedBox(width: 10),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
                        child: Text(
                          _cart.length < 3 ? "Help Ruby pick 3 things!" : "Great! Tap checkout!",
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // Shopping Grid of Tables and Items
              Positioned(
                top: 130,
                left: 40,
                right: 40,
                bottom: 120,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 30,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1.5
                  ),
                  itemCount: _items.length,
                  itemBuilder: (context, index) {
                    final item = _items[index];
                    bool alreadyPicked = _cart.contains(item['img']);
                    return GestureDetector(
                      onTap: () => _addItemToCart(item['img']!),
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.asset(item['table']!, fit: BoxFit.contain),
                          if (!alreadyPicked)
                            Positioned(
                              top: 0,
                              child: Bounce(child: Image.asset(item['img']!, height: 55)),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // Ruby Snow in Shopping Cart Layout Display
              Positioned(
                left: 30,
                bottom: -10,
                child: SlideInLeft(
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.asset('assets/characters_and_props/ruby_snow_in_shopping_cart.png', height: 140),
                      Positioned(
                        top: 10,
                        child: Row(
                          children: _cart.map((img) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2.0),
                            child: Image.asset(img, height: 30),
                          )).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              // Checkout Navigation Trigger Button
              if (_cart.length >= 3)
                Positioned(
                  right: 30,
                  bottom: 20,
                  child: Pulse(
                    infinite: true,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CheckoutScreen(cartItems: _cart, audioPlayer: widget.audioPlayer)),
                        );
                      },
                      child: const Text('GO TO CHECKOUT ➔', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
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
