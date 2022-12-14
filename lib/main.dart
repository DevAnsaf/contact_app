import 'package:contact_app/Services/contactService.dart';
import 'package:contact_app/Views/editContact.dart';
import 'package:contact_app/Views/new_contact.dart';
import 'package:contact_app/Views/viewContact.dart';
import 'package:flutter/material.dart';

import 'Models/contacts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contents Buddy',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Contacts> _contactsList;
  final _contactService = contactService();

  getContactDetails() async {
    var contacts = await _contactService.readContacts();
    _contactsList = <Contacts>[];

    contacts.forEach((contacts) {
      setState(() {
        var contactModel = Contacts();
        contactModel.id = contacts['id'];
        contactModel.Name = contacts['Name'];
        contactModel.ContactNumber = contacts['ContactNumber'];
        contactModel.info = contacts['info'];
        _contactsList.add(contactModel);
      });
    });
  }

  @override
  void initState() {
    getContactDetails();
    // TODO: implement initState
    super.initState();
  }

  _deleteContact(BuildContext context, contactId) {
    return showDialog(
        context: context,
        builder: (parameter) {
          return AlertDialog(
            title: const Text('Do You Want to Delete?'),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.pink),
                  onPressed: () async {
                    var result = await _contactService.deleteContact(contactId);

                    if (result != null) {
                      Navigator.pop(context);
                      getContactDetails();
                      // _showSuccessSnackBar('User Detail Added Success');
                    }
                  },
                  child: const Text(
                    'Remove',
                  )),
              TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.deepOrange),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close_outlined,
                  color: Colors.black,
                  size: 20,
                ),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text("Contents Buddy"),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: _contactsList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewContact(
                                contacts: _contactsList[index],
                              )));
                },
                leading: const Icon(
                  Icons.account_circle_sharp,
                  color: Colors.blueAccent,
                  size: 45,
                ),
                title: Text(
                  _contactsList[index].Name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  _contactsList[index].ContactNumber ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    //edit button
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditContact(
                                        contacts: _contactsList[index],
                                      ))).then((data) {
                            if (data != null) {
                              getContactDetails();
                              // _showSuccessSnackBar('User Detail Added Success');
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.published_with_changes,
                          color: Colors.orange,
                          size: 30,
                        )),
                    //delete button
                    IconButton(
                        onPressed: () {
                          _deleteContact(context, _contactsList[index].id);
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.redAccent,
                          size: 35,
                        ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => new_contact()))
              .then((data) {
            if (data != null) {
              getContactDetails();
              // _showSuccessSnackBar('User Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
