import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

import '../data/datasources/storage/cat_hive_model.dart';
import '../data/datasources/local/cat_local_datasource.dart';
import '../data/datasources/remote/cat_remote_datasource.dart';
import '../data/datasources/services/cat_api_service.dart';
import '../data/datasources/local/auth_local_datasource.dart';
import '../data/datasources/services/analytics_service.dart';
import '../data/datasources/services/analytics_service_impl.dart';

import '../domain/repositories/auth/auth_repository_impl.dart';
import '../domain/repositories/cat/cat_repository_impl.dart';
import '../domain/repositories/cat/cat_repository.dart';
import '../domain/repositories/auth/auth_repository.dart';

import '../domain/usecases/init_auth.dart';
import '../domain/usecases/init_cats.dart';

import '../domain/usecases/get_liked_cats_with_breed.dart';
import '../domain/usecases/get_random_cat.dart';
import '../domain/usecases/like_cat.dart';
import '../domain/usecases/remove_cat.dart';
import '../domain/usecases/get_breeds.dart';
import '../domain/usecases/search_breeds.dart';

import '../domain/usecases/login.dart';
import '../domain/usecases/register.dart';
import '../domain/usecases/check_auth_status.dart';
import '../domain/usecases/complete_onboarding.dart';
import '../domain/usecases/check_onboarding_status.dart';

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

        Provider<FirebaseAnalytics>(
          create: (_) => FirebaseAnalytics.instance,
        ),

        Provider<AnalyticsService>(
          create: (context) =>
              AnalyticsServiceImpl(
                context.read<FirebaseAnalytics>(),
              ),
        ),

        Provider(create: (_) => const FlutterSecureStorage()),

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
              CompleteOnboarding(context.read<AuthRepository>()),
        ),

        Provider(
          create: (context) =>
              CheckAuthStatus(context.read<AuthRepository>()),
        ),

        Provider(
          create: (context) =>
              CheckOnboardingStatus(context.read<AuthRepository>()),
        ),

        Provider(
          create: (context) => InitAuth(
            context.read<CheckAuthStatus>(),
            context.read<CheckOnboardingStatus>(),
          ),
        ),

        ChangeNotifierProvider(
          create: (context) => AuthViewModel(
            loginUseCase: context.read<Login>(),
            registerUseCase: context.read<Register>(),
            completeOnboardingUseCase:
                context.read<CompleteOnboarding>(),
            initAuth: context.read<InitAuth>(),
            analytics: context.read<AnalyticsService>(),
          )..init(),
        ),

        Provider(create: (_) => CatApiService()),

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
          create: (context) =>
              GetRandomCat(context.read<CatRepository>()),
        ),

        Provider(
          create: (context) =>
              LikeCat(context.read<CatRepository>()),
        ),

        Provider(
          create: (context) =>
              RemoveCat(context.read<CatRepository>()),
        ),

        Provider(
          create: (context) =>
              GetBreeds(context.read<CatRepository>()),
        ),

        Provider(create: (_) => SearchBreeds()),

        Provider(
          create: (context) => InitCats(
            context.read<GetLikedCatsWithBreed>(),
            context.read<GetRandomCat>(),
          ),
        ),

        ChangeNotifierProvider(
          create: (context) => CatViewModel(
            initCats: context.read<InitCats>(),
            getRandomCat: context.read<GetRandomCat>(),
            likeCat: context.read<LikeCat>(),
            removeCat: context.read<RemoveCat>(),
          )..init(),
        ),

        ChangeNotifierProvider(
          create: (context) => BreedsViewModel(
            getBreeds: context.read<GetBreeds>(),
            searchBreeds: context.read<SearchBreeds>(),
          )..loadBreeds(),
        ),
      ],
      child: const KotoTinderApp(),
    );
  }
}