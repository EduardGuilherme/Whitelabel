import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

  Future<void> createUser() async {
    setState(() => loading = true);

    final body = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text,
      "clientId": 2, 
    };

    try {
      final response = await http.post(
        Uri.parse("http://devnology.local:3333/users"), 
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
          showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text("Sucesso!"),
            content: const Text("Usuário criado com sucesso."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // fecha o dialog
                  Navigator.pop(context); // volta para o login
                },
                child: const Text("OK"),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro: ${response.body}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Falha ao conectar: $e")),
      );
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Criar Usuário")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: "Nome"),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: "E-mail"),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: "Senha"),
              obscureText: true,
            ),
            const SizedBox(height: 20),

            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: createUser,
                    child: const Text("Cadastrar"),
                  ),
          ],
        ),
      ),
    );
  }
}
