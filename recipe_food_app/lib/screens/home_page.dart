import 'package:flutter/material.dart';
import 'recipe_list.dart'; // Importa la schermata della lista delle ricette
import 'login_page.dart'; // Importa la pagina di login
import '../services/pocketbase_service.dart'; // Importa il servizio PocketBaseService

class HomePage extends StatelessWidget {
  final PocketBaseService _pocketBaseService =
      PocketBaseService(); // Crea un'istanza del servizio

  HomePage({super.key});

  // Funzione per controllare se l'utente è autenticato
  bool _isLoggedIn() {
    return _pocketBaseService
        .pb.authStore.isValid; // Restituisce true se l'utente è autenticato
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Sfondo con immagine
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/foods.jpg'),
              ),
            ),
          ),
          // Posiziona gli elementi sulla pagina
          Positioned(
            top: MediaQuery.of(context).viewInsets.top + kToolbarHeight,
            left: 0,
            right: 0,
            bottom: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Titolo "Benvenuto!"
                    const Text(
                      'Benvenuto!',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ), // Spazio tra le due sezioni
                    Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Sottotitolo che introduce la lista
                            const Text(
                              'Ecco la lista delle tue ricette:',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 40),
                            // Bottone per navigare alla lista delle ricette
                            ElevatedButton(
                              onPressed: () {
                                // Controlla se l'utente è autenticato
                                if (_isLoggedIn()) {
                                  // Naviga alla pagina della lista delle ricette
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => RecipeList(),
                                    ),
                                  );
                                } else {
                                  // Naviga alla pagina di login
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orangeAccent,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text(
                                'Vai alla Lista delle Ricette',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
