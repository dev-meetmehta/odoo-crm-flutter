import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String storeName, address;
  final bool isSearchbar;
  bool canEditSearchBar;
  String Storename;
  int popUpNum;
  bool fromSubCategoryView;
  bool fromProductView;

  // final Drawer drawer;
  KCustomAppBar(
      {Key? key,
      required this.popUpNum,
      required BuildContext context,
      required this.storeName,
      required this.address,
      required this.isSearchbar,
      required this.canEditSearchBar,
      required this.Storename,
      required this.fromSubCategoryView,
      required this.fromProductView})
      : super(key: key);

  @override
  Size get preferredSize => isSearchbar
      ? Size.fromHeight(Get.height * 0.13)
      : Size.fromHeight(Get.height * 0.1);

  @override
  Widget build(BuildContext context) {
    // final _cartController = Get.put(CartController());
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          padding: EdgeInsets.only(
              top: 45, right: 8, left: 5, bottom: isSearchbar ? 0 : 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 8.0, left: 8),
                        child: Icon(
                          Icons.menu_outlined,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    SizedBox(
                      width: 260,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              storeName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 2),
                            Text(
                              address,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ]),
                    ),
                  ]),
                ],
              ),
              //     Row(
              //       children: [
              //         GestureDetector(
              //           onTap: (() {
              //             showDialog(
              //                 context: context,
              //                 builder: (BuildContext context) {
              //                   return dropDownAlert(
              //                     condition: popUpNum,
              //                     address: address,
              //                   );
              //                 });
              //           }),
              //           child: Icon(
              //             Icons.keyboard_arrow_down_rounded,
              //             size: 33.h,
              //             color: Colors.white,
              //           ),
              //         ),
              //         Stack(
              //           children: [
              //             GestureDetector(
              //               // child: Icon(
              //               child: Container(
              //                 child: Image.asset(
              //                   'assets/images/cart_icon.png',
              //                   fit: BoxFit.fill,
              //                 ),
              //                 width: 33.h,
              //               ),
              //               // size: 33.h,
              //               //   color: Colors.white,
              //               // ),
              //               onTap: () async {
              //                 await Get.find<CartController>().getData("");
              //                 await Get.find<CartController>().validate_cart();
              //                 Get.to(CartView());
              //                 // binding: CartBinding(),
              //                 // arguments: [
              //                 //   fromSubCategoryView,
              //                 //   fromProductView
              //                 // ]);
              //               },
              //             ),
              //             Container(
              //               decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(100),
              //                   color: Colors.red),
              //               child: GetBuilder<CartController>(
              //                   builder: (controller) {
              //                 return Visibility(
              //                   visible: (controller.num_of_products > 0)
              //                       ? true
              //                       : false,
              //                   child: Text(
              //                     controller.num_of_products.toString(),
              //                     style: TextStyle(color: Colors.white),
              //                   ),
              //                 );
              //               }),
              //             ),
              //           ],
              //         )
              //       ],
              //     ),
              //   ],
              // ),
              isSearchbar
                  ? InkWell(
                      onTap: () {
                        Get.toNamed('/product-search');
                      },
                      child: Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.green.shade900,
                          ),
                          height: 45,
                          child: TextField(
                            enabled: canEditSearchBar,
                            cursorColor: Colors.white,
                            style: TextStyle(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w300),
                            decoration: InputDecoration(
                              hintText: Storename,
                              hintStyle: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                  size: 32,
                                ),
                              ),
                              border: InputBorder.none,
                            ),
                          )),
                    )
                  : Container(),
            ],
          ),
        ),
      ],
    );
  }
}
