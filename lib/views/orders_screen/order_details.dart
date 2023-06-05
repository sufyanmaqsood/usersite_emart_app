import 'package:emart/consts/consts.dart';
import 'components/order_place_details.dart';
import 'components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  dynamic data;
  OrdersDetails({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                color: redColor,
                icon: Icons.done,
                title: "Placed",
                showDone: data?['order_placed'] ?? true,
              ),
              orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: "Confirmed",
                showDone: data?['order_confirmed'] ?? false,
              ),
              orderStatus(
                color: Colors.yellow,
                icon: Icons.directions_bus,
                title: "On Delivery",
                showDone: data?['order_on_delivery'] ?? false,
              ),
              orderStatus(
                color: Colors.purple,
                icon: Icons.done_all_rounded,
                title: "Delivered",
                showDone: data?['order_delivered'] ?? false,
              ),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetails(
                    d1: "${data?['order_code']}",
                    d2: "${data?['shipping_method']}",
                    title1: "Order Code",
                    title2: "Shipping Method",
                  ),
                  orderPlaceDetails(
                    d1: data?['order_date'] != null
                        ? intl.DateFormat.yMd()
                            .format(data?['order_date'].toDate())
                        : '',
                    d2: "${data?['payment_method']}",
                    title1: "Order Date",
                    title2: "Payment Method",
                  ),
                  orderPlaceDetails(
                    d1: "Unpaid",
                    d2: "Order Placed",
                    title1: "Payment Status",
                    title2: "Delivery Status",
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Shipping Address".text.fontFamily(semibold).make(),
                            "${data?['order_by_name']}".text.make(),
                            "${data?['order_by_email']}".text.make(),
                            "${data?['order_by_address']}".text.make(),
                            "${data?['order_by_city']}".text.make(),
                            "${data?['order_by_state']}".text.make(),
                            "${data?['order_by_phone']}".text.make(),
                            "${data?['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total price".text.fontFamily(semibold).make(),
                              "${data?['total_amount']}"
                                  .text
                                  .fontFamily(bold)
                                  .color(redColor)
                                  .make()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ).box.outerShadowMd.white.make(),
              const Divider(),
              10.heightBox,
              "Ordered Product"
                  .text
                  .size(16)
                  .color(darkFontGrey)
                  .fontFamily(semibold)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: (data != null &&
                        data.containsKey('orders') &&
                        data['orders'] is List)
                    ? List.generate(
                        data['orders'].length,
                        (index) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              orderPlaceDetails(
                                  title1: data['orders'][index]['title'],
                                  title2: data['orders'][index]['tprice'],
                                  d1: "${data['orders'][index]['qty']}x",
                                  d2: "Refundable"),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Container(
                                  width: 30,
                                  height: 20,
                                  color: Color(data['order'][index]['color']),
                                ),
                              ),
                              const Divider(),
                            ],
                          );
                        },
                      ).toList()
                    : [],
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 4.0))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
