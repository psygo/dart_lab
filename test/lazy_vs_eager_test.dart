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

    print("\n\n---------- Init ----------\n\n");

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

  //////////////////////////////////////////////////////////////////////////////////////////////////

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

  test("Ordem de avaliação", () {
    var list = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15];

    print("\n\n---------- Init ----------\n\n");

    Iterable<int> eager = removeMenoresQue10_eager(removeImpares_eager(list));

    Iterable<int> lazy = removeMenoresQue10_lazy(removeImpares_lazy(list));

    print("\n\n---------- Lazy ----------\n\n");

    // Note que, para Iterables, Dart imprime com `()`; e, para List, com `[]`.
    print(lazy);

    print("\n\n---------- Eager ----------\n\n");

    print(eager);

    print("\n\n---------- Contadores ----------\n\n");

    print("Lazy: $lazyCounter");
    print("Eager: $eagerCounter");

    print("\n\n---------- FIM ----------\n\n");
  });

  //////////////////////////////////////////////////////////////////////////////////////////////////

  Iterable<int> naturalsFunc() sync* {
    int k = 0;
    // Loop infinito!!!
    while (true) yield k++;
  }

  test("List/Iterable infinito", () {
    var naturalsIter = naturalsFunc();

    print("\n\n---------- Init ----------\n\n");

    print("A lista/iterable infinita foi criada, mas não avaliada.");

    print("\n\n--------------------\n\n");

    print("\n\n---------- takeWhile ----------\n\n");

    print("É possível trabalhar com ela, "
        "mas é preciso utilizar um método que pára em algum momento.\n\n");

    var naturalsUpTo10 = naturalsIter.takeWhile((value) => value <= 10);

    print("Naturais até 10: $naturalsUpTo10");
  });

  //////////////////////////////////////////////////////////////////////////////////////////////////
}
