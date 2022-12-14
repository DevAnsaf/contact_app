import 'package:contact_app/Models/contacts.dart';
import 'package:contact_app/db_connect/repository.dart';

// ignore: camel_case_types
class contactService {
  late Repository _repository;
  contactService() {
    _repository = Repository();
  }

  //Save or Create Contact
  // ignore: non_constant_identifier_names
  CreateContact(Contacts contacts) async {
    return await _repository.insertData("contacts", contacts.userMap());
  }

  //Read contacts
  readContacts() async {
    return await _repository.readData('contacts');
  }

  //edit contact method
  EditContact(Contacts contacts) async {
    return await _repository.updateData('contacts', contacts.userMap());
  }

  deleteContact(contactId) async {
    return await _repository.deleteDataById('contacts', contactId);
  }
}
