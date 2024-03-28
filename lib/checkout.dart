import 'package:flutter/material.dart';
import 'package:food/home.dart';
import 'package:food/statemanagement.dart';
import 'package:get/get.dart';

class CheckoutPage extends StatefulWidget {

  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
   final ManageState _controller = Get.put(ManageState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout Page'),
      ),
      body: Obx(
        () => _controller.shoppingList.isEmpty
            ?const Center(
                child: Text('No items to check out.'),
              )
            : ListView.builder(
                itemCount: _controller.shoppingList.length,
                itemBuilder: (context, index) {
                  var item = _controller.shoppingList[index];
                  return ListTile(
                    title: Text(item['name']),
                    subtitle: Text('Donor: ${item['donor']}'),
                    trailing: Text('Quantity: ${item['quantity']}'),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.onCheckout();
          Get.offAll(const HomePage());
          Get.snackbar('checkout', "checked out successfully!",snackPosition: SnackPosition.BOTTOM);
          // You can add any additional logic or navigate to another page after checkout
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}

