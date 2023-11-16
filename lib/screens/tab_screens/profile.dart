import 'dart:io';
import 'package:flutter/material.dart';
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

        return Center(
          child: SingleChildScrollView(
            child: Card(
              margin: const EdgeInsets.all(20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(
                    color: Color.fromARGB(255, 117, 13, 54), width: 2.0),
              ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      UserImagePicker(
                        onPickImage: _pickNewImage,
                        initialImage: userData['image_url'],
                      ),
                      Text(
                        userData['email'] ?? 'No email',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        initialValue: userData['username'],
                        decoration: const InputDecoration(
                            labelText: 'Nombre de usuario'),
                        onChanged: (value) {
                          _newUsername = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: _updateProfile,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: const Text('Actualizar Perfil'),
                        ),
                      ),
                      const SizedBox(height: 4),
                      SizedBox(
                        width: 150,
                        child: ElevatedButton(
                          onPressed: _profileServices.signOut,
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                          ),
                          child: const Text('Cerrar Sesión'),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          TextButton(
                            onPressed: _resetPassword,
                            child: const Text('Restablecer Contraseña'),
                          ),
                          TextButton(
                            onPressed: _showDeleteConfirmationDialog,
                            child: const Text('Eliminar Cuenta'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
        );
      },
    );
  }
}
