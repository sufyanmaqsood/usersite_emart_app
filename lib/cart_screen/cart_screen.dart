import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/cart_screen/shipping_screen.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';
import '../controllers/cart_controller.dart';
import '../widgets_common/our_button.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
      backgroundColor: whiteColor,
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
          color: redColor,
          onPress: () {
            Get.to(() => const ShippingDetails());
          },
          textColor: whiteColor,
          title: "Proceed to Shipping",
        ),
      ),
      appBar: AppBar(
        backgroundColor: darkFontGrey,
        automaticallyImplyLeading: false,
        title: const Text(
          "Shopping Cart",
          style: TextStyle(
            color: whiteColor,
            fontFamily: bold,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirestoreServices.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                "Oops! Cart is Empty.",
                style: TextStyle(
                  color: redColor,
                  fontFamily: bold,
                  fontSize: 20,
                ),
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            controller.calculate(data);
            controller.productSnapshot = data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          elevation: 2,
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: Image.network(
                              data[index]['img'],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            title: Text(
                              "${data[index]['title']}  (${data[index]['qty']}x)",
                              style: const TextStyle(
                                fontFamily: semibold,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "${data[index]['tprice']}".numCurrency,
                              style: const TextStyle(
                                color: redColor,
                                fontFamily: semibold,
                                fontSize: 14,
                              ),
                            ),
                            trailing: GestureDetector(
                              onTap: () {
                                FirestoreServices.deleteDocument(
                                    data[index].id);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: redColor,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Card(
                    elevation: 2,
                    color: lightGolden,
                    margin: const EdgeInsets.all(12),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total Price",
                            style: TextStyle(
                              color: darkFontGrey,
                              fontFamily: semibold,
                            ),
                          ),
                          Obx(
                            () => Text(
                              "${controller.totalP.value}".numCurrency,
                              style: const TextStyle(
                                color: redColor,
                                fontFamily: semibold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
