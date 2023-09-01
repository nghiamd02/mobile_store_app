import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mobile_store_app/bloc/detail_cubit.dart';
import 'package:mobile_store_app/bloc/detail_state.dart';
import 'package:mobile_store_app/models/cart.dart';
import 'package:mobile_store_app/repo/cart_repo.dart';

import 'package:mobile_store_app/screens/search_bar.dart';
import 'package:mobile_store_app/widget/text_format/detail_text.dart';
import 'package:mobile_store_app/widget/text_format/subtitle_text.dart';
import 'package:mobile_store_app/screens/cart_screen.dart';

import '../bloc/review_cubit.dart';
import '../bloc/state/review_state.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../repo/detail_repo.dart';
import '../repo/review_repo.dart';

class DetailScreen extends StatefulWidget {
  final int id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final reviewCubit = ReviewCubit(ReviewRepository());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int totalPages = 0;
  int currentPage = 0;
  final int limit = 10;
  int selectedRating = 0;
  TextEditingController commentsController = TextEditingController();
  final numberFormat = NumberFormat.decimalPattern('vi_VN');
  final detailCubit = DetailCubit(DetailRepository());
  String baseUrl = "http://45.117.170.206:60/apis/file/display/";
  Product product = Product();

  @override
  void initState() {
    super.initState();
    _loadData(widget.id);
    _loadRelated(widget.id);
    _loadDataReview(widget.id);
  }

  _loadData(int id) {
    detailCubit.fetchProductDetail(id).then((value) => {
          setState(() {
            product = value;
          })
        });
  }

  Future<void> _loadDataReview(int id) async {
    await reviewCubit.getAllReviewsById(currentPage, limit, id);
  }

  void _changePage(int page) {
    if (page >= 0 && page < totalPages && page != currentPage) {
      setState(() {
        currentPage = page;
      });
      _loadDataReview(widget.id);
    }
  }

  Future<void> _sendBtn(int id) async {
    final int rating = selectedRating;
    final String comment = commentsController.text;

    final content = ContentReview(
      productId: id,
      comment: comment,
      rating: rating,
      status: true,
    );
    await reviewCubit.createReview(content);
    _loadDataReview(widget.id);
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

  Widget _listReviews() {
    return Container(
      color: const Color.fromRGBO(224, 234, 235, 1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Review of customer bought the product",
                    style: TextStyle(
                      fontFamily: "Inter",
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff000000),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: BlocProvider.value(
                      value: reviewCubit,
                      child: BlocBuilder<ReviewCubit, ReviewState>(
                        builder: (context, state) {
                          if (state is InitialReviewState ||
                              state is LoadingReviewState) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (state is SuccessLoadingReviewState) {
                            final contents = state.reviewResponse.contents;
                            return ListView.builder(
                              itemCount: contents.length,
                              itemBuilder: (context, index) {
                                final content = contents[index];
                                return Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 150,
                                            height: 30,
                                            child: Text(
                                              content.userName!,
                                              style: const TextStyle(
                                                fontFamily: "Inter",
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400,
                                                color: Color(0xff000000),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: List.generate(
                                                    content.rating!,
                                                    (index) => const Icon(
                                                      Icons.star,
                                                      color: Colors.orange,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  content.comment!,
                                                  style: const TextStyle(
                                                    fontFamily: "Inter",
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w400,
                                                    color: Color(0xff000000),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          } else if (state is FailureReviewState) {
                            return Center(
                              child: Text(state.errorMessage),
                            );
                          }
                          return Container();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        BlocProvider.value(
                          value: reviewCubit,
                          child: BlocBuilder<ReviewCubit, ReviewState>(
                            builder: (context, state) {
                              if (state is SuccessLoadingReviewState) {
                                totalPages = state.reviewResponse.totalPages;
                                return Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(totalPages, (index) {
                                    return ElevatedButton(
                                      onPressed: () {
                                        _changePage(index);
                                      },
                                      child: Text((index + 1).toString()),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: index == currentPage
                                            ? Colors.blue
                                            : Colors.grey,
                                      ),
                                    );
                                  }),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotySuccess() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          double dialogWidth = MediaQuery.of(context).size.width * 0.8;
          return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              titlePadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  width: dialogWidth,
                  height: 80,
                  decoration: const BoxDecoration(
                    color: Color(0xFF5BB85D),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Your review have sent',
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ),
                ),
              ),
              content: Container(
                width: dialogWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: const Text(
                  "Thank for your sharing! ",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff000000),
                  ),
                  textAlign: TextAlign.center,
                ),
              ));
        });
  }

  // void _showReviewDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       double dialogWidth = MediaQuery.of(context).size.width * 0.8;
  //       return BlocProvider.value(
  //         value: reviewCubit,
  //         child: BlocConsumer<ReviewCubit, ReviewState>(
  //           listener: (context, state) {
  //             if (state is FailureReviewState) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 SnackBar(
  //                   content: Text(state.errorMessage),
  //                   duration: const Duration(seconds: 2),
  //                 ),
  //               );
  //             } else if (state is SuccessSubmitReviewState) {
  //               // ScaffoldMessenger.of(context).showSnackBar(
  //               //   SnackBar(
  //               //     content: Text(state.successMessage),
  //               //     duration: const Duration(seconds: 2),
  //               //   ),
  //               // );
  //               _showNotySuccess();
  //             }
  //           },
  //           builder: (context, state) {
  //             return AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10.0),
  //               ),
  //               titlePadding: EdgeInsets.zero,
  //               title: Padding(
  //                 padding: const EdgeInsets.only(bottom: 4.0),
  //                 child: Container(
  //                   width: dialogWidth,
  //                   height: 60,
  //                   decoration: const BoxDecoration(
  //                     color: Color(0xFFD6D6D6),
  //                     borderRadius: BorderRadius.only(
  //                       topLeft: Radius.circular(10.0),
  //                       topRight: Radius.circular(10.0),
  //                     ),
  //                   ),
  //                   child: const Center(
  //                     child: Text(
  //                       'PRODUCT REVIEW',
  //                       style: TextStyle(
  //                         fontFamily: "Roboto",
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.w800,
  //                         color: Color(0xff000000),
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               content: Container(
  //                 width: dialogWidth,
  //                 decoration: const BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(10.0),
  //                     topRight: Radius.circular(10.0),
  //                   ),
  //                 ),
  //                 child: Column(
  //                   mainAxisSize: MainAxisSize.min,
  //                   children: <Widget>[
  //                     StatefulBuilder(
  //                       builder: (BuildContext context, StateSetter setState) {
  //                         return Padding(
  //                           padding: const EdgeInsets.only(
  //                             bottom: 16.0,
  //                           ),
  //                           child: Container(
  //                             color: Colors.white,
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: <Widget>[
  //                                 for (int i = 1; i <= 5; i++)
  //                                   GestureDetector(
  //                                     onTap: () {
  //                                       setState(() {
  //                                         selectedRating = i;
  //                                       });
  //                                     },
  //                                     child: Icon(
  //                                       Icons.star,
  //                                       color: i <= selectedRating
  //                                           ? Colors.amber
  //                                           : Colors.grey,
  //                                     ),
  //                                   ),
  //                               ],
  //                             ),
  //                           ),
  //                         );
  //                       },
  //                     ),
  //                     Container(
  //                       height: 118,
  //                       width: 500,
  //                       decoration: BoxDecoration(
  //                         color: Colors.white,
  //                         border: Border.all(color: const Color(0xFFD6D6D6)),
  //                       ),
  //                       child: Padding(
  //                         padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //                         child: Column(
  //                           children: [
  //                             TextFormField(
  //                               controller: commentsController,
  //                               maxLines: 3,
  //                               textInputAction: TextInputAction.newline,
  //                               decoration: const InputDecoration(
  //                                 hintText: 'Comments:',
  //                                 hintStyle: TextStyle(color: Colors.green),
  //                                 border: InputBorder.none,
  //                               ),
  //                               validator: (value) {
  //                                 if (value!.isEmpty) {
  //                                   return 'Please enter comments';
  //                                 }
  //                                 return null;
  //                               },
  //                             ),
  //                             // Hiển thị thông báo lỗi
  //                             if (_formKey.currentState?.validate() == false)
  //                               const Text(
  //                                 'Please enter comments',
  //                                 style: TextStyle(
  //                                   color: Colors.red,
  //                                 ),
  //                               ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               actions: <Widget>[
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                   children: [
  //                     Container(
  //                       width: 117,
  //                       height: 39,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(5),
  //                         color: Color(0xff5bb85d),
  //                       ),
  //                       child: TextButton(
  //                         onPressed: () async {
  //                           if (_formKey.currentState?.validate() == true) {
  //                           await _sendBtn(widget.id);
  //                           // ignore: use_build_context_synchronously
  //                           Navigator.pop(context);
  //                         }
  //                         },
  //                         child: const Text(
  //                           'Send',
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                     Container(
  //                       width: 117,
  //                       height: 39,
  //                       decoration: BoxDecoration(
  //                         borderRadius: BorderRadius.circular(5),
  //                         color: Colors.red,
  //                       ),
  //                       child: TextButton(
  //                         onPressed: () {
  //                           Navigator.pop(context);
  //                         },
  //                         child: const Text(
  //                           'Cancel',
  //                           style: TextStyle(color: Colors.white),
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             );
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }
void _showReviewDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      double dialogWidth = MediaQuery.of(context).size.width * 0.8;
      return BlocProvider.value(
        value: reviewCubit,
        child: BlocConsumer<ReviewCubit, ReviewState>(
          listener: (context, state) {
            if (state is FailureReviewState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                  duration: const Duration(seconds: 2),
                ),
              );
            } else if (state is SuccessSubmitReviewState) {
              // ScaffoldMessenger.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text(state.successMessage),
              //     duration: const Duration(seconds: 2),
              //   ),
              // );
              _showNotySuccess();
            }
          },
          builder: (context, state) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              titlePadding: EdgeInsets.zero,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 4.0),
                child: Container(
                  width: dialogWidth,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD6D6D6),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'PRODUCT REVIEW',
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                ),
              ),
              content: Container(
                width: dialogWidth,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16.0,
                          ),
                          child: Container(
                            color: Colors.white,
                            child: Row(
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
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      height: 130,
                      width: 500,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: const Color(0xFFD6D6D6)),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              
                              TextFormField(
                                controller: commentsController,
                                maxLines: 3,
                                textInputAction: TextInputAction.newline,
                                decoration: const InputDecoration(
                                  hintText: 'Comments:',
                                  hintStyle: TextStyle(color: Colors.green),
                                  border: InputBorder.none,
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Please enter comments';
                                  }
                                  return null;
                                },
                              ),
                              // Hiển thị thông báo lỗi
                              // if (_formKey.currentState?.validate() == false)
                              //   const Text(
                              //     'Please enter comments',
                              //     style: TextStyle(
                              //       color: Colors.red,
                              //     ),
                              //   ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 117,
                      height: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color(0xff5bb85d),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          // Kiểm tra xem có lỗi không trước khi gửi
                          if (_formKey.currentState?.validate() == true) {
                            await _sendBtn(widget.id);
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          }
                        },
                        child: const Text(
                          'Send',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      width: 117,
                      height: 39,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.red,
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      );
    },
  );
}

  @override
  Widget build(BuildContext context) {
    String baseUrl = "http://45.117.170.206:60/apis/file/display/";
    return Scaffold(
        body: product.id == null
            ? Container()
            : SingleChildScrollView(
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
                                  child: Text(
                                    product.name ?? "",
                                    style: const TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(product.star.toString(),
                                        style: const TextStyle(
                                          color:
                                              Color.fromRGBO(254, 140, 35, 1),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        )),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Wrap(
                                      children: List.generate(5, (index) {
                                        return (index.toDouble() <
                                                (product.star ?? 0.0))
                                            ? const Icon(
                                                Icons.star,
                                                color: Color.fromRGBO(
                                                    254, 140, 35, 1),
                                                size: 15,
                                              )
                                            : const Icon(
                                                Icons.star_border,
                                                color: Color.fromRGBO(
                                                    254, 140, 35, 1),
                                                size: 15,
                                              );
                                      }),
                                    ),
                                  ],
                                ),
                              ],
                            )),

                        Container(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20),
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
                                          border: Border.all(
                                              color: (index == colorIndex)
                                                  ? Colors.green
                                                  : Colors.grey),
                                        ),
                                        child: Text(
                                          product.colors?[index].name ?? "",
                                          style: TextStyle(
                                              color: (index == colorIndex)
                                                  ? Colors.green
                                                  : Colors.grey),
                                        ),
                                      ),
                                    )),
                              );
                            },
                          ),
                        ),

                        Container(
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
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
                                        border: Border.all(
                                            color: (index == memoryIndex)
                                                ? Colors.green
                                                : Colors.grey),
                                      ),
                                      child: Text(
                                        product.memories?[index].name ?? "",
                                        style: TextStyle(
                                            color: (index == memoryIndex)
                                                ? Colors.green
                                                : Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.only(
                              top: 10, left: 20, right: 20),
                          child: Text(
                            "${numberFormat.format(product.price?.toInt())} VND",
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        //Button "BUY NOW"
                        Container(
                          padding: const EdgeInsets.all(5),
                          child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                CartRepository().addProduct(Cart(
                                  product: product,
                                  memory: product.memories?[memoryIndex],
                                  color: product.colors?[colorIndex],
                                ));
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const CartScreen()));
                              },
                              child: const Text("BUY NOW"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(91, 184, 93, 1),
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
                              border: Border.all(color: Colors.grey)),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: const Text(
                                    "SPECIFICATIONS",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10, top: 10),
                                  child: detailedConfig(context),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _showDialogDetail(context);
                                      },
                                      child: const Text(
                                        "See more detailed configuration",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(91, 184, 93, 1)),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: const BorderSide(
                                            color:
                                                Color.fromRGBO(91, 184, 93, 1),
                                          )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),

                    // Product Information

                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: const Text(
                                    "PRODUCT INFORMATION",
                                    style:
                                        TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  height: 100,
                                  width: double.infinity,
                                  child: Text(
                                    product.description ?? "",
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 10, right: 10),
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
                                              const Duration(microseconds: 200),
                                          pageBuilder: (BuildContext context,
                                              Animation first,
                                              Animation second) {
                                            return Center(
                                              child: Text(
                                                product.description ?? "",
                                                textAlign: TextAlign.justify,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: const Text(
                                        "See more",
                                        style: TextStyle(
                                            color:
                                                Color.fromRGBO(91, 184, 93, 1)),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          side: const BorderSide(
                                            color:
                                                Color.fromRGBO(91, 184, 93, 1),
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
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                // Container(
                                //   padding: const EdgeInsets.only(top: 10),
                                //   child: const Text(
                                //     "REVIEW OF CUSTOMER BOUGHT THE PRODUCT",
                                //     style:
                                //         TextStyle(fontWeight: FontWeight.w700),
                                //   ),
                                // ),
                                // Container(
                                //   padding: const EdgeInsets.only(
                                //       left: 10, right: 10),
                                //   child: review(context),
                                // ),
                                // Container(
                                //   padding: const EdgeInsets.only(
                                //       left: 10, right: 10),
                                //   child: SizedBox(
                                //     width: double.infinity,
                                //     child: ElevatedButton(
                                //       onPressed: () {
                                //         _showReview(context);
                                //       },
                                //       child: const Text(
                                //         "See more",
                                //         style: TextStyle(
                                //             color:
                                //                 Color.fromRGBO(91, 184, 93, 1)),
                                //       ),
                                //       style: OutlinedButton.styleFrom(
                                //           backgroundColor: Colors.white,
                                //           side: const BorderSide(
                                //             color:
                                //                 Color.fromRGBO(91, 184, 93, 1),
                                //           )),
                                //     ),
                                //   ),
                                // ),
                                _listReviews(),
                                Container(
                                  padding: const EdgeInsets.only(
                                      right: 8, bottom: 20),
                                  alignment: Alignment.topRight,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      _showReviewDialog();
                                    },
                                    child: const Text(
                                      "Review",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromRGBO(
                                            218, 83, 77, 1.0)),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ),

                    Padding(
                        padding: const EdgeInsets.all(5),
                        child: SizedBox(
                          width: double.infinity,
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 10),
                                child: const Text(
                                  "ANOTHER PRODUCT",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              relatedProduct(context),
                            ],
                          ),
                        )),
                  ],
                ),
              ));
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
              padding:
                  const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 5),
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
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              product.name ?? "",
                              style: const TextStyle(
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
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              alignment: Alignment.center,
              color: index % 2 == 0 ? Colors.white : Colors.black12,
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: Table(
                columnWidths: const {
                  0: FlexColumnWidth(2),
                  1: FlexColumnWidth(4),
                },
                children: [
                  TableRow(children: [
                    Container(
                      padding: const EdgeInsets.only(left: 5, right: 5),
                      child: Text(
                        product.productTechs?[index].technical?.name ?? "",
                        textAlign: TextAlign.left,
                        style: GoogleFonts.robotoSlab(fontSize: 14),
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: Html(data: product.productTechs?[index].info)),
                  ]),
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
            ))),
            child: Column(
              children: [
                Row(
                  children: [
                    DetailText(text: product.reviews?[index].userName ?? ""),
                    const SizedBox(
                      width: 10,
                    ),
                    Wrap(
                      children: List.generate(5, (i) {
                        return (i <
                                (product.reviews?[index].rating?.toInt() ?? 0)
                            ? const Icon(
                                Icons.star,
                                color: Color.fromRGBO(254, 140, 35, 1),
                                size: 15,
                              )
                            : const Icon(
                                Icons.star_border,
                                color: Color.fromRGBO(254, 140, 35, 1),
                                size: 15,
                              ));
                      }),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: DetailText(
                    text: product.reviews?[index].comment ?? "",
                  ),
                )
              ],
            ),
          );
        });
  }

  _showDialogDetail(context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.white,
      transitionDuration: const Duration(microseconds: 200),
      pageBuilder: (BuildContext context, Animation first, Animation second) {
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
                        TableRow(children: [
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Text(
                              product.productTechs?[index].technical?.name ??
                                  "",
                              textAlign: TextAlign.left,
                              style: GoogleFonts.inter(fontSize: 14),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child:
                                Html(data: product.productTechs?[index].info),
                          ),
                        ]),
                        // Html(data: product.productTechs?[index].info),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ));
      },
    );
  }

  _showReview(context) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.white,
      transitionDuration: const Duration(microseconds: 200),
      pageBuilder: (BuildContext context, Animation first, Animation second) {
        return Scaffold(
            body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 30),
                child: const Text(
                  "REVIEW OF CUSTOMER BOUGHT THE PRODUCT",
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
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
                          padding: const EdgeInsets.only(
                              top: 10, right: 10, left: 10),
                          decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                            color: Colors.grey,
                          ))),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  DetailText(
                                      text: product.reviews?[index].userName ??
                                          ""),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Wrap(
                                    children: List.generate(5, (i) {
                                      return (i <
                                              (product.reviews?[index].rating
                                                      ?.toInt() ??
                                                  0)
                                          ? const Icon(
                                              Icons.star,
                                              color: Color.fromRGBO(
                                                  254, 140, 35, 1),
                                              size: 15,
                                            )
                                          : const Icon(
                                              Icons.star_border,
                                              color: Color.fromRGBO(
                                                  254, 140, 35, 1),
                                              size: 15,
                                            ));
                                    }),
                                  ),
                                ],
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: DetailText(
                                  text: product.reviews?[index].comment ?? "",
                                ),
                              )
                            ],
                          ),
                        );
                      }),
                ),
              )
            ],
          ),
        ));
      },
    );
  }

  _dialogAddReview(context) {
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
                              color: Colors.black, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
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
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 50, horizontal: 10.0),
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
                            )),
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
                              backgroundColor: Colors.green),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text("Close"),
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromRGBO(218, 83, 77, 1.0)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ));
  }
}
