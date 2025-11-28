class DevnologyProduct {
  final String nome;
  final String descricao;
  final String categoria;
  final String imagem;
  final String preco;
  final String material;
  final String departamento;

  DevnologyProduct({
    required this.nome,
    required this.descricao,
    required this.categoria,
    required this.imagem,
    required this.preco,
    required this.material,
    required this.departamento,
  });

  factory DevnologyProduct.fromJson(Map<String, dynamic> json) {
    return DevnologyProduct(
      nome: json['nome'],
      descricao: json['descricao'],
      categoria: json['categoria'],
      imagem: json['imagem'],
      preco: json['preco'],
      material: json['material'],
      departamento: json['departamento'],
    );
  }
}
