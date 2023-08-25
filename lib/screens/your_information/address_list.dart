import 'package:flutter/material.dart';
import 'package:mobile_store_app/models/address.dart';
import 'package:mobile_store_app/repo/address_repo.dart';

class AddressList extends StatefulWidget {
  const AddressList({super.key});

  @override
  State<AddressList> createState() => _AddressListState();
}

class _AddressListState extends State<AddressList> {
  List<Address> addressList = [];

  // @override
  // void initState() {
  //   super.initState();
  //   getAddressList();
  // }

  // void getAddressList() async {
  //   addressList = await AddressRepository.getAllAddresses();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        margin: const EdgeInsets.symmetric(horizontal: 9),
        color: Colors.white,
        width: double.maxFinite,
        height: 167,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "ADDRESS",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Expanded(
                child: ListView.separated(
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Do Minh Nghia | 0123456789"),
                        // "${addressList[index].nameReceiver} | ${addressList[index].phoneReceiver}"
                        const SizedBox(
                          height: 4,
                        ),
                        Text("30 PK, Ha Noi"),
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 22,
                              width: 69,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.green),
                                  color: Colors.grey[200]),
                              child: Text(
                                "Default",
                                style: TextStyle(
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 18,
                            ),
                            Container(
                              alignment: Alignment.center,
                              height: 22,
                              width: 69,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  color: Colors.grey[200]),
                              child: Text(
                                "Default",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.delete))
                      ],
                    ))
                  ],
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: 4,
              padding: EdgeInsets.symmetric(vertical: 10),
            )),
            ElevatedButton(
              onPressed: () {},
              child: Text("Add"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
            )
          ],
        ));
  }
}
