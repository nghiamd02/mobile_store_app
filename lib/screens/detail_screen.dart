import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_store_app/widget/text_format/detail_text.dart';
import 'package:mobile_store_app/widget/text_format/subtitle_text.dart';
import 'package:mobile_store_app/widget/text_format/title_text.dart';
import 'package:mobile_store_app/screens/cart_screen.dart';

class DetailScreen extends StatefulWidget{
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int selectedIndex = 0;

  int gottenStars = 3;

  List images = [
    "https://i.imgur.com/6Qz6iwd.png",
    "https://i.imgur.com/6Qz6iwd.png",
    "https://i.imgur.com/6Qz6iwd.png",
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              //PageView
              Container(
                padding: EdgeInsets.only(top: 20, bottom: 10),
                width: double.infinity,
                height: 200,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    ClipRRect(
                      child: Image.network(
                        'https://i.imgur.com/6Qz6iwd.png',
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    ClipRRect(
                      child: Image.network(
                        'https://i.imgur.com/6Qz6iwd.png',
                        width: 300,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
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
                            child: Text("Product Name", style: TextStyle(
                              fontSize: 20,
                            ),),
                          ),
                          Row(
                            children: [
                              Text ("3.0", style: TextStyle(
                                color: Color.fromRGBO(254, 140, 35, 1),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              )),
                              SizedBox(width: 5,),
                              Wrap(
                                children: List.generate(5, (index) {
                                  return index < gottenStars ?
                                  Icon(Icons.star, color:Color.fromRGBO(254, 140, 35, 1),
                                    size: 15,) :
                                  Icon(Icons.star_border, color:Color.fromRGBO(254, 140, 35, 1),
                                    size: 15,);
                                }),
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                  Container(
                    padding: EdgeInsets.only(top:10, left: 20, right: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: List.generate(3, (index) => itemButtonChoose(context, index)),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top:10, left: 20, right: 20),
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
                            child: Text("128 GB", style: TextStyle(color: Colors.grey),),
                          ),
                        ),
                        SizedBox(width: 10,),
                        SizedBox(
                          width: 60,
                          height: 30,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text("128 GB", style: TextStyle(color: Colors.grey),),
                          ),
                        ),
                        SizedBox(width: 10,),
                        SizedBox(
                          width: 60,
                          height: 30,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Text("128 GB", style: TextStyle(color: Colors.grey),),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: EdgeInsets.only(top: 10, left: 20, right: 20),
                    child: Text("475 USD", style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w700,
                    ),),
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
                            MaterialPageRoute(builder: (context) => const CartScreen()),
                          );
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
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("SPECIFICATIONS", style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                            child: Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  height: 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Screen:"),
                                        Text("IPS LCD6.56'HD+")
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Screen:"),
                                        Text("IPS LCD6.56'HD+")
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Screen:"),
                                        Text("IPS LCD6.56'HD+")
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Screen:"),
                                        Text("IPS LCD6.56'HD+")
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 30,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(0, 0, 0, 0.2),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Screen:"),
                                        Text("IPS LCD6.56'HD+")
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: Container(
                                    padding: EdgeInsets.only(top: 10, bottom: 10),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text("Screen:"),
                                        Text("IPS LCD6.56'HD+")
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text("See more detailed configuration",
                                  style: TextStyle(
                                      color: Color.fromRGBO(91, 184, 93, 1)
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
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
              //Product Information
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("PRODUCT INFORMATION", style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                            child: const Text("OPPO has added to the low-cost OPPO a lineup a new device called OPPO A57... product detail...",
                              textAlign: TextAlign.justify,),
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {},
                                child: Text("See more",
                                  style: TextStyle(
                                      color: Color.fromRGBO(91, 184, 93, 1)
                                  ),
                                ),
                                style: OutlinedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    side: BorderSide(
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
                padding: EdgeInsets.all(5),
                child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Text("REVIEW OF CUSTOMER BOUGHT THE PRODUCT", style: TextStyle(
                                fontWeight: FontWeight.w700
                            ),),
                          ),
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
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
                                    DetailText(text: "Customer Name"),
                                    SizedBox(width: 10,),
                                    Wrap(
                                      children: List.generate(5, (index) {
                                        return index < gottenStars ?
                                        Icon(Icons.star, color:Color.fromRGBO(254, 140, 35, 1),
                                          size: 15,) :
                                        Icon(Icons.star_border, color:Color.fromRGBO(254, 140, 35, 1),
                                          size: 15,);
                                      }),
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: DetailText(text: "Customer review",),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                ),
              ),
              //Another Product
              Padding(
                  padding: EdgeInsets.all(5),
                child: Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 10),
                            child: TitleText(text: "ANOTHER PRODUCT", size: 14,)
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      DetailText(text: "Product Name", size: 15,),
                                      Image.network("https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png",
                                        height: 150,
                                        width: 130,),
                                      Subtitle(text: "Price")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      DetailText(text: "Product Name", size: 15,),
                                      Image.network("https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png",
                                        height: 150,
                                        width: 130,),
                                      Subtitle(text: "Price")
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      DetailText(text: "Product Name", size: 15,),
                                      Image.network("https://cdn2.cellphones.com.vn/358x358,webp,q100/media/catalog/product/t/_/t_m_12.png",
                                        height: 150,
                                        width: 130,),
                                      Subtitle(text: "Price")
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                ),
              ),
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
          onTap: (){
            setState(() {
              selectedIndex = index;
            });
          },
          child:  SizedBox(
            width: 60,
            height: 30,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: (selectedIndex == index)
                    ? Colors.green : Colors.grey),
              ),
              child: Text("128 GB", style: TextStyle(color: (selectedIndex == index)
                  ? Colors.green : Colors.grey),),
            ),
          ),
        ),
    );
  }
}