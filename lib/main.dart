import 'package:bangli_service_center_bloc/injection.dart';
import 'package:bangli_service_center_bloc/simple_bloc_observer.dart';
import 'package:bangli_service_center_bloc/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:bangli_service_center_bloc/src/presentation/bloc/complaint/complaint_bloc.dart';
import 'package:bangli_service_center_bloc/src/presentation/screens/splash_view/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = SimpleBlocObserver();
  await dotenv.load(fileName: '.env');
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider<ComplaintBloc>(
          create: (context) => sl<ComplaintBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bangli Service Center Bloc',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: const SplashhhView(),
      ),
    );
  }
}
