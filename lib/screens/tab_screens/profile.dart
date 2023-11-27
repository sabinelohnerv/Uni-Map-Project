import 'dart:io';
import 'package:flutter/material.dart';
import 'package:uni_map/screens/tab_screens/widgets/CardDatesProfile.dart';
import 'package:uni_map/services/profile_services.dart';
import 'package:uni_map/widgets/user_image_picker.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ProfileState();
  }
}

class _ProfileState extends State<Profile> {
  final ProfileServices _profileServices = ProfileServices();
  File? _newProfileImage;
  String? _newUsername;

  void _pickNewImage(File image) {
    setState(() {
      _newProfileImage = image;
    });
  }

  Future<void> _updateProfile() async {
    await _profileServices.updateProfile(_newProfileImage, _newUsername);
  }

  Future<void> _showDeleteConfirmationDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmación'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('¿Estás seguro de que quieres eliminar tu cuenta?'),
                Text('Esta acción es irreversible.'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () async {
                await _profileServices.deleteAccount();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _resetPassword() async {
    try {
      await _profileServices.sendPasswordResetEmail();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Correo de restablecimiento enviado. Por favor, revisa tu bandeja de entrada.'),
        ),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al enviar el correo de restablecimiento.'),
        ),
      );
    }
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

        return Scaffold(
          body: Stack(
                children: [
                  Image.asset('assets/Building/8.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(215, 90, 0, 0),
                    child: 
                    UserImagePicker(
                      onPickImage: _pickNewImage,
                      initialImage: userData['image_url'],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 70, 0, 0),
                    child: Text('Bienvenid@ \n ${userData['username']}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  
                Align(
                  alignment: Alignment.bottomCenter,
                  child: 
                  Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFF964164),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(20),
                          topLeft: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF964164),
                            blurRadius: 7,
                          ),
                        ],
                      ),
                      width: 290,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: _updateProfile,
                            icon: const Icon(
                              Icons.image_rounded,
                              size: 30,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 18),
                          IconButton(
                            onPressed: _resetPassword,
                            icon: const Icon(
                              Icons.lock,
                              size: 30,
                              color: Colors.white,
                            ),
                          
                          ),
                          const SizedBox(width: 18),
                          IconButton(
                            onPressed: _showDeleteConfirmationDialog,
                            icon: const Icon(
                              Icons.delete,
                              size: 30,
                              color: Colors.white,
                            ),
                        
                          ),
                          const SizedBox(width: 18),
                          IconButton(
                            onPressed: _profileServices.signOut,
                            icon: const Icon(
                              Icons.logout,
                              size: 30,
                              color: Colors.white,
                            ),        
                          ),
                        ],
                      ),
                    ),
                  ),


                  SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 250, 0, 0),
                        child:CardDatesProfile(_newUsername),
                    )
                  ),
            ],
          ),
        );
      },
    );
  }
}

