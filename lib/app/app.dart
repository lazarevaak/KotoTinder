import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../data/datasources/storage/cat_hive_model.dart';
import '../data/datasources/local/cat_local_datasource.dart';
import '../data/datasources/remote/cat_remote_datasource.dart';
import '../data/datasources/services/cat_api_service.dart';
import '../domain/repositories/cat_repository_impl.dart';

import '../data/datasources/local/auth_local_datasource.dart';
import '../domain/repositories/auth_repository_impl.dart';

import '../domain/repositories/cat_repository.dart';
import '../domain/repositories/auth_repository.dart';

import '../domain/usecases/get_liked_cats_with_breed.dart';
import '../domain/usecases/search_breeds.dart';

import '../domain/usecases/login.dart';
import '../domain/usecases/register.dart';
import '../domain/usecases/check_auth_status.dart';
import '../domain/usecases/complete_onboarding.dart';

import '../presentation/viewmodels/cat_viewmodel.dart';
import '../presentation/viewmodels/breeds_viewmodel.dart';
import '../presentation/viewmodels/auth_viewmodel.dart';

import 'app_root.dart';

class App extends StatelessWidget {
  final Box<CatHiveModel> box;
  final SharedPreferences prefs;

  const App({
    super.key,
    required this.box,
    required this.prefs,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [

        Provider(
          create: (_) => const FlutterSecureStorage(),
        ),

        Provider(
          create: (context) => AuthLocalDataSource(
            secureStorage: context.read<FlutterSecureStorage>(),
            prefs: prefs,
          ),
        ),

        Provider<AuthRepository>(
          create: (context) =>
              AuthRepositoryImpl(context.read<AuthLocalDataSource>()),
        ),

        Provider(
          create: (context) => Login(context.read<AuthRepository>()),
        ),

        Provider(
          create: (context) => Register(context.read<AuthRepository>()),
        ),

        Provider(
          create: (context) =>
              CheckAuthStatus(context.read<AuthRepository>()),
        ),

        Provider(
          create: (context) =>
              CompleteOnboarding(context.read<AuthRepository>()),
        ),

        ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            loginUseCase: context.read<Login>(),
            registerUseCase: context.read<Register>(),
            checkAuthStatus: context.read<CheckAuthStatus>(),
            completeOnboardingUseCase:
                context.read<CompleteOnboarding>(),
          )..init(),
        ),

        Provider(
          create: (_) => CatApiService(),
        ),

        Provider(
          create: (context) =>
              CatRemoteDataSource(context.read<CatApiService>()),
        ),

        Provider(
          create: (_) => CatLocalDataSource(box),
        ),

        Provider<CatRepository>(
          create: (context) => CatRepositoryImpl(
            remote: context.read<CatRemoteDataSource>(),
            local: context.read<CatLocalDataSource>(),
          ),
        ),

        Provider(
          create: (context) =>
              GetLikedCatsWithBreed(context.read<CatRepository>()),
        ),

        Provider(
          create: (_) => SearchBreeds(),
        ),

        ChangeNotifierProvider(
          create: (context) => CatViewModel(
            repository: context.read<CatRepository>(),
            getLikedCats:
                context.read<GetLikedCatsWithBreed>(),
          )..init(),
        ),

        ChangeNotifierProvider(
          create: (context) => BreedsViewModel(
            repository: context.read<CatRepository>(),
            searchBreeds: context.read<SearchBreeds>(),
          )..loadBreeds(),
        ),
      ],
      child: const KotoTinderApp(),
    );
  }
}
