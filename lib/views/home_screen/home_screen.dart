import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart/category_screen/item_details.dart';
import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/widgets_common/loading_indicator.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import '../../controllers/product_controller.dart';
import '../../services/firestore_services.dart';
import '../../widgets_common/home_button.dart';
import 'components/featured_button.dart';
import 'components/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController productController = ProductController();
    Get.put(productController);
    var controller = Get.find<HomeController>();
    return Container(
      padding: const EdgeInsets.all(12),
      color: textfieldGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              height: 60,
              alignment: Alignment.center,
              color: lightGrey,
              child: TextFormField(
                controller: controller.searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  suffixIcon: const Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                      controller.searchController.clear();
                    }
                  }),
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnyThing,
                  hintStyle: const TextStyle(
                    color: textfieldGrey,
                  ),
                ),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    //1st swiper Brand
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 130,
                        enlargeCenterPage: true,
                        itemCount: sliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            sliderList[index],
                            fit: BoxFit.cover,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(
                                const EdgeInsets.symmetric(horizontal: 8.0),
                              )
                              .make();
                        }),
                    10.heightBox,
                    //deal Button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 2.5,
                          icon: index == 0 ? icTodaysDeal : icFlashDeal,
                          title: index == 0 ? todayDeal : flashsale,
                          onPress: null,
                        ),
                      ),
                    ),

                    // 2nd Swiper
                    10.heightBox,
                    VxSwiper.builder(
                        aspectRatio: 16 / 9,
                        autoPlay: true,
                        height: 130,
                        enlargeCenterPage: true,
                        itemCount: secondSliderList.length,
                        itemBuilder: (context, index) {
                          return Image.asset(
                            secondSliderList[index],
                            fit: BoxFit.cover,
                          )
                              .box
                              .rounded
                              .clip(Clip.antiAlias)
                              .margin(
                                const EdgeInsets.symmetric(horizontal: 8.0),
                              )
                              .make();
                        }),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        3,
                        (index) => homeButtons(
                          height: context.screenHeight * 0.15,
                          width: context.screenWidth / 3.5,
                          icon: index == 0
                              ? icTopCategories
                              : index == 1
                                  ? icBrands
                                  : icTopSeller,
                          title: index == 0
                              ? topCategory
                              : index == 1
                                  ? brand
                                  : topSellers,
                          onPress: null,
                        ),
                      ),
                    ),

                    // Featured Categories
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredCategories.text
                          .color(darkFontGrey)
                          .size(18)
                          .fontFamily(semibold)
                          .make(),
                    ),
                    20.heightBox,
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          3,
                          (index) => Column(
                            children: [
                              featuredButton(
                                icon: featuredImages1[index],
                                title: featuredTitle1[index],
                              ),
                              10.heightBox,
                              featuredButton(
                                icon: featuredImages2[index],
                                title: featuredTitle2[index],
                              ),
                            ],
                          ),
                        ).toList(),
                      ),
                    ),

                    //featured Products
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text.white
                              .fontFamily(bold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                              future: FirestoreServices.getFeaturedProducts(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else if (snapshot.data!.docs.isEmpty) {
                                  return "No Featured Products"
                                      .text
                                      .fontFamily(bold)
                                      .size(20)
                                      .color(whiteColor)
                                      .makeCentered();
                                } else {
                                  var featuredData = snapshot.data!.docs;
                                  return Row(
                                    children: List.generate(
                                      featuredData.length,
                                      (index) => Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.network(
                                              featuredData[index]['p_imgs'][0],
                                              width: 130,
                                              height: 120,
                                              fit: BoxFit.cover),
                                          10.heightBox,
                                          "${featuredData[index]['p_name']}"
                                              .text
                                              .fontFamily(semibold)
                                              .color(darkFontGrey)
                                              .make(),
                                          10.heightBox,
                                          "${featuredData[index]['p_price']}"
                                              .numCurrency
                                              .text
                                              .color(redColor)
                                              .fontFamily(bold)
                                              .size(16)
                                              .make(),
                                        ],
                                      )
                                          .box
                                          .white
                                          .margin(const EdgeInsets.symmetric(
                                              horizontal: 4))
                                          .roundedSM
                                          .padding(const EdgeInsets.all(8))
                                          .make()
                                          .onTap(
                                        () {
                                          Get.to(
                                            () => ItemDetails(
                                              title:
                                                  "${featuredData[index]['p_name']}",
                                              data: featuredData[index],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    // 3rd Swiper
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 130,
                      enlargeCenterPage: true,
                      itemCount: secondSliderList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSliderList[index],
                          fit: BoxFit.cover,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(
                              const EdgeInsets.symmetric(horizontal: 8.0),
                            )
                            .make();
                      },
                    ),

                    //ALL product Section
                    20.heightBox,
                    StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allproductsdata = snapshot.data!.docs;
                          return GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: allproductsdata.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8,
                              crossAxisSpacing: 8,
                              mainAxisExtent: 300,
                            ),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                      allproductsdata[index]['p_imgs'][0],
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.cover),
                                  const Spacer(),
                                  "${allproductsdata[index]['p_name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  10.heightBox,
                                  "${allproductsdata[index]['p_price']}"
                                      .text
                                      .color(redColor)
                                      .fontFamily(bold)
                                      .size(16)
                                      .make(),
                                ],
                              )
                                  .box
                                  .white
                                  .margin(
                                      const EdgeInsets.symmetric(horizontal: 4))
                                  .roundedSM
                                  .padding(const EdgeInsets.all(12))
                                  .make()
                                  .onTap(
                                () {
                                  Get.to(
                                    () => ItemDetails(
                                      title:
                                          "${allproductsdata[index]['p_name']}",
                                      data: allproductsdata[index],
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
