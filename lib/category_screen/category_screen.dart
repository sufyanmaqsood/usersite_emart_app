import 'package:emart/consts/consts.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/controllers/product_controller.dart';
import 'package:emart/widgets_common/bg_widget.dart';
import 'package:get/get.dart';
import 'category_details.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    return bgWidget(
        child: Scaffold(
      appBar: AppBar(
        title: categories.text.fontFamily(bold).white.make(),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
            shrinkWrap: true,
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              mainAxisExtent: 180,
            ),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Image.asset(
                    categoriesImages[index],
                    height: 120,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                  10.heightBox,
                  categoriesList[index]
                      .text
                      .align(TextAlign.center)
                      .color(fontGrey)
                      .make(),
                ],
              )
                  .box
                  .white
                  .rounded
                  .outerShadowSm
                  .clip(Clip.antiAlias)
                  .make()
                  .onTap(() {
                controller.getSubCategories(categoriesList[index]);
                Get.to(() => CategoryDetails(title: categoriesList[index]));
              });
            }),
      ),
    ));
  }
}
