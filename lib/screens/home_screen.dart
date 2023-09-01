import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:mobile_store_app/bloc/home_cubit.dart';

import 'package:mobile_store_app/screens/search_bar.dart';
import 'package:mobile_store_app/widget/bottom_navigation.dart';
import 'package:mobile_store_app/widget/text_format/subtitle_text.dart';
import 'package:mobile_store_app/widget/text_format/title_text.dart';
import 'package:mobile_store_app/screens/detail_screen.dart';

import '../bloc/home_state.dart';
import '../models/product.dart';
import '../repo/home_repo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeCubit = HomeCubit(HomeRepository());
  late final Product product;
  final numberFormat = NumberFormat.decimalPattern('vi_VN');

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    await homeCubit.fetchNew();
  }

  List images = [
    "https://i.imgur.com/6Qz6iwd.png",
    "https://i.imgur.com/6Qz6iwd.png",
    "https://i.imgur.com/6Qz6iwd.png",
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomSearchBar(),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 48, right: 48),
              child: CarouselSlider.builder(
                  itemCount: images.length,
                  itemBuilder: (_, index, realIndex) {
                    return Image.network(
                      images[index],
                      fit: BoxFit.cover,
                    );
                  },
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 800),
                    viewportFraction: 1.0,
                  )),
            ),
            Align(
              alignment: const AlignmentDirectional(-1, 0),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(48, 10, 0, 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://i.imgur.com/Oi55Onm.png',
                    width: 50,
                    height: 30,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(48, 0, 48, 0),
                child: products(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget products(BuildContext context) {
    String baseUrl = "http://45.117.170.206:60/apis/file/display/";
    return BlocProvider.value(
      value: homeCubit,
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is InitHomeState || state is LoadingHomeState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ResponseHomeState) {
            final products = state.products;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 11,
                mainAxisSpacing: 11,
                // childAspectRatio: 1,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              id: product.id ?? 0,
                            ),
                          ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 8, bottom: 8, left: 10, right: 10),
                              child: Image.network(
                                baseUrl + (product.images?.first.name ?? ""),
                                width: 126,
                                height: 119,
                              ),
                            ),
                          ),
                          TitleText(
                            text: product.name ?? "",
                            size: 12,
                          ),
                          Subtitle(
                            text:
                                "${numberFormat.format(product.price?.toInt())} VND",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ));
              },
            );
          } else if (state is ErrorHomeState) {
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
}
