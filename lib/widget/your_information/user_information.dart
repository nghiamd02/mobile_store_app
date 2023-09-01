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
  final _passwordFormKey = GlobalKey<FormState>();
  String newPassword = "";
  String? oldPassword = "";

  @override
  void initState() {
    super.initState();
    _userFuture = setUserData();
  }

  void showMessageDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
                onPressed: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
                child: const Text("Close"))
          ],
        );
      },
    );
  }

  Future<bool> setUserData() async {
    await _userRepository.setCurrentUser();
    _currentUser = _userRepository.currentUser;

    oldPassword = await _userRepository.getUserPassword();
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
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }

  void _onSubmitEditForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_currentUser);

      _userRepository.updateUser(_currentUser!);
      showMessageDialog("Edit successfully");
    } else {
      print("Not pass validate");
    }
  }

  void showEditUserInforDialog() {
    String? dob = _currentUser!["birthDay"];
    showDialog(
      context: context,
      builder: (context) {
        dob = _currentUser!["birthDay"];
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                height: 460,
                child: Column(
                  children: [
                    const Text(
                      "Edit Information",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                        child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            TextFormField(
                              initialValue: _currentUser!['email'],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                label: Text("Email"),
                              ),
                              validator: (value) {
                                final RegExp emailRegExp = RegExp(
                                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                                );
                                if (value == null || value.isEmpty) {
                                  return "Needs to fill";
                                }
                                if (emailRegExp.hasMatch(value) == false) {
                                  return "Invalid email";
                                }
                                return null;
                              },
                              onSaved: (newValue) {
                                _currentUser!["email"] = newValue;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
                              key: Key(dob!),
                              // enabled: false,
                              keyboardType: TextInputType.none,
                              initialValue: dob,
                              decoration: InputDecoration(
                                  label: const Text("Date of Birth"),
                                  border: const OutlineInputBorder(),
                                  suffixIcon: IconButton(
                                    icon: const Icon(
                                        Icons.calendar_month_outlined),
                                    onPressed: () async {
                                      DateTime? result = await showDatePicker(
                                          context: context,
                                          initialDate: DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime.now());
                                      if (result != null) {
                                        String selectedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(result);
                                        setState(
                                          () {
                                            dob = selectedDate;
                                          },
                                        );
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
                              onSaved: (newValue) {
                                phoneNumber = newValue;
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
                                items: List.generate(2, (index) {
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
                                  }

                                  return DropdownMenuItem(
                                      value: index, child: Text(content));
                                }),
                                onChanged: (value) {
                                  _currentUser!["gender"] = value;
                                }),
                            ButtonBar(
                              children: [
                                ElevatedButton(
                                  onPressed: _onSubmitEditForm,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.green),
                                  child: const Text("Save"),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.red),
                                  child: const Text("Cancel"),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _onSubmitChangePassword() async {
    if (_passwordFormKey.currentState!.validate()) {
      Future<int> passwordChangeFuture =
          _userRepository.changePassword(oldPassword!, newPassword);
      int statusCode = await passwordChangeFuture;

      if (statusCode == 200) {
        _passwordFormKey.currentState!.save();

        showMessageDialog("Change successfully");
      } else {
        showMessageDialog("Failed to change your password");
      }
    } else {
      print("failed");
    }
  }

  void showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            height: 350,
            child: Column(
              children: [
                const Text(
                  "Change Password",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: SingleChildScrollView(
                  child: Form(
                    key: _passwordFormKey,
                    child: Column(children: [
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Old Password")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Needs to fill";
                          }

                          if (value != oldPassword) {
                            return "Invalid password";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("New Password")),
                        validator: (value) {
                          final RegExp passwordRegExp = RegExp(
                            r'^(?=.*[A-Z])(?=.*[0-9])(.{8,})$',
                          );
                          if (value == null || value.isEmpty) {
                            return "Needs to fill";
                          }
                          if (!passwordRegExp.hasMatch(value)) {
                            return "Must have at least 8 chars, 1 cap letter and 1 digit";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          newPassword = value;
                        },
                        onSaved: (newValue) {
                          oldPassword = newValue;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            label: Text("Confirm New Password")),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Needs to fill";
                          }
                          if (value != newPassword) {
                            return "Wrong value";
                          }
                          return null;
                        },
                      ),
                      ButtonBar(
                        children: [
                          ElevatedButton(
                            onPressed: _onSubmitChangePassword,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green),
                            child: const Text("Save"),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red),
                            child: const Text("Cancel"),
                          )
                        ],
                      ),
                    ]),
                  ),
                ))
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
                        onPressed: showEditUserInforDialog,
                        color: Colors.blue,
                      ),
                    )
                  ],
                ),
                // inforRow(context,
                //     icon: Icons.phone,
                //     text: phoneNumber == null ? "Need fill" : "$phoneNumber"),
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
                      onPressed: showChangePasswordDialog,
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
