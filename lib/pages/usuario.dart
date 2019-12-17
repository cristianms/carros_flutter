class Usuario {
  String login;
  String nome;
  String email;
  String token;
  List<String> roles;

//  Usuario(Map<String, dynamic> map) {
//    login = map['login'];
//    nome = map['nome'];
//    email = map['email'];
//    token = map['token'];
//  }

  Usuario.fromJson(Map<String, dynamic> map)
      :
        login = map['login'],
        nome = map['nome'],
        email = map['email'],
        token = map['token'],
        roles = map['roles'] != null
            ? map['roles'].map<String>((role) => role.toString()).toList()
            : null;

  @override
  String toString() {
    return 'Usuario{login: $login, nome: $nome, email: $email, token: $token, roles: $roles}';
  }

//  static List<String> getRoles(Map<String, dynamic> map) {
//    List list = map['roles'];
//    List<String> roles = list.map<String>((role) => role.toString()).toList();
//    return roles;
//  }
}