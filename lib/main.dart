import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:youapp_test/core/security/security.dart';
import 'package:youapp_test/core/styles/themeYouApp.dart';
import 'package:youapp_test/src/auth/presentation/cubit/register/register_cubit.dart';

import '/injection.dart' as di;
import 'core/platform/key_local_storage.dart';
import 'core/routes/app_routes.dart';
import 'global_bloc_observer.dart';
import 'src/auth/presentation/cubit/login/login_cubit.dart';
import 'src/profile/presentation/bloc/interest/interest_bloc.dart';
import 'src/profile/presentation/bloc/profile/profil_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = GlobalBlocObserver();

  di.init(await getHttpClient());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // with repository
        BlocProvider(create: (_) => di.locator<LoginCubit>()),
        BlocProvider(create: (_) => di.locator<RegisterCubit>()),
        // without repository
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => InterestBloc()),
      ],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: themeYouApp(),
        initialRoute: AppRoutes.splash,
        getPages: AppRoutes.routes,
        routingCallback: (route) {
          if (route!.current == AppRoutes.splash) {
            Future.delayed(
              const Duration(milliseconds: 1500),
              () async {
                final email = await KeyLocalStorage().readAuthStorage('email');
                if (email.trim().isNotEmpty) {
                  Get.offAllNamed(AppRoutes.profile, arguments: [
                    await KeyLocalStorage().readAuthStorage('email')
                  ]);
                } else {
                  Get.offAllNamed(AppRoutes.signIn);
                }
              },
            );
          }
        },
      ),
    );
  }
}
