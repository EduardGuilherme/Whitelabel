import 'package:app/core/http/http_client.dart';
import 'package:app/modules/pages/create_user_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  String selectedDomain = "devnology.local";

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Selecione o Cliente:",
                style: TextStyle(fontWeight: FontWeight.bold)),

            // 🔥 Dropdown agora no lugar certo
            DropdownButton<String>(
              value: selectedDomain,
              items: const [
                DropdownMenuItem(
                  value: "devnology.local",
                  child: Text("Devnology"),
                ),
                DropdownMenuItem(
                  value: "in8.local",
                  child: Text("IN8"),
                ),
              ],
              onChanged: (value) {
                setState(() => selectedDomain = value!);
              },
            ),

            const SizedBox(height: 20),

            TextField(
              controller: emailCtrl,
              decoration: const InputDecoration(labelText: "Email"),
            ),

            TextField(
              controller: passCtrl,
              decoration: const InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                // Troca o domínio da API antes de logar 🔥
                HttpClient.changeBaseUrl(selectedDomain);

                final ok = await context
                    .read<AuthService>()
                    .login(emailCtrl.text, passCtrl.text,selectedDomain);

                if (ok) {
                  Navigator.of(context).pushReplacementNamed("/products");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Login inválido"),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text("Entrar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CreateUserPage()),
                );
              },
              child: const Text("Criar Usuário"),
            ),
          ],
        ),
      ),
    );
  }
}
