import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_store_app/bloc/detail_cubit.dart';
import 'package:mobile_store_app/bloc/detail_state.dart';
import 'package:mobile_store_app/models/cart.dart';
import 'package:mobile_store_app/repo/cart_repo.dart';
import 'package:mobile_store_app/screens/search/search_bar.dart';
import 'package:mobile_store_app/widget/text_format/detail_text.dart';
import 'package:mobile_store_app/widget/text_format/subtitle_text.dart';
import 'package:mobile_store_app/screens/cart_screen.dart';

import '../models/product.dart';
import '../repo/detail_repo.dart';

class DetailScreen extends StatefulWidget{
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final numberFormat = NumberFormat.decimalPattern('vi_VN');
  final detailCubit = DetailCubit(DetailRepository());
  String baseUrl = "http://45.117.170.206:60/apis/file/display/";
  Product product = Product();

  @override
  void initState() {
    super.initState();
    _loadData(widget.id);
    _loadRelated(widget.id);
  }

  Future<void> _loadData(int id) async {
    await detailCubit.fetchProductDetail(id).then((value) => {
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

  int colorIndex = 0;
  int memoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    String baseUrl = "http://45.117.170.206:60/apis/file/display/";
    return Scaffold(
      body: (product.id == null) ? Container() : SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const CustomSearchBar(),
            //PageView
            Container(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
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
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 5),
                          alignment: Alignment.topLeft,
                          child: Text(product.name ?? "", style: const TextStyle(
                            fontSize: 20,
                          ),),
                        ),
                        Row(
                          children: [
                            Text (product.star.toString(), style: const TextStyle(
                              color: Color.fromRGBO(254, 140, 35, 1),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            )),
                            const SizedBox(width: 5,),
                            Wrap(
                              children: List.generate(5, (index) {
                                return (index.toDouble() < (product.star ?? 0.0)) ?
                                const Icon(Icons.star, color:Color.fromRGBO(254, 140, 35, 1),
                                  size: 15,) :
                                const Icon(Icons.star_border, color:Color.fromRGBO(254, 140, 35, 1),
                                  size: 15,);
                              }),
                            ),
                          ],
                        ),
                      ],
                    )
                ),

                Container(
                  padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                  width: double.infinity,
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: product.colors?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 60,
                          height: 30,
                          child: GestureDetector(
                            onTap: () {
                              colorIndex = index;
                              _loadData(widget.id);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: (index == colorIndex)
                                    ? Colors.green
                                    : Colors.grey),
                              ),
                              child: Text(product.colors?[index].name ?? "",
                                style: TextStyle(color: (index == colorIndex)
                                    ? Colors.green
                                    : Colors.grey),),
                            ),
                        )
                      ),
                      );
                    },
                  ),
                ),

                Container(
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  width: double.infinity,
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: product.memories?.length ?? 0,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: SizedBox(
                          width: 60,
                          height: 30,
                          child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  memoryIndex = index;
                                  _loadData(widget.id);
                                });
                              },
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: (index == memoryIndex)
                                      ? Colors.green
                                      : Colors.grey),
                                ),
                                child: Text(product.memories?[index].name ?? "",
                                  style: TextStyle(color: (index == memoryIndex)
                                      ? Colors.green
                                      : Colors.grey),),
                              ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
                  child: Text("${numberFormat.format(product.price?.toInt())} VND",
                    style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w700,
                  ),),
                ),

                //Button "BUY NOW"
                Container(
                  padding: const EdgeInsets.all(5),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        CartRepository().addProduct(
                            Cart(
                              product: product,
                              memory: product.memories?[memoryIndex],
                              color: product.colors?[colorIndex],
                            )
                        );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const CartScreen()
                            )
                        );
                      },
                      child: const Text("BUY NOW"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(91, 184, 93, 1),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Specifications

            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text("SPECIFICATIONS", style: TextStyle(
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
                          child: detailedConfig(context),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _showDialogDetail(context);
                              },
                              child: const Text("See more detailed configuration",
                                style: TextStyle(
                                    color: Color.fromRGBO(91, 184, 93, 1)
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Color.fromRGBO(91, 184, 93, 1),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),

            // Product Information

            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text("PRODUCT INFORMATION", style: TextStyle(
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                        Container(
                          padding: const EdgeInsets.all(10),
                          height: 100,
                          width: double.infinity,
                          child: Text(product.description ?? "",
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.justify,),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
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
                                  transitionDuration: const Duration(microseconds: 200),
                                  pageBuilder: (BuildContext context,
                                      Animation first,
                                      Animation second) {
                                    return Center(
                                      child: Text(product.description ?? "",
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                        ),),
                                    );
                                  },
                                );
                              },
                              child: const Text("See more",
                                style: TextStyle(
                                    color: Color.fromRGBO(91, 184, 93, 1)
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Color.fromRGBO(91, 184, 93, 1),
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),

            //Review
            Padding(
              padding: const EdgeInsets.all(5),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 10),
                          child: const Text("REVIEW OF CUSTOMER BOUGHT THE PRODUCT",
                            style: TextStyle(
                              fontWeight: FontWeight.w700
                          ),),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: review(context),
                        ),
                        Container(
                          padding:const EdgeInsets.only(left: 10, right: 10),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                _showReview(context);
                              },
                              child: const Text("See more",
                                style: TextStyle(
                                    color: Color.fromRGBO(91, 184, 93, 1)
                                ),
                              ),
                              style: OutlinedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    color: Color.fromRGBO(91, 184, 93, 1),
                                  )
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(right: 8, bottom: 20),
                          alignment: Alignment.topRight,
                          child: ElevatedButton(
                            onPressed: () {
                              _dialogAddReview(context);
                            },
                            child: const Text(
                              "Review",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                const Color.fromRGBO(218, 83, 77, 1.0)),
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),

            Padding(
                padding: const EdgeInsets.all(5),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(top: 10),
                        child: const Text("ANOTHER PRODUCT", style: TextStyle(
                            fontWeight: FontWeight.w700
                        ),),
                      ),
                      const SizedBox(height: 5,),
                      relatedProduct(context),
                    ],
                  ),
                )
            ),
          ],
        ),
      )
    );
  }

  Widget relatedProduct(BuildContext context) {
    return BlocProvider.value(
      value: detailCubit,
      child: BlocBuilder<DetailCubit, DetailState> (
        builder: (context, state) {
          if (state is InitDetailState || state is LoadingDetailState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ResponseRelatedState) {
            final products = state.products;
            return Container(
              padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
                width: double.infinity,
                height: 200,
                child: ListView.builder(
                    itemCount: products.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey)
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Text(product.name ?? "",
                                style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),),
                            ),
                            Image.network(baseUrl + (product.images?.first.name ?? ""),
                              height: 130,
                              width: 120,),
                            Subtitle(text: product.price.toString())
                          ],
                        ),
                      );
                    }
                ),
            );
          } else if (state is ErrorDetailState) {
            return Center(child: Text(state.message),);
          }
          return Center(child: Text(state.toString()),);
        },
      ),
    );
  }

  Widget detailedConfig(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return
              Container(
                alignment: Alignment.center,
                color: index % 2 == 0 ? Colors.white : Colors.black12,
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(4),
                  },
                  children: [
                    TableRow(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(product.productTechs?[index].technical?.name ?? "",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.robotoSlab(
                                  fontSize: 14
                              ),),
                          ),
                          Container(
                              padding: const EdgeInsets.only(left: 5, right: 5),
                              child: Html(data: product.productTechs?[index].info)
                          ),
                        ]
                    ),
                    // Html(data: product.productTechs?[index].info),
                  ],
                ),
              );
          },
        ),
      ),
    );
  }

  Widget review(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: 3,
      // itemCount: product.reviews?.length ?? 0,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey,
                )
              )
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    DetailText(text: product.reviews?[index].userName ?? ""),
                    const SizedBox(width: 10,),
                    Wrap(
                      children: List.generate(5, (i) {
                        return (i < (product.reviews?[index].rating?.toInt() ?? 0) ?
                        const Icon(Icons.star, color:Color.fromRGBO(254, 140, 35, 1),
                          size: 15,) :
                        const Icon(Icons.star_border, color:Color.fromRGBO(254, 140, 35, 1),
                          size: 15,)
                        );
                      }),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: DetailText(text: product.reviews?[index].comment ?? "",),
                )
              ],
            ),
          );
        }
    );
  }

  _showDialogDetail(context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel:
      MaterialLocalizations.of(context)
          .modalBarrierDismissLabel,
      barrierColor: Colors.white,
      transitionDuration: const Duration(microseconds: 200),
      pageBuilder: (BuildContext context,
          Animation first,
          Animation second) {
        return Scaffold(
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  itemCount: product.productTechs?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      // alternate colors
                      color: index % 2 == 0 ? Colors.white : Colors.black12,
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Table(
                        children: [
                          TableRow(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: Text(product.productTechs?[index].technical?.name ?? "",
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.inter(
                                        fontSize: 14
                                    ),),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 5, right: 5),
                                  child: Html(data: product.productTechs?[index].info),
                                ),

                              ]
                          ),
                          // Html(data: product.productTechs?[index].info),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          )
        );
      },
    );
  }

  _showReview(context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel:
      MaterialLocalizations.of(context)
          .modalBarrierDismissLabel,
      barrierColor: Colors.white,
      transitionDuration: const Duration(microseconds: 200),
      pageBuilder: (BuildContext context,
          Animation first,
          Animation second) {
        return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    child: const Text("REVIEW OF CUSTOMER BOUGHT THE PRODUCT", style: TextStyle(
                        fontWeight: FontWeight.w700
                    ),),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: product.reviews?.length ?? 0,
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
                              decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                      )
                                  )
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      DetailText(text: product.reviews?[index].userName ?? ""),
                                      const SizedBox(width: 10,),
                                      Wrap(
                                        children: List.generate(5, (i) {
                                          return (i < (product.reviews?[index].rating?.toInt() ?? 0) ?
                                          const Icon(Icons.star, color:Color.fromRGBO(254, 140, 35, 1),
                                            size: 15,) :
                                          const Icon(Icons.star_border, color:Color.fromRGBO(254, 140, 35, 1),
                                            size: 15,)
                                          );
                                        }),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    alignment: Alignment.centerLeft,
                                    child: DetailText(text: product.reviews?[index].comment ?? "",),
                                  )
                                ],
                              ),
                            );
                          }
                      ),
                    ),
                  )
                ],
              ),
            )
        );
      },
    );
  }

  _dialogAddReview(context)  {
    int selectedRating = 0;
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: const EdgeInsets.only(top: 0.0),
          content: SizedBox(
            width: 300.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                InkWell(
                  child: Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    decoration: const BoxDecoration(
                      color: Colors.black12,
                    ),
                    child: const Text(
                      "REVIEW",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 10,),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          for (int i = 1; i <= 5; i++)
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedRating = i;
                                });
                              },
                              child: Icon(
                                Icons.star,
                                color: i <= selectedRating
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                            ),
                        ],
                      );
                    }
                ),
                const SizedBox(height: 10,),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.top,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 10.0),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        hintText: 'Commemts',
                        alignLabelWithHint: true,
                        hintStyle: TextStyle(
                          color: Colors.green,
                          fontSize: 14,
                        )
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5.0,
                ),
                const Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: Text("Send"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green
                        ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Close"),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromRGBO(218, 83, 77, 1.0)
                        ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    );
  }
}