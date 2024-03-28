import 'package:get/get.dart';

class ManageState extends GetxController {
  bool registered = false;

  String username = "";
  String role = "";


  List foods = [
    {'name': 'Cabbage','donor': 'donor1','quantity': 3,'lon': 36.080026, 'lat': -0.303099, 'loc': 'Nakuru','expiry': '10.03.2024'},
    {'name': 'Oranges', 'donor':'donor1','quantity': 7,'lon': 36.080026, 'lat': -0.303099,  'loc': 'Nakuru', 'expiry': '12.03.2024'},
    {'name': 'Carrots','donor': 'donor1','quantity': 9,'lon': 36.080026, 'lat': -0.303099,  'loc': 'Nakuru', 'expiry': '16.03.2024'},
    {'name': 'coke(Soda)','donor': 'donor1','quantity': 1,'lon': 36.080026, 'lat': -0.303099, 'loc': 'Nakuru', 'expiry': '26.03.2024'},
    {'name': 'Tomatoes','donor': 'donor1','quantity': 7,'lon': 36.080026, 'lat': -0.303099, 'loc': 'Nakuru', 'expiry': '26.03.2024'},
    {'name': 'Yoghurt','donor': 'donor1','quantity': 3,'lon': 36.080026, 'lat': -0.303099, 'loc': 'Nakuru', 'expiry': '26.03.2024'},
    {'name': 'Onions','donor': 'donor1','quantity': 9,'lon': 36.080026, 'lat': -0.303099, 'loc': 'Nakuru', 'expiry': '26.03.2024'},
    
    
  ];

  List shareFood = [
   
    {'name': 'pizza', },
    {'name': 'yoghurt',},
    {'name': 'mandazi', },
    {'name': 'fresha', },
  ];



  // Shopping list to be populated
  var shoppingList = [].obs;

  // Checked out items list
  var checkedOutList = [].obs;

  // Function to handle item selection
  void onItemSelected(int index) {
    if (index >= 0 && index < foods.length) {
      // Reduce quantity
      if (foods[index]['quantity'] > 0) {
        foods[index]['quantity']--;

        // Check if the item is already in the shopping list
        var itemInShoppingList = shoppingList.indexWhere((item) =>
            item['name'] == foods[index]['name'] &&
            item['donor'] == foods[index]['donor']);

        // If not in the shopping list, add it
        if (itemInShoppingList == -1) {
          shoppingList.add({
            'name': foods[index]['name'],
            'donor': foods[index]['donor'],
            'quantity': 1,
            'lat': foods[index]['lat'],
            'lon': foods[index]['lon'],
          });
        } else {
          // If already in the shopping list, increment the quantity
          shoppingList[itemInShoppingList]['quantity']++;
        }

        // Update the state
        update();
      }
    }
  }

   // Function to handle checkout
  void onCheckout() {
    // Add checked-out items to the checkedOutList
    checkedOutList.addAll(shoppingList);

    // Clear the shoppingList
    shoppingList.clear();

    // You can perform additional actions here if needed

    // Update the state
    update();
  }

  setRegistered(bool registered) {
    registered = registered;
    update();
  }

  setBasic(String username, String role) {
    username = username;
    role = role;
    update();
  }
}
