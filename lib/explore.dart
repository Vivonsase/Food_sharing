import 'package:flutter/material.dart';
import 'package:food/checkout.dart';
import 'package:food/statemanagement.dart';
import 'package:get/get.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  ManageState manageState = Get.put(ManageState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donated Food'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
          crossAxisSpacing: 8.0, // Spacing between columns
          mainAxisSpacing: 4.0, // Spacing between rows
        ),
        itemCount: manageState.foods.length,
        itemBuilder: (context, index) {
          return GetBuilder<ManageState>(
            builder: (context) {
              return Container(
                height: 300,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.blueGrey,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      manageState.foods[index]['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Qty: ${manageState.foods[index]['quantity']}'),
                    Text('Donor: ${manageState.foods[index]['donor']}'),
                    Text(
                      'Location: ${manageState.foods[index]['loc']}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Expiry Date: ${manageState.foods[index]['expiry']}',
                      style: const TextStyle(fontSize: 12),
                    ),
                    Center(
                      child: manageState.foods[index]['quantity'] == 0
                          ? const Text('Not available')
                          : GestureDetector(
                              onTap: () {
                                // Handle button tap here
                                manageState.onItemSelected(index);
                              },
                              child: Container(
                                width: 120.0,
                                height: 20.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  color: Colors.blue,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    'Pick',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: GetBuilder<ManageState>(
        builder: (context) {
          return Stack(
            children: [
              FloatingActionButton(
                onPressed: () {
                  // Handle FAB tap
                  Get.to(const CheckoutPage());
                },
                child: const Icon(Icons.shopping_cart),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  child: Text(
                    manageState.shoppingList.length.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
