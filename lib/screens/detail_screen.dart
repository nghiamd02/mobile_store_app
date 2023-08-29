import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mobile_store_app/bloc/detail_cubit.dart';
import 'package:mobile_store_app/bloc/detail_state.dart';
import 'package:mobile_store_app/screens/search_bar.dart';
import 'package:mobile_store_app/widget/text_format/detail_text.dart';
import 'package:mobile_store_app/widget/text_format/subtitle_text.dart';
import 'package:mobile_store_app/screens/cart_screen.dart';

import '../models/product.dart';
import '../repo/detail_repo.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final detailCubit = DetailCubit(DetailRepository());
  String baseUrl = "http://45.117.170.206:60/apis/file/display/";
  Product product = Product();

  @override
  void initState() {
    super.initState();
    _loadData(widget.id);
    _loadRelated(widget.id);
  }

  _loadData(int id) {
    detailCubit.fetchProductDetail(id).then((value) => {
          setState(() {
            product = value;
          })
        });
  }

  void onBack(int index) {
    setState(() {
      Navigator.pop(context);
    });
  }

  Future<void> _loadRelated(int id) async {
    await detailCubit.fetchRelatedProduct(id);
  }

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    String baseUrl = "http://45.117.170.206:60/apis/file/display/";
    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomSearchBar(),
              //PageView
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                width: double.infinity,
                height: 200,
                child: PageView.builder(
                  itemCount: product.images?.length ?? 0,
                  itemBuilder: (BuildContext context, int itemIndex) {
                    return ClipRRect(
                      child: Image.network(
                        baseUrl + (product.images?[itemIndex].name ?? ""),
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),

              //Name, detail
              Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 20),
                      alignment: Alignment.topLeft,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 5),
                            alignment: Alignment.topLeft,
                            child: Text(
                              product.name ?? "",
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Text(product.star.toString(),
                                  style: TextStyle(
                                    color: Color.fromRGBO(254, 140, 35, 1),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  )),
                              SizedBox(
                                width: 5,
                              ),
                              Wrap(
                                children: List.generate(5, (index) {
                                  return (index.toDouble() <
                                          (product.star ?? 0.0))
                                      ? Icon(
                                          Icons.star,
                                          color:
                                              Color.fromRGBO(254, 140, 35, 1),
                                          size: 15,
                                        )
                                      : Icon(
                                          Icons.star_border,
                                          color:
                                              Color.fromRGBO(254, 140, 35, 1),
                                          size: 15,
                                        );
                                }),
                              ),
                            ],
                          ),
                        ],
                      )),

                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(
                          3, (index) => itemButtonChoose(context, index)),
                    ),
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 60,
                          height: 30,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              "128 GB",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 60,
                          height: 30,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              "128 GB",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: 60,
                          height: 30,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text(
                              "128 GB",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Text(
                      product.price.toString(),
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  //Button "BUY NOW"
                  Container(
                    padding: EdgeInsets.all(5),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const CartScreen()));
                        },
                        child: Text("BUY NOW"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(91, 184, 93, 1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              //Specifications
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "SPECIFICATIONS",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            padding:
                                EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: detailedConfig(context),
                            // Column(
                            //   children: [
                            //     SizedBox(
                            //       width: double.infinity,
                            //       height: 30,
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //           color: Color.fromRGBO(0, 0, 0, 0.2),
                            //         ),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //           children: [
                            //             Text("Screen:"),
                            //             Text("IPS LCD6.56'HD+")
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: double.infinity,
                            //       height: 50,
                            //       child: Container(
                            //         padding: EdgeInsets.only(top: 10, bottom: 10),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //           children: [
                            //             Text("Screen:"),
                            //             Text("IPS LCD6.56'HD+")
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: double.infinity,
                            //       height: 30,
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //           color: Color.fromRGBO(0, 0, 0, 0.2),
                            //         ),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //           children: [
                            //             Text("Screen:"),
                            //             Text("IPS LCD6.56'HD+")
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: double.infinity,
                            //       height: 50,
                            //       child: Container(
                            //         padding: EdgeInsets.only(top: 10, bottom: 10),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //           children: [
                            //             Text("Screen:"),
                            //             Text("IPS LCD6.56'HD+")
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: double.infinity,
                            //       height: 30,
                            //       child: Container(
                            //         decoration: BoxDecoration(
                            //           color: Color.fromRGBO(0, 0, 0, 0.2),
                            //         ),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //           children: [
                            //             Text("Screen:"),
                            //             Text("IPS LCD6.56'HD+")
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: double.infinity,
                            //       height: 50,
                            //       child: Container(
                            //         padding: EdgeInsets.only(top: 10, bottom: 10),
                            //         child: Row(
                            //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //           children: [
                            //             Text("Screen:"),
                            //             Text("IPS LCD6.56'HD+")
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel:
                                        MaterialLocalizations.of(context)
                                            .modalBarrierDismissLabel,
                                    barrierColor: Colors.white,
                                    transitionDuration:
                                        Duration(microseconds: 200),
                                    pageBuilder: (BuildContext context,
                                        Animation first, Animation second) {
                                      return Scaffold(
                                        body: Center(
                                          child: Padding(
                                            padding: EdgeInsets.all(10),
                                            child: ListView.builder(
                                              itemCount:
                                                  product.productTechs?.length,
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  // alternate colors
                                                  color: index % 2 == 0
                                                      ? Colors.white
                                                      : Colors.black12,
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        top: 10, bottom: 10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Text("HI"),
                                                        Text("IPS LCD6.56'HD+")
                                                      ],
                                                    ),
                                                  ),
                                                  /*...*/
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "See more detailed configuration",
                                  style: TextStyle(
                                      color: Color.fromRGBO(91, 184, 93, 1)),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
                                      color: Color.fromRGBO(91, 184, 93, 1),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),

              //Product Information
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "PRODUCT INFORMATION",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            height: 100,
                            width: double.infinity,
                            child: Text(
                              product.description ?? "",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.justify,
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  showGeneralDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    barrierLabel:
                                        MaterialLocalizations.of(context)
                                            .modalBarrierDismissLabel,
                                    barrierColor: Colors.white,
                                    transitionDuration:
                                        Duration(microseconds: 200),
                                    pageBuilder: (BuildContext context,
                                        Animation first, Animation second) {
                                      return Center(
                                        child: Text(
                                          product.description ?? "",
                                          textAlign: TextAlign.justify,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Text(
                                  "See more",
                                  style: TextStyle(
                                      color: Color.fromRGBO(91, 184, 93, 1)),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
                                      color: Color.fromRGBO(91, 184, 93, 1),
                                    )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),

              //Review
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              "REVIEW OF CUSTOMER BOUGHT THE PRODUCT",
                              style: TextStyle(fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                              color: Colors.grey,
                            ))),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    DetailText(text: "Customer Name"),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Wrap(
                                      children: List.generate(5, (index) {
                                        return index <
                                                (product.star?.toInt() ?? 0)
                                            ? Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(
                                                    254, 140, 35, 1),
                                                size: 15,
                                              )
                                            : Icon(
                                                Icons.star_border,
                                                color: Color.fromRGBO(
                                                    254, 140, 35, 1),
                                                size: 15,
                                              );
                                      }),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: DetailText(
                                    text: "Customer review",
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
              Padding(
                  padding: EdgeInsets.all(5),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "ANOTHER PRODUCT",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        relatedProduct(context),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemButtonChoose(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
        },
        child: SizedBox(
          width: 60,
          height: 30,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(
                  color: (selectedIndex == index) ? Colors.green : Colors.grey),
            ),
            child: Text(
              "128 GB",
              style: TextStyle(
                  color: (selectedIndex == index) ? Colors.green : Colors.grey),
            ),
          ),
        ),
      ),
    );
  }

  Widget relatedProduct(BuildContext context) {
    return BlocProvider.value(
      value: detailCubit,
      child: BlocBuilder<DetailCubit, DetailState>(
        builder: (context, state) {
          if (state is InitDetailState || state is LoadingDetailState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ResponseRelatedState) {
            final products = state.products;
            return Container(
              padding: EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
              width: double.infinity,
              height: 200,
              child: ListView.builder(
                  itemCount: products.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10),
                            child: Text(
                              product.name ?? "",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Image.network(
                            baseUrl + (product.images?.first.name ?? ""),
                            height: 130,
                            width: 120,
                          ),
                          Subtitle(text: product.price.toString())
                        ],
                      ),
                    );
                  }),
            );
          } else if (state is ErrorDetailState) {
            return Center(
              child: Text(state.message),
            );
          }
          return Center(
            child: Text(state.toString()),
          );
        },
      ),
    );
  }

  Widget detailedConfig(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: product.productTechs?.length,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            // alternate colors
            color: index % 2 == 0 ? Colors.white : Colors.black12,
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(product.productTechs?[index].technical?.name ?? ""),
                  Html(data: product.productTechs?[index].info),
                ],
              ),
            ),
            /*...*/
          );
        },
      ),
    );
  }
}
