import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/utils.dart';
import 'package:learn_getx/model/product.model.dart';
import 'package:learn_getx/view/cart/cart_controller.dart';

class CartPage extends StatelessWidget {
  final CartController cartcontroller = Get.put(CartController());

  CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Text(""),
        ),
        body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: Obx(() {
                    if (cartcontroller.cartProducts.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(19)),
                            width: double.infinity,
                            child: const Center(
                              child: Text(
                                "Zero items in cart .",
                                style: TextStyle(color: Colors.black),
                              ),
                            )),
                      );
                    } else {
                      return Container(
                          padding: EdgeInsets.all(10),
                          child: ListView.builder(
                            itemCount: cartcontroller.cartProducts.length,
                            itemBuilder: ((context, index) {
                              return productCartListTile(
                                  product: cartcontroller.cartProducts[index]);
                            }),
                          ));
                    }
                  }),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(20),
                            topLeft: Radius.circular(20))),
                    // height: 200,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30,
                          child: ListTile(
                            title: const Text("-"),
                            leading: const Text("Price"),
                            trailing: Obx(
                              () => Text("\$ " + totalPrice()),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                          child: ListTile(
                            title: Text("-"),
                            leading: Text("Discount"),
                            trailing: Text("\$ " + "-0"),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          child: ListTile(
                            title: Text("-"),
                            leading: Text("Total"),
                            trailing: Obx(() => Text("\$" + totalPrice())),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Card(
                          elevation: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                        child: Obx(() => Text(
                                              "\$ ${totalPrice()}",
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontSize: 17,
                                                  letterSpacing: 1,
                                                  fontWeight: FontWeight.bold),
                                            ))),
                                    const Text(
                                      "Total Amount",
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
                                child: Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Container(
                                    color: Colors.redAccent,
                                    child: TextButton(
                                      onPressed: () {},
                                      child: const Text(
                                        "NEXT",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ))
              ],
            )));
  }

  Widget productCartListTile({required ProductModel product}) {
    return Card(
      child: ListTile(
          leading: SizedBox(
            width: 50,
            child: Image.asset(
              product.image,
              fit: BoxFit.fitWidth,
            ),
          ),
          title: Text(product.name.toString(),
              style: const TextStyle(
                  fontSize: 14,
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w600)),
          subtitle: Text(
            product.quantity.toString() +
                " * " +
                product.price.toString() +
                "=" +
                "\$ " +
                (product.price * product.quantity).toStringAsFixed(1),
            style: const TextStyle(
                color: Colors.green,
                fontSize: 12,
                letterSpacing: 1,
                fontWeight: FontWeight.w600),
          ),
          trailing: FittedBox(
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      var index = cartcontroller.cartProducts
                          .indexWhere((element) => element.id == product.id);
                      if (cartcontroller.cartProducts[index].quantity == 1) {
                        cartcontroller.cartProducts
                            .removeWhere((element) => element.id == product.id);
                      } else {
                        cartcontroller.cartProducts[index].quantity--;
                        cartcontroller.cartProducts.refresh();
                      }
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Colors.black,
                      size: 16,
                    )),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 3),
                    padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.white),
                    child: Text(
                      product.quantity.toString(),
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )),
                InkWell(
                    onTap: () {
                      var index = cartcontroller.cartProducts
                          .indexWhere((element) => element.id == product.id);
                      cartcontroller.cartProducts[index].quantity++;
                      cartcontroller.cartProducts.refresh();
                    },
                    child: const Icon(
                      Icons.add,
                      color: Colors.black,
                      size: 16,
                    )),
              ],
            ),
          )),
    );
  }

  String totalPrice() {
    double price = 0;
    for (var element in cartcontroller.cartProducts) {
      var itemPrice = element.price * element.quantity;
      price = price + double.parse(itemPrice.toString());
    }
    return price.toStringAsFixed(2);
  }
}
