/*
MODELO USUARIO
*/

class UserModel {
  final String? id;
  final String? email;
  final String? fullName;
  final String? ci;
  final String? phone;

  UserModel({
    this.id,
    required this.email,
    required this.fullName,
    required this.ci,
    required this.phone,
  });

  /*MAPIAR EL DATO A FORMATO JSON*/
  toJson(){
    return {
      "full name": fullName,
      "email": email,
      "ci": ci,
      "phone": phone,
    };
  }
}