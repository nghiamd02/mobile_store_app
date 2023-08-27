import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/promotion_cubit.dart';
import 'package:mobile_store_app/repo/promotion_repo.dart';
import 'package:mobile_store_app/screens/search/search_bar.dart';
import 'package:mobile_store_app/screens/your_information/your_information_screen.dart';

import '../bloc/promotion_state.dart';
import '../models/promotion.dart';

class PromotionScreen extends StatelessWidget {
  const PromotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _PromotionPage(),
    );
  }
}

class _PromotionPage extends StatefulWidget {
  const _PromotionPage({super.key});

  @override
  State<_PromotionPage> createState() => __PromotionPageState();
}

class __PromotionPageState extends State<_PromotionPage> {
  final promotionCubit = PromotionCubit(PromotionRepository());
  int totalPages = 0;
  int currentPage = 0;
  final int limit = 2;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await promotionCubit.getAllProfile(currentPage, limit);
  }

  void _changePage(int page) {
    if (page >= 0 && page < totalPages && page != currentPage) {
      setState(() {
        currentPage = page;
      });
      _loadData(); // Gọi lại _loadData() để cập nhật dữ liệu trang mới
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(224, 234, 235, 1),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
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
                    Expanded(
                      child: BlocProvider.value(
                        value: promotionCubit,
                        child: BlocBuilder<PromotionCubit, PromotionState>(
                          builder: (context, state) {
                            if (state is InitialPromotionState ||
                                state is LoadingPromotionState) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            } else if (state is SuccessLoadingPromotionState) {
                              final promotions = state.apiResponse.contents;
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: promotions.length,
                                itemBuilder: (context, index) {
                                  final promotion = promotions[index];
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
                                              50, // Đặt kích thước cố định cho hình lục giác
                                              height:
                                              50, // Đặt kích thước cố định cho hình lục giác
                                              child: CustomPaint(
                                                painter: _HexagonPainter(),
                                                child: Center(
                                                  child: Text(
                                                    '${promotion.discount}%',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                      FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '${promotion.discount}% discount for orders under \$${promotion.maxGet.toStringAsFixed(0)}, for customers who bought \$${promotion.totalPurchase.toStringAsFixed(0)}',
                                                    style: const TextStyle(
                                                      wordSpacing: 5,
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w300,
                                                      color: Color(0xff979595),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 3),
                                                  Text(
                                                    'Exp: ${promotion.expireDate}',
                                                    style: const TextStyle(
                                                      fontFamily: "Inter",
                                                      fontSize: 12,
                                                      fontWeight:
                                                      FontWeight.w300,
                                                      color: Color(0xff979595),
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
                            } else if (state is FailurePromotionState) {
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
                            value: promotionCubit,
                            child: BlocBuilder<PromotionCubit, PromotionState>(
                              builder: (context, state) {
                                if (state is SuccessLoadingPromotionState) {
                                  totalPages = state.apiResponse.totalPages;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children:
                                    List.generate(totalPages, (index) {
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
      ),
    );
  }
}

class _HexagonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final hexagonPath = Path();
    hexagonPath.moveTo(size.width * 0.5, 0);
    hexagonPath.lineTo(size.width, size.height * 0.25);
    hexagonPath.lineTo(size.width, size.height * 0.75);
    hexagonPath.lineTo(size.width * 0.5, size.height);
    hexagonPath.lineTo(0, size.height * 0.75);
    hexagonPath.lineTo(0, size.height * 0.25);
    hexagonPath.close();

    final hexagonPaint = Paint()..color = Color.fromARGB(255, 242, 25, 25);

    canvas.drawPath(hexagonPath, hexagonPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}