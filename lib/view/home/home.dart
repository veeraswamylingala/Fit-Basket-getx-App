import 'dart:ffi';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:learn_getx/model/product.model.dart';
import 'package:learn_getx/view/cart/cart.dart';
import 'package:learn_getx/view/cart/cart_controller.dart';
import 'package:learn_getx/view/home/home_controller.dart';
import 'package:learn_getx/view/product/product.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  late TabController _controller;

  int _current = 0;

  final CarouselController _cController = CarouselController();

  final List<String> imgList = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTDf4Gp0hF1UW1adwxxPGxflM4CirpAKFsXqg&usqp=CAU',
  ];
  final CartController cartcontroller = Get.put(CartController());

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.redAccent,
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.redAccent,
                title: const Text("FitBasket"),
                automaticallyImplyLeading: false,
                snap: false,
                pinned: true,
                floating: false,
                expandedHeight: 300,
                actions: [
                  Stack(
                    children: [
                      IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Get.to(CartPage(), transition: Transition.downToUp);
                          },
                          icon: const Icon(Icons.shopping_cart)),
                      Positioned(
                        bottom: 10,
                        left: 22,
                        child: CircleAvatar(
                            backgroundColor: Colors.green,
                            radius: 8,
                            child: Obx(
                              () => Text(
                                cartcontroller.cartProducts.length.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                    color: Colors.white),
                              ),
                            )),
                      )
                    ],
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  background: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CarouselSlider(
                      items: imgList
                          .map((item) => Center(
                              child: Image.network(item,
                                  fit: BoxFit.cover, width: 1000)))
                          .toList(),
                      carouselController: _cController,
                      options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: false,
                          viewportFraction: 0.9,
                          aspectRatio: 4.0,
                          onPageChanged: (index, reason) {
                            // setState(() {
                            //   _current = index;
                            // });
                          }),
                    ),
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: const Size(50, 100),
                  child: TabBar(
                    indicatorColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.label,
                    controller: _controller,
                    tabs: [
                      SizedBox(
                          height: 100,
                          child: Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 70,
                                    child: Image.asset(
                                        "assets/images/strawberry.png")),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text("Fruits"),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                          height: 100,
                          child: Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 70,
                                    child: Image.asset(
                                        "assets/images/peppers.png")),
                                const FittedBox(child: Text("Vegetables")),
                              ],
                            ),
                          )),
                      SizedBox(
                          height: 100,
                          child: Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                    height: 70,
                                    child: Image.asset(
                                        "assets/images/almonds.png")),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text("Healthy"),
                                ),
                              ],
                            ),
                          )),
                      SizedBox(
                          height: 100,
                          child: Tab(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 70,
                                  child: Image.asset(
                                    "assets/images/strawberrybeveragehealthmilkshake-removebg-preview.png",
                                  ),
                                ),
                                const Align(
                                  alignment: Alignment.center,
                                  child: Text("Drinks"),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
              ),
            ];
          }, //<Widget>[]
          body: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                )),
            child: TabBarView(
              controller: _controller,
              children: [
                fruitsWidget(),
                vegetablesWidget(),
                healthyWidget(),
                drinksWidget()
              ],
            ),
          ),
        ) //CustonScrollView
        ); //Scaffold
  }

  Widget fruitsWidget() {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          //  "category": "fruits"
          List<ProductModel> fruitsList = controller.products
              .where((product) => product.category == "fruits")
              .toList();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 1,
                    //   childAspectRatio: 8 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                itemCount: fruitsList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return productTabWidget(product: fruitsList[index]);
                }),
          );
        });
  }

  Widget vegetablesWidget() {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          //  "category": "fruits"
          List<ProductModel> vegetablesList = controller.products
              .where((product) => product.category == "vegetables")
              .toList();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 1,
                    //   childAspectRatio: 8 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                itemCount: vegetablesList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return productTabWidget(product: vegetablesList[index]);
                }),
          );
        });
  }

  Widget healthyWidget() {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          //  "category": "fruits"
          List<ProductModel> vegetablesList = controller.products
              .where((product) => product.category == "Healthy")
              .toList();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 1,
                    //   childAspectRatio: 8 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                itemCount: vegetablesList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return productTabWidget(product: vegetablesList[index]);
                }),
          );
        });
  }

  Widget drinksWidget() {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          //  "category": "fruits"
          List<ProductModel> vegetablesList = controller.products
              .where((product) => product.category == "Drinks")
              .toList();
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 1 / 1,
                    //   childAspectRatio: 8 / 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 10),
                itemCount: vegetablesList.length,
                itemBuilder: (BuildContext ctx, index) {
                  return productTabWidget(product: vegetablesList[index]);
                }),
          );
        });
  }

  Widget productTabWidget({required ProductModel product}) {
    return GestureDetector(
      onTap: () {
        Get.to(
            ViewProduct(
              product: product,
            ),
            transition: Transition.rightToLeft);
      },
      child: Card(
        elevation: 10,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.redAccent, borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Expanded(
                  // padding: EdgeInsets.all(10),
                  child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    // color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        product.image,
                        // fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                      top: 12,
                      right: 12,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius: BorderRadius.circular(9)),
                        child: const Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Icon(
                            Icons.favorite_border,
                            size: 19,
                            color: Colors.white38,
                          ),
                        ),
                      ))
                ],
              )),
              Container(
                color: Colors.white,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            product.name,
                            style: const TextStyle(
                                fontSize: 14,
                                letterSpacing: 2,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        const Text(
                          "Price per kg",
                          style: TextStyle(
                              fontSize: 12,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w200),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "\$ " + product.price.toString(),
                              style: const TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.w500),
                            ),
                            Obx(() => cartcontroller.cartProducts
                                    .indexWhere(
                                        (element) => element.id == product.id)
                                    .isNegative
                                ? Container(
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: const Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.add_shopping_cart_rounded,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  )
                                : const SizedBox()),
                          ],
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
