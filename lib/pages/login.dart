import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'package:url_launcher/url_launcher.dart';

import '../components/CustomButton.dart';
import './tela_principal.dart';
import '../store.dart';

class Login extends StatefulWidget {
  final UserStore userStore = UserStore();

  final Map<String, String> usuarios = {
    'user1': 'password1',
    'user2': 'password2',
  };

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E4E62),
              Color(0xFF21606F),
              Color(0xFF267177),
              Color(0xFF26797D),
              Color(0xFF2A8485),
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTextField(
                  labelText: 'Usuário',
                  prefixIcon: Icons.person,
                  onChanged: widget.userStore.setLogin,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  labelText: 'Senha',
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  onChanged: widget.userStore.setPassword,
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: CustomButton(
                    text: "Entrar",
                    width: 235,
                    textColor: Colors.white,
                    color: Color(0xFF44BD6E),
                    onPressed: () {
                      if (validateLogin()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TelaDeCaptura()),
                        );
                      } else {
                        // Login falhou
                        print('Login falhou');
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                    onPressed: () async {
                      final url = Uri.parse('https://google.com');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        print('Falha ao acessar');
                      }
                    },
                    child: Text(
                      'Política de Privacidade',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontFamily: 'Roboto'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required IconData prefixIcon,
    bool obscureText = false,
    required ValueChanged<String> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            labelText,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Container(
          width: 300,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: TextField(
            onChanged: onChanged,
            obscureText: obscureText,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              prefixIcon: Icon(prefixIcon),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }

  bool validateLogin() {
    String user = widget.userStore.login;
    String pass = widget.userStore.password;
    return widget.usuarios.containsKey(user) && widget.usuarios[user] == pass;
  }
}
