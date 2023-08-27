import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_store_app/bloc/cart_state.dart';
import 'package:mobile_store_app/repo/cart_repo.dart';
import 'package:mobile_store_app/screens/home_screen.dart';
import '../bloc/cart_cubit.dart';
import '../models/product.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  Product product = Product();
  String baseUrl = "http://45.117.170.206:60/apis/file/display/";
  final numberFormat = NumberFormat.decimalPattern('vi_VN');
  final addressCubit = CartCubit(CartRepository());
  final cartCubit = CartCubit(CartRepository());
  late int selectedRadio;
  late int selectedRadioTile;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
    selectedRadioTile = 0;
    _loadData();
    _loadCart();
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
    });
  }

  Future<void> _loadData() async {
    await addressCubit.fetchAddress();
  }

  Future<void> _loadCart() async {
    await cartCubit.loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        body: SafeArea(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 100),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(left: 24, right: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: const EdgeInsets.only(right: 8, bottom: 20),
                            alignment: Alignment.topRight,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                CartRepository().removeAllProduct();
                                _loadCart();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Deleted successfully!'),
                                      backgroundColor: Colors.black54,
                                      duration: Duration(seconds: 2),
                                    )
                                );
                              },
                              label: const Text(
                                "Clear cart",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                              icon: const Icon(
                                Icons.cancel,
                                size: 13,
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color.fromRGBO(218, 83, 77, 1.0)),
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.only(bottom: 13, top: 13),
                                decoration: const BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                        color: Colors.grey,
                                      )),
                                ),
                                child: showCart(context),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "Temporary price: ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.black,
                                    fontSize: 16),
                              ),
                              Text("${numberFormat.format(CartRepository().getSumPrice().toInt())} VNĐ",
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.green,
                                    fontSize: 15)
                              )
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 4,
                              ),
                              const Text("ADDRESS"),
                              const SizedBox(
                                height: 4,
                              ),
                              showAddress(context),
                              TextButton(
                                  onPressed: () {},
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    alignment: Alignment.center,
                                  ),
                                  child: const Text(
                                    "Add another address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400, fontSize: 13),
                                  )),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.only(top: 10, bottom: 10),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(bottom: 5),
                                  alignment: Alignment.bottomLeft,
                                  child: const Text("DISCOUNT"),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                        width: 240,
                                        height: 40,
                                        child: TextFormField(
                                          decoration: const InputDecoration(
                                            contentPadding:
                                            EdgeInsets.fromLTRB(10, 0, 0, 0),
                                            border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: Colors.red,
                                              ),
                                            ),
                                            prefixIcon: Icon(
                                              Icons.discount_outlined,
                                              size: 20,
                                            ),
                                            hintText: 'Enter the discount code',
                                          ),
                                        )),
                                    SizedBox(
                                      width: 95,
                                      height: 32,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                const HomePage()),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                          const Color.fromRGBO(91, 184, 93, 1),
                                        ),
                                        child: const Text("Apply"),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, 1),
                  child: Container(
                    width: double.infinity,
                    height: 100,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Align(
                      alignment: const AlignmentDirectional(0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            },
                            label: const Text("Continue Shopping"),
                            icon: const Icon(Icons.arrow_circle_left_rounded),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(91, 184, 93, 1),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: const Text("Check out"),
                            icon: const Icon(Icons.shopping_cart),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color.fromRGBO(239, 172, 78, 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )),
      )
    );
  }

  Widget showAddress(BuildContext context) {
    return BlocProvider.value(
      value: addressCubit,
      child: BlocBuilder<CartCubit, CartState> (
        builder: (context, state) {
          if (state is InitCartState || state is LoadingCartState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ResponseAddressState) {
            final addresses = state.address;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: RadioListTile(
                        title: Row(
                          children: [
                            Text(
                              address.nameReceiver ?? "",
                              style: TextStyle(color: Colors.black),
                            ),
                            Text(
                              "|",
                              style: TextStyle(color: Colors.grey),
                            ),
                            Text(
                              address.phoneReceiver ?? "",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14,
                              ),
                            )
                          ],
                        ),
                        subtitle: Text(
                          address.location ?? "",
                          style: TextStyle(color: Colors.grey),
                        ),
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                        fillColor: MaterialStateColor.resolveWith(
                                (states) => Colors.green),
                        value: index,
                        groupValue: selectedRadioTile,
                        onChanged: (val) {
                          print("Radio Tile pressed $val");
                          setSelectedRadioTile(val!);
                        },
                      ),
                    ),),
                  ],
                );
              },
            );
          } else if (state is ErrorCartState) {
            return Center(child: Text(state.message),);
          }
          return Center(child: Text(state.toString()),);
        },
      ),
    );
  }

  Widget showCart(BuildContext context) {
    return BlocProvider.value(
      value: cartCubit,
      child: BlocBuilder<CartCubit, CartState> (
        builder: (context, state) {
          if (state is InitCartState || state is LoadingCartState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is ResponseCart) {
            final cart = state.cart;
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: cart.length,
                itemBuilder: (context, index) {
                  return  Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: Image.network(
                            baseUrl + (cart[index].product?.images?[0].name ?? ""),
                            width: 98,
                            height: 68,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 24,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cart[index].product?.name ?? "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Quality: ",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        setState(() {
                                          CartRepository().addProduct(cart[index]);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        size: 14,
                                      )),
                                  Text(CartRepository().countProduct(cart[index]).toString() ?? "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15),
                                  ),
                                  IconButton(
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        setState(() {
                                          CartRepository().removeProduct(cart[index]);
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.remove,
                                        size: 14,
                                      )),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${numberFormat.format(cart[index].product?.price?.toInt())} VNĐ",
                                style: TextStyle(
                                  color: Color.fromRGBO(91, 184, 93, 1),
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                CartRepository().removeWhereProduct(cart[index]);
                                _loadCart();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                  content: Text('Deleted successfully!'),
                                  backgroundColor: Colors.black54,
                                  duration: Duration(seconds: 2),
                                )
                                );
                              });
                            },
                            icon: Icon(Icons.delete_sharp,
                              color: Colors.red,)
                        )
                      ]);
                }
            );
          } else if (state is ErrorCartState) {
            return Center(child: Text(state.message),);
          }
          return Center(child: Text(state.toString()),);
        },
      ),
    );
  }
}
