import "package:test/test.dart";

void main() {
  //////////////////////////////////////////////////////////////////////////////////////////////////

  test("Lazy vs Eager", () {
    var lazyCounter = 0;
    var eagerCounter = 0;

    var lazy = [1, 2, 3, 4, 5, 6, 7].where((i) {
      lazyCounter++;
      return i % 2 == 0;
    });

    var eager = [1, 2, 3, 4, 5, 6, 7].where((i) {
      eagerCounter++;
      return i % 2 == 0;
    }).toList();

    print("\n\n---------- init ----------\n\n");

    lazy.length;
    lazy.length;
    lazy.length;

    eager.length;
    eager.length;
    eager.length;

    print("\n\n---------- Lazy vs Eager ----------\n\n");

    // 1) Roda 3x um objeto lazy => 3 avaliações = 3N+
    // (Modo Debug pode levar a valores diferentes, o que importa é que é maior)
    print("Lazy: $lazyCounter");
    // 2) O objeto já foi contruído e não precisa ser avaliado novamento => N
    print("Eager: $eagerCounter");

    print("\n\n---------- FIM ----------\n\n");
  });

  //////////////////////////////////////////////////////////////////////////////////////////////

  int eagerCounter = 0;
  int lazyCounter = 0;

  List<int> removeImpares_eager(Iterable<int> source) {
    return source.where((i) {
      eagerCounter++;
      print("removeImpares_eager");
      return i % 2 == 0;
    }).toList();
  }

  List<int> removeMenoresQue10_eager(Iterable<int> source) {
    return source.where((i) {
      eagerCounter++;
      print("removeMenoresQue10_eager");
      return i >= 10;
    }).toList();
  }

  Iterable<int> removeImpares_lazy(Iterable<int> source) {
    return source.where((i) {
      print("removeImpares_lazy");
      lazyCounter++;
      return i % 2 == 0;
    });
  }

  Iterable<int> removeMenoresQue10_lazy(Iterable<int> source) {
    return source.where((i) {
      print("removeMenoresQue10_lazy");
      lazyCounter++;
      return i >= 10;
    });
  }

  test("Ordem de Avaliação", () {
    var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

    print("\n\n---------- init ----------\n\n");

    Iterable<int> eager = removeMenoresQue10_eager(removeImpares_eager(list));

    Iterable<int> lazy = removeMenoresQue10_lazy(removeImpares_lazy(list));

    print("\n\n---------- lazy ----------\n\n");
    print(lazy);

    print("\n\n---------- eager ----------\n\n");
    print(eager);

    print("\n\n---------- FIM ----------\n\n");

    print(lazyCounter);

    print(eagerCounter);
  });

  //////////////////////////////////////////////////////////////////////////////////////////////////
}
