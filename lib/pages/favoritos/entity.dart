/// Classe abstrata que deverá ser extendida por todas entidades onde for desejado
/// utilizar o BaseDAO
abstract class Entity {

  // Declaração de método para permitir que uma entidade genérica T execute
  // a conversão para map
  Map<String, dynamic> toMap();

}