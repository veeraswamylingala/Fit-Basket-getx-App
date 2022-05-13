import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learn_getx/model/category.model.dart';
import 'package:learn_getx/model/product.model.dart';
import 'package:learn_getx/utils/json.dart';

class HomeController extends GetxController {
  List<CategoryModel> categories = [];
  List<ProductModel> products = [];

  HomeController() {
    //loadCategories();
    loadProducts();
  }
// //Loading Catergories -----
//   loadCategories() async {
//     //Load categories
//     List<dynamic> dataCategories = await loadJson(
//       "assets/data/categories.json",
//     );
//     categories.addAll(dataCategories
//         .map<CategoryModel>((category) => CategoryModel(
//               key: category["key"],
//               name: category["name"],
//               color: category["color"],
//             ))
//         .toList());
//     print(categories.length);
//     update();
//     // selectCategory(categories.first);
//   }
  ///load Products
  loadProducts() async {
    List<dynamic> dataProducts = await loadJson(
      "assets/data/products.json",
    );
    dataProducts.forEach((element) {
      ProductModel.fromJson(element);
    });
    products = dataProducts.map((e) => ProductModel.fromJson(e)).toList();
    update();
  }
}
