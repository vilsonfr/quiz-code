//model usuario 

class Usuario {
  final String uid;
  final String nome;
  final String email;
  final String cargo;
  final int codigo;
  final String setor;
  final String createdAt;
  final String deviceType;//Tablet ou Web

  Usuario({required this.uid, required this.nome, required this.email, required this.cargo, required this.codigo, required this.setor, required this.createdAt, required this.deviceType});

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      uid: json['uid'],
      nome: json['nome'],
      email: json['email'],
      cargo: json['cargo'],
      codigo: json['codigo'],
      setor: json['setor'],
      createdAt: json['createdAt'],
      deviceType: json['deviceType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'nome': nome, 
      'email': email,
      'cargo': cargo,
      'codigo': codigo,
      'setor': setor,
      'createdAt': createdAt,
      'deviceType': deviceType,
    };
  } 
}
