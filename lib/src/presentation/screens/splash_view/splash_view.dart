import 'package:bangli_service_center_bloc/src/common/constant.dart';
import 'package:bangli_service_center_bloc/src/common/shared/rotate_animation.dart';
import 'package:bangli_service_center_bloc/src/presentation/bloc/auth/auth_bloc.dart';
import 'package:bangli_service_center_bloc/src/presentation/screens/login_view/login_view.dart';
import 'package:bangli_service_center_bloc/src/presentation/screens/test_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashhhView extends StatefulWidget {
  const SplashhhView({super.key});

  @override
  State<SplashhhView> createState() => _SplashhhViewState();
}

class _SplashhhViewState extends State<SplashhhView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<AuthBloc>().add(AutoLoginEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      // bloc: BlocProvider.of<AuthBloc>(context),
      listener: (context, state) {
        if (state is AuthFailure) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ));
        } else if (state is AuthSuccess) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TestView(),
              ));
        }
      },
      child: const Scaffold(
        backgroundColor: primaryColor,
        body: Center(
          child: LoadingIndicatorRotate(),
        ),
      ),
    );
  }
}

class LoadingIndicatorRotate extends StatelessWidget {
  const LoadingIndicatorRotate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RotateAnimationTut(
      duration: 6,
      rotationsPerMinute: 3.5,
      child: Image.asset(
        "assets/icon/flower-white.png",
        width: 35,
      ),
    );
  }
}
