import 'package:contact_app/Models/contacts.dart';
import 'package:contact_app/Services/contactService.dart';
import 'package:flutter/material.dart';

class EditContact extends StatefulWidget {
  final Contacts contacts;
  const EditContact({Key? key, required this.contacts}) : super(key: key);

  @override
  State<EditContact> createState() => _EditContactState();
}

class _EditContactState extends State<EditContact> {
  var contactNameController = TextEditingController();
  var contactNumberController = TextEditingController();
  var contactInfoController = TextEditingController();
  bool _validateName = false;
  bool _validateContactNumber = false;
  var _contactService = contactService();

  @override
  void initState() {
    setState(() {
      contactNameController.text = widget.contacts.Name ?? '';
      contactNumberController.text = widget.contacts.ContactNumber ?? '';
      contactInfoController.text = widget.contacts.info ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Contact'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [
              const Text(
                'Update contact',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.deepOrange,
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
                  TextButton(
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.deepOrange,
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
                          _contacts.id = widget.contacts.id;
                          _contacts.Name = contactNameController.text;
                          _contacts.ContactNumber =
                              contactNumberController.text;
                          _contacts.info = contactInfoController.text;
                          var result =
                              await _contactService.EditContact(_contacts);
                          //show contacts without reload
                          Navigator.pop(context, result);
                          // print(result);
                        }
                      },
                      child: const Text("Update"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
