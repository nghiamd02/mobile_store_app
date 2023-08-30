import 'package:flutter/material.dart';
import 'package:mobile_store_app/repo/user_repo.dart';

import 'package:intl/intl.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  Future<bool>? _userFuture;
  Map<String, dynamic>? _currentUser;
  final UserRepository _userRepository = UserRepository();
  String? phoneNumber;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _userFuture = setUserData();
  }

  Future<bool> setUserData() async {
    await _userRepository.setCurrentUser();
    _currentUser = _userRepository.currentUser;
    return true;
  }

  Row inforRow(BuildContext context,
      {required IconData icon, required String text}) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.green,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.bodyMedium,
          overflow: TextOverflow.ellipsis,
        )
      ],
    );
  }

  void _onSubmitEditForm() {
    if (_formKey.currentState!.validate()) {
      print("Pass validate");
    } else {
      print("Not pass validate");
    }
  }

  void showEditUserInforDialog() {
    TextEditingController dobController = TextEditingController();
    dobController.text = _currentUser!["birthDay"];
    DateTime? result;
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            height: 400,
            child: Column(
              children: [
                const Text(
                  "Edit Information",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(child: StatefulBuilder(
                  builder: (context, setState) {
                    print("Rebuild form");
                    return Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: _currentUser!["fullName"],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Full Name"),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Needs to fill";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _currentUser!["fullName"] = newValue;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              initialValue: dobController.text,
                              decoration: InputDecoration(
                                  label: const Text("Date Of Birth"),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                        Icons.calendar_month_outlined),
                                    onPressed: () async {
                                      result = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now());
                                      if (result != null) {
                                        setState(() {
                                          dobController.text =
                                              DateFormat.yMd().format(result!);
                                        });
                                      }
                                    },
                                  )),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Needs to fill";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _currentUser!["birthDay"] = newValue;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                label: Text("Phone Number"),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Needs to fill";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    label: Text("Gender")),
                                value: _currentUser!["gender"],
                                items: List.generate(3, (index) {
                                  String content = "";
                                  switch (index) {
                                    case 0:
                                      {
                                        content = "male";
                                      }
                                      break;
                                    case 1:
                                      {
                                        content = "female";
                                      }
                                      break;
                                    case 2:
                                      {
                                        content = "other";
                                      }
                                      break;
                                  }

                                  return DropdownMenuItem(
                                      value: index, child: Text(content));
                                }),
                                onChanged: (value) {}),
                            ButtonBar(
                              children: [
                                ElevatedButton(
                                  onPressed: _onSubmitEditForm,
                                  child: Text("Save"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Text("Cancel"),
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 6),
            margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 9),
            width: double.maxFinite,
            height: 155,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "INFORMATION",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    SizedBox(
                      height: 30,
                      child: IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: _onSubmitEditForm,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                inforRow(context,
                    icon: Icons.phone,
                    text: phoneNumber == null ? "Need fill" : "$phoneNumber"),
                Row(
                  children: [
                    Expanded(
                        child: inforRow(context,
                            icon: Icons.person,
                            text: _currentUser!["fullName"])),
                    Expanded(
                        child: inforRow(context,
                            icon: Icons.male,
                            text: _currentUser!["gender"] == 0
                                ? "male"
                                : "female")),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: inforRow(context,
                            icon: Icons.calendar_month,
                            text: _currentUser!["birthDay"])),
                    Expanded(
                        child: inforRow(context,
                            icon: Icons.email, text: _currentUser!["email"])),
                  ],
                ),
                ButtonTheme(
                    height: 20,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.blue[400]),
                      child: const Text(
                        "Change password",
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      onPressed: () {},
                    ))
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
