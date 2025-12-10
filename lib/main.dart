
import 'package:fixteck/data/repositories/auth_repository.dart';
import 'package:fixteck/data/repositories/wallet_repository.dart';
import 'package:fixteck/data/repositories/profile_repository.dart';
import 'package:fixteck/bloc/login_bloc.dart';
import 'package:fixteck/bloc/login_state.dart';
import 'package:fixteck/ui/splash/splash_screen.dart';
import 'package:fixteck/ui/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => AuthRepository()),
        RepositoryProvider(create: (_) => WalletRepository()),
        RepositoryProvider(create: (_) => ProfileRepository()),
      ],
      child: BlocProvider(
        create: (context) => LoginBloc(
          authRepository: context.read<AuthRepository>(),
        ),
        child: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            // Auto-navigate to login when unauthenticated
            if (state is Unauthenticated) {
              // Clear navigation stack and navigate to login
              Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (route) => false,
              );
            }
          },
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              fontFamily: GoogleFonts.manrope().fontFamily,
              textTheme: GoogleFonts.manropeTextTheme(),
            ),
            home: const SplashScreen(),
          ),
        ),
      ),
    );
  }
}
