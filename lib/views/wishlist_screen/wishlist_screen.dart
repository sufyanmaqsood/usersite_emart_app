import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/services/firestore_services.dart';
import 'package:emart/widgets_common/loading_indicator.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title:
            "My Wishlist".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return "Oops! wishlist is Empty."
                .text
                .color(redColor)
                .size(20)
                .fontFamily(bold)
                .makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: Image.network(
                            data[index]['p_imgs'][0],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                          title: Text(
                            "${data[index]['p_name']}",
                            style: const TextStyle(
                              fontFamily: semibold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text(
                            "${data[index]['p_price']}".numCurrency,
                            style: const TextStyle(
                              color: redColor,
                              fontFamily: semibold,
                              fontSize: 14,
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              FirestoreServices.deleteDocument(data[index].id);
                            },
                            child: const Icon(
                              Icons.favorite,
                              color: redColor,
                            ).onTap(() async {
                              await firestore
                                  .collection(productsCollection)
                                  .doc(data[index].id)
                                  .set({
                                'p_wishlist':
                                    FieldValue.arrayRemove([currentUser!.uid])
                              }, SetOptions(merge: true));
                            }),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
