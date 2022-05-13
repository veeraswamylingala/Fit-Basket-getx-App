import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:learn_getx/model/product.model.dart';
import 'package:learn_getx/view/cart/cart.dart';
import 'package:learn_getx/view/cart/cart_controller.dart';
import 'package:learn_getx/view/home/home_controller.dart';

class ViewProduct extends StatelessWidget {
  final ProductModel product;
  ViewProduct({Key? key, required this.product}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  final CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: Text(""),
      ),
      bottomSheet: Card(
        child: Container(
            width: double.infinity,
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(() => !cartController.cartProducts
                        .indexWhere((element) => element.id == product.id)
                        .isNegative
                    ? Container(
                        color: Colors.green,
                        alignment: Alignment.topLeft,
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Text(
                            "Item added..",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                      )
                    : SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: Text(
                            "\$ " + product.price.toString(),
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 17,
                                letterSpacing: 1,
                                fontWeight: FontWeight.bold),
                          )),
                          const Text(
                            "Price per kg",
                            style: TextStyle(
                                //    color: Colors.green,
                                fontSize: 11,
                                // letterSpacing: 1,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                        child: Container(
                            color: Colors.redAccent,
                            child: TextButton(
                                onPressed: () {
                                  var res = cartController.cartProducts
                                      .indexWhere((element) =>
                                          element.id == product.id);
                                  print(res);
                                  if (res.isNegative) {
                                    print("Add to cart Clicked");
                                    print(product.quantity);
                                    cartController.addToCart(product);
                                  } else {
                                    print("Cart Clikced");
                                    Get.to(CartPage(),
                                        transition: Transition.downToUp);
                                  }

                                  // cartController.cartProducts.add(product);
                                },
                                child: Obx(
                                  () => Text(
                                    cartController.cartProducts
                                            .indexWhere((element) =>
                                                element.id == product.id)
                                            .isNegative
                                        ? "ADD"
                                        : "VIEW CART",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ))))
                  ],
                )
              ],
            )),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                //IMage
                Container(
                    height: MediaQuery.of(context).size.height / 3,
                    child: Center(child: Image.asset(product.image))),
                SizedBox(
                  height: 10,
                ),
                //Name
                Text(product.name,
                    style: const TextStyle(
                        fontSize: 22,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600)),
                //Category
                Text(
                  product.category,
                  style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 10,
                ),
                //Description
                Text(
                  product.description,
                  style: const TextStyle(
                      fontSize: 14,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w300),
                ),
              ]),
        ),
      ),
    );
  }
}
