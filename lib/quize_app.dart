import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:quize_app/dependency_injection/di.dart';
import 'package:quize_app/src/presentation/result/view_model/result_cubit.dart';
import 'config/routes/app_routes.dart';
import 'config/routes/page_route_name.dart';
import 'config/theme/app_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OnlineExamApp extends StatelessWidget {
  const OnlineExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<ResultCubit>(),
      child: ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale("en"),
            initialRoute: PageRouteName.splash,
            onGenerateRoute: (settings) => AppRoutes.onGenerateRoute(settings),
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppTheme.appTheme,
          );
        },
      ),
    );
  }
}
