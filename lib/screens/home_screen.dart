import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store_app/screens/search/search_bar.dart';
import 'package:mobile_store_app/widget/bottom_navigation.dart';
import 'package:mobile_store_app/widget/text_format/subtitle_text.dart';
import 'package:mobile_store_app/widget/text_format/title_text.dart';
import 'package:mobile_store_app/screens/detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                child: GridView(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 11,
                    mainAxisSpacing: 11,
                    // childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Image.network(
                                  'https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png',
                                  width: 126,
                                  height: 119,
                                ),
                              ),
                            ),
                          ),
                          TitleText(
                            text: "Name Product",
                            size: 12,
                          ),
                          Subtitle(
                            text: "Price",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Image.network(
                                  'https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png',
                                  width: 126,
                                  height: 119,
                                ),
                              ),
                            ),
                          ),
                          TitleText(
                            text: "Name Product",
                            size: 12,
                          ),
                          Subtitle(
                            text: "Price",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Image.network(
                                  'https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png',
                                  width: 126,
                                  height: 119,
                                ),
                              ),
                            ),
                          ),
                          TitleText(
                            text: "Name Product",
                            size: 12,
                          ),
                          Subtitle(
                            text: "Price",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Image.network(
                                  'https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png',
                                  width: 126,
                                  height: 119,
                                ),
                              ),
                            ),
                          ),
                          TitleText(
                            text: "Name Product",
                            size: 12,
                          ),
                          Subtitle(
                            text: "Price",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Image.network(
                                  'https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png',
                                  width: 126,
                                  height: 119,
                                ),
                              ),
                            ),
                          ),
                          TitleText(
                            text: "Name Product",
                            size: 12,
                          ),
                          Subtitle(
                            text: "Price",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Image.network(
                                  'https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png',
                                  width: 126,
                                  height: 119,
                                ),
                              ),
                            ),
                          ),
                          TitleText(
                            text: "Name Product",
                            size: 12,
                          ),
                          Subtitle(
                            text: "Price",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Image.network(
                                  'https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png',
                                  width: 126,
                                  height: 119,
                                ),
                              ),
                            ),
                          ),
                          TitleText(
                            text: "Name Product",
                            size: 12,
                          ),
                          Subtitle(
                            text: "Price",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.grey,
                          )),
                      child: Column(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const DetailScreen()),
                                );
                              },
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 8, bottom: 8, left: 10, right: 10),
                                child: Image.network(
                                  'https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png',
                                  width: 126,
                                  height: 119,
                                ),
                              ),
                            ),
                          ),
                          TitleText(
                            text: "Name Product",
                            size: 12,
                          ),
                          Subtitle(
                            text: "Price",
                            size: 15,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
