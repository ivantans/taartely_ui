import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:taartely_ui/pages/buyer_component/contact/add_contact_page.dart';
import 'package:taartely_ui/pages/buyer_component/contact/edit_contact_page.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  String baseUrl = dotenv.env["BASE_URL"] ?? "";
  late Future<List<Contact>> _contactsFuture;

  @override
  void initState() {
    super.initState();
    _contactsFuture = _loadContacts();
  }

  Future<List<Contact>> _loadContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/contacts');
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'];
        return data.map((json) => Contact.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load contacts: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to load contacts: $e');
      throw Exception('Failed to load contacts');
    }
  }

  Future<void> _deleteContact(int contactId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');

    final url = Uri.parse('$baseUrl/contacts/$contactId');
    try {
      final response = await http.delete(
        url,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 204) {
        print('Contact deleted successfully');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Contact deleted successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        _refreshContacts(); // Refresh contacts
      } else {
        var responseData = json.decode(response.body);
        print('Failed to delete contact: ${responseData['message']}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to delete contact: ${responseData['message']}'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Failed to delete contact: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete contact: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _refreshContacts() {
    setState(() {
      _contactsFuture = _loadContacts();
    });
  }

  Future<void> _navigateToAddContact(BuildContext context) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return AddContactPage();
    }));
    _refreshContacts(); // Refresh contacts
  }

  Future<void> _navigateToEditContact(BuildContext context, Contact contact) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return EditContactPage(contact: contact);
    }));
    _refreshContacts(); // Refresh contacts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contacts"),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _navigateToAddContact(context),
            child: Text('Create New Contact'),
          ),
          Expanded(
            child: FutureBuilder<List<Contact>>(
              future: _contactsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load contacts'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No contacts found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Contact contact = snapshot.data![index];
                      return ListTile(
                        title: Text('Address: ${contact.userAddress}'),
                        subtitle: Text('Phone: ${contact.userPhoneNumber}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _navigateToEditContact(context, contact),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red),
                              onPressed: () => _deleteContact(contact.id),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Contact {
  final int id;
  final String userAddress;
  final String userPhoneNumber;

  Contact({
    required this.id,
    required this.userAddress,
    required this.userPhoneNumber,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      userAddress: json['user_address'],
      userPhoneNumber: json['user_phone_number'],
    );
  }
}
