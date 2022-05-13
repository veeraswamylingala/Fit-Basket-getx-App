import 'package:get/get.dart';
import 'package:learn_getx/model/product.model.dart';

class CartController extends GetxController {
  final cartProducts = [].obs;

  CartController();

//ADD ITEMS TO CART--
  addToCart(ProductModel product) {
    cartProducts.add(product);
  }

//REMOVE ITEMS TO CART--
  removeFromCart(ProductModel product) {
    cartProducts.removeWhere(((item) => item.id == product.id));
  }
}
