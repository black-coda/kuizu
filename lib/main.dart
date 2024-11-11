import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:kuizu/app/app.dart';
import 'package:kuizu/firebase/firebase_service.dart';
import 'package:kuizu/json/upload_the_json.dart';
import 'package:kuizu/theme/theme.dart';
import 'package:kuizu/views/splash_screen.dart';
import 'package:provider/provider.dart';

import 'app/app_state.dart';
import 'firebase_options.dart';
import 'model/player_model.dart';
import 'model/quiz_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AppEntry());
}

class AppEntry extends StatefulWidget {
  const AppEntry({super.key});

  @override
  State<AppEntry> createState() => _AppEntryState();
}

class _AppEntryState extends State<AppEntry> {
  @override
  void initState() {
    loadApp();
    super.initState();
  }
  // @override
  // void didChangeDependencies() async {
  //    loadApp();
  //   super.didChangeDependencies();
  // }

  void loadApp() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      _player = await FirebaseService.createUser(userCredential);
      _quiz = await FirebaseService.createQuiz();
      setState(() {
        appLoaded = true;
      });
    } on FormatException catch (e) {
      log('Format Exception! \n $e');
    } catch (e) {
      log('An unknown exception occurred! \n $e');
    }
  }

  bool appLoaded = false;
  Player? _player;
  Quiz? _quiz;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeManager.theme,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData && appLoaded) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider(
                  create: (_) => AppState(
                    player: _player!,
                    quiz: _quiz!,
                  ),
                ),
                StreamProvider(
                  create: (_) => FirebaseService.playerStream(_player!),
                  initialData: _player,
                  catchError: (_, error) =>
                      throw Exception("Error in stream Provider: $error"),
                ),
                StreamProvider<List<Player>>(
                  create: (_) => FirebaseService.leaderBoardStream(),
                  initialData: const [],
                  catchError: (_, error) => throw Exception(
                      "Error in stream leaderBoard Provider: $error"),
                )
              ],
              child: const CoreAppView(),
            );
          }
          return const SplashScreen();
        },
      ),
    );
  }
}
