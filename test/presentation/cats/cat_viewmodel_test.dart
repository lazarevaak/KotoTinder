import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:kototinder/domain/entities/cat.dart';
import 'package:kototinder/domain/usecases/init_cats.dart';
import 'package:kototinder/domain/usecases/get_random_cat.dart';
import 'package:kototinder/domain/usecases/like_cat.dart';
import 'package:kototinder/domain/usecases/remove_cat.dart';
import 'package:kototinder/presentation/viewmodels/cat_viewmodel.dart';

class MockInitCats extends Mock implements InitCats {}
class MockGetRandomCat extends Mock implements GetRandomCat {}
class MockLikeCat extends Mock implements LikeCat {}
class MockRemoveCat extends Mock implements RemoveCat {}

void main() {
  test('init loads liked and random cat', () async {
    final mockInit = MockInitCats();
    final mockRandom = MockGetRandomCat();
    final mockLike = MockLikeCat();
    final mockRemove = MockRemoveCat();

    const cat = Cat(
      id: '1',
      url: 'https://test.com/cat.jpg',
      width: 500,
      height: 400,
      breedID: 'breed',
      breedName: 'Test Breed',
      fullBreed: null,
    );

    when(() => mockInit()).thenAnswer(
      (_) async => InitCatsResult(
        liked: [cat],
        random: cat,
      ),
    );

    final vm = CatViewModel(
      initCats: mockInit,
      getRandomCat: mockRandom,
      likeCat: mockLike,
      removeCat: mockRemove,
    );

    await vm.init();

    expect(vm.likedCats.length, 1);
    expect(vm.currentCat?.id, '1');
  });
}