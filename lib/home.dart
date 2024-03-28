import 'package:flutter/material.dart';
import 'package:food/about.dart';
import 'package:food/explore.dart';
import 'package:food/pahali/geolocator.dart';
import 'package:food/records.dart';
import 'package:food/share.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Food Sharing'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color:
                    Colors.blue, // Placeholder color, replace with your image
              ),
              // Replace the child with your image widget
              child: const Image(
                  image: AssetImage(
                'assets/logo-food.jpeg',
              )),
            ),

            // Welcome Text
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'COMMUNITY-BASED FOOD SHARING PLATFORM.',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Buttons Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Explore(),
                    ));
                  },
                  child: const Text('Explore Food'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const  FoodUploadForm(),
                    ));
                  },
                  child: const Text('Share Food'),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const  RecordsPage(),
                    ));
                  },
                  child: const Text('Records'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const AboutPage(),
                    ));
                  },
                  child: const Text('About'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
