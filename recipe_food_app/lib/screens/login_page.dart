import 'package:flutter/material.dart';
import '../services/pocketbase_service.dart';
import 'recipe_list.dart'; // Importa la pagina della lista delle ricette

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PocketBaseService _pocketBaseService = PocketBaseService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;
  bool _isObscure = true; // Variabile per gestire la visibilità della password

  Future<void> _login() async {
    try {
      await _pocketBaseService.login(
        _emailController.text,
        _passwordController.text,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                RecipeList()), // Reindirizza alla lista delle ricette
      );
    } catch (e) {
      setState(() {
        _errorMessage = e.toString(); // Gestisci l'errore
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    // Cambia l'icona a seconda dello stato di _isObscure
                    _isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isObscure = !_isObscure; // Toggles the visibility
                    });
                  },
                ),
              ),
              obscureText: _isObscure, // Usa _isObscure per nascondere/mostrare
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            if (_errorMessage !=
                null) // Mostra il messaggio di errore se presente
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
