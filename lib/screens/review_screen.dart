import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/review_cubit.dart';
import 'package:mobile_store_app/repo/review_repo.dart';

import '../bloc/state/review_state.dart';
import '../models/review.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _ReviewScreen(),
    );
  }
}

class _ReviewScreen extends StatefulWidget {
  const _ReviewScreen({Key? key}) : super(key: key);

  @override
  State<_ReviewScreen> createState() => __ReviewScreenState();
}

class __ReviewScreenState extends State<_ReviewScreen> {
  final reviewCubit = ReviewCubit(ReviewRepository());
  int totalPages = 0;
  int currentPage = 0;
  final int limit = 10;
  int selectedRating = 0;
  int idProduct = 6;
  TextEditingController commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await reviewCubit.getAllReviewsById(currentPage, limit, idProduct);
  }

  void _changePage(int page) {
    if (page >= 0 && page < totalPages && page != currentPage) {
      setState(() {
        currentPage = page;
      });
      _loadData(); // Gọi lại _loadData() để cập nhật dữ liệu trang mới
    }
  }

  Future<void> _sendBtn() async {
    final int rating = selectedRating;
    final String comment = commentsController.text;

    final content = Content(
      productId: 6,
      comment: comment,
      rating: rating,
      status: true,
    );
    await reviewCubit.createReview(content);
  }

  Widget _listReviews() {
    return Container(
      color: const Color.fromRGBO(224, 234, 235, 1),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 200,
            ),
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
                                            width:
                                                150, // Đặt kích thước cố định cho hình lục giác
                                            height:
                                                30, // Đặt kích thước cố định cho hình lục giác
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
                        height: 118,
                        width: 500,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: const Color(0xFFD6D6D6)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextFormField(
                            controller: commentsController,
                            maxLines: 3,
                            textInputAction: TextInputAction.newline,
                            decoration: const InputDecoration(
                              hintText: 'Comments:',
                              hintStyle: TextStyle(color: Colors.green),
                              border: InputBorder.none,
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
                            await _sendBtn();
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Review Screen'),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _showReviewDialog,
              child: const Text('Open Review Dialog'),
            ),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => _listReviews(),
                  ),
                );
              },
              child: const Text('Show Review'),
            ),
          ],
        ),
      ),
    );
  }
}
