import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uni_map/services/profile_services.dart';

class CardDatesProfile extends StatefulWidget {
  const CardDatesProfile(String? newUsername, {super.key});

  @override
  State<CardDatesProfile> createState() => _CardDatesProfileState();
}

class _CardDatesProfileState extends State<CardDatesProfile> {
  final ProfileServices _profileServices = ProfileServices();
  String? _newUsername;
  File? _newProfileImage;


  Future<void> _updateProfile() async {
    await _profileServices.updateProfile(_newProfileImage, _newUsername);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>?>(
      future: _profileServices.getUserData(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.data == null) {
          return const Center(
            child: Text("No se encontró el usuario"),
          );
        }

        final userData = snapshot.data!;
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF964164) ,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF964164),
                blurRadius: 7,
              ),
            ],
          ),
          width: 280,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.home_work_rounded,
                        color: Colors.grey,
                        size: 17,
                      ),
                      SizedBox(width: 10),
                      Text(
                      'Sede:',
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        )
                      ),
                    ],
                  ), 
                  const SizedBox(height: 7),
                  const Text('       "Santa Cruz"',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    )
                  ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(
                      Icons.mark_email_read_rounded,
                      color: Colors.grey,
                      size: 17,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Correo:',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      )
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  '        ${userData['email'] ?? 'No email'}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 16,
                      color: Colors.white,
                    ),
                ),
                const SizedBox(height: 8),
                Container(
                  height: 1,
                  color: Colors.grey,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                ),
                TextFormField(
                  initialValue: userData['username'],
                  decoration:
                    const InputDecoration(
                      labelText: 'Nombre de usuario',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                      ),  
                    ),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  onChanged: (value) {
                    _newUsername = value;
                  },
                ),
                const SizedBox(height: 15),
                
                Center(
                  child: TextButton(
                    onPressed: _updateProfile,
                    child: const Text(
                      'Actualizar Usuario',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}