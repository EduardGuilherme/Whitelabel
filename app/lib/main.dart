import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../modules/services/auth_service.dart';
import '../../modules/pages/login_page.dart';
import '../../modules/pages/products_page.dart'; 
import '../../../theme/app_themes.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // 🔥 Aqui está o whitelabel funcionando
      theme: _selectTheme(auth.currentDomain),

      initialRoute: "/",
      routes: {
        "/": (context) => const LoginPage(),
        "/products": (context) => ProductsPage(),
      },
    );
  }

  /// Função para escolher o tema certo baseado no domínio
  ThemeData _selectTheme(String? domain) {
    if (domain == "devnology.local") {
      return AppThemes.devnology; // correto → acesso estático
    }

    if (domain == "in8.local") {
      return AppThemes.in8; // correto → acesso estático
    }

    // Tema default
    return ThemeData(
      primarySwatch: Colors.blue,
    );
  }
}