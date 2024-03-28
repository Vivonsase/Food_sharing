import 'package:flutter/material.dart';
import 'package:food/statemanagement.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class RecordsPage extends StatefulWidget {

  const RecordsPage({super.key});

  @override
  State<RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
   final ManageState _controller = Get.put(ManageState());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Taken Food'),
      ),
      body: Obx(
        () => _controller.checkedOutList.isEmpty
            ?const Center(
                child: Text('No items has been taken.'),
              )
            : ListView.builder(
                itemCount: _controller.checkedOutList.length,
                itemBuilder: (context, index) {
                  var item = _controller.checkedOutList[index];
                   return Container(
                 
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Product Name: ${item['name']}',
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          Text(
            'Quantity: ${item['quantity']}',
            style:const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          const SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: (){
              openGoogleMaps(item['lat'],item['lon']);
            },
            child: const Text('Map guide'),
          ),
        ],
      ),
    );
                  // GestureDetector(
                  //   onTap: (){
                  //     openGoogleMaps(item['lat'],
                  //                              item['lon']);
                  //   },
                  //   child: ListTile(
                  //     title: Text(item['name']),
                  //     subtitle: Text('Quantity: ${item['quantity']}'),
                      
                  //     trailing: GestureDetector(
                  //             onTap: () {
                  //                          openGoogleMaps(item['lat'],
                  //                              item['lon']);
                  //             },
                  //             child: const Text('Map Guide'),
                  //           ),
                    
                  //   ),
                  // );
                },
              ),
      ),
      
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _controller.onCheckout();
      //     print(_controller.checkedOutList);
      //     Get.offAll(const HomePage());
      //     Get.snackbar('checkout', "checked out successfully!",snackPosition: SnackPosition.BOTTOM);
      //     // You can add any additional logic or navigate to another page after checkout
      //   },
      //   child: const Icon(Icons.check),
      // ),
    );
  }
  openGoogleMaps(double latitude, double longitude) async {
    String destinationCoordinates = '$latitude,$longitude';

    String googleMapsUrl =
        'https://www.google.com/maps/dir/?api=1&destination=$destinationCoordinates';

    if (await canLaunchUrl(Uri.parse(googleMapsUrl))) {
      await launchUrl(Uri.parse(googleMapsUrl));
    } else {
      throw 'Could not launch Google Maps';
    }
  }
}

