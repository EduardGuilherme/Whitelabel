import 'package:app/core/http/http_client.dart';
import 'package:app/modules/models/devnology.dart';
import 'package:app/modules/models/in8.dart';

class ProductsService {
  static Future<List<dynamic>> fetchProducts(String domain) async {
    final resp = await HttpClient.dio.get("/products");

    final data = resp.data as List;

    if (domain == "devnology.local") {
      return data.map((e) => DevnologyProduct.fromJson(e)).toList();
    }

    if (domain == "in8.local") {
      return data.map((e) => In8Product.fromJson(e)).toList();
    }

    throw Exception("Host desconhecido");
  }
}