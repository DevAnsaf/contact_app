// ignore_for_file: camel_case_types

import 'package:contact_app/Models/contacts.dart';
import 'package:contact_app/Services/contactService.dart';
import 'package:flutter/material.dart';

class new_contact extends StatefulWidget {
  const new_contact({Key? key}) : super(key: key);

  @override
  State<new_contact> createState() => _new_contactState();
}

// ignore: camel_case_types
class _new_contactState extends State<new_contact> {
  var contactNameController = TextEditingController();
  var contactNumberController = TextEditingController();
  var contactInfoController = TextEditingController();
  bool _validateName = false;
  bool _validateContactNumber = false;

  // ignore: prefer_final_fields
  var _contactService = contactService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Contact'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Text(
                'Create new contact',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: contactNameController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  // ignore: prefer_const_constructors
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),

                  hintText: "Contact Name",
                  errorText: _validateName ? 'Enter Contact Name' : null,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: contactNumberController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  // ignore: prefer_const_constructors
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  hintText: "Contact Number",
                  errorText:
                      _validateContactNumber ? 'Enter Contact Number' : null,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              TextField(
                controller: contactInfoController,
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                    // ignore: prefer_const_constructors
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    hintText: "Additional Information"),
              ),
              const SizedBox(
                height: 16.0,
              ),
              Row(
                children: [
                  ElevatedButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.tealAccent,
                          backgroundColor: Colors.blueAccent,
                          textStyle: const TextStyle(fontSize: 16)),
                      onPressed: () async {
                        setState(() {
                          contactNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          contactNumberController.text.isEmpty
                              ? _validateContactNumber = true
                              : _validateContactNumber = false;
                        });
                        if (_validateName == false &&
                            _validateContactNumber == false) {
                          // print("we can save conattct");

                          var _contacts = Contacts();
                          _contacts.Name = contactNameController.text;
                          _contacts.ContactNumber =
                              contactNumberController.text;
                          _contacts.info = contactInfoController.text;
                          var result =
                              await _contactService.CreateContact(_contacts);
                          //show contacts without reload
                          Navigator.pop(context, result);
                          // print(result);
                        }
                      },
                      child: const Text("Add Contact"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
