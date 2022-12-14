import 'package:contact_app/Models/contacts.dart';
import 'package:flutter/material.dart';

class ViewContact extends StatefulWidget {
  final Contacts contacts;
  const ViewContact({Key? key, required this.contacts}) : super(key: key);

  @override
  State<ViewContact> createState() => _ViewContactState();
}

class _ViewContactState extends State<ViewContact> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contents Buddy"),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            const Text(
              "Contact Details",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.deepOrange,
                  fontSize: 25),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Contact Name',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                      fontSize: 20),
                ),
                Text(
                  widget.contacts.Name ?? '',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Contact Number',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                      fontSize: 20),
                ),
                Text(
                  widget.contacts.ContactNumber ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                )
              ],
            ),
            const SizedBox(
              height: 18,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Information',
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple,
                      fontSize: 20),
                ),
                Text(
                  widget.contacts.info ?? '',
                  style: const TextStyle(color: Colors.black, fontSize: 20),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
