import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maraphons/bloc/app_bloc_bloc.dart';
import 'package:maraphons/bloc/rating_bloc/rating_bloc.dart';
import 'package:maraphons/data/storage_data.dart';
import 'package:maraphons/data/storage_repository.dart';
import 'package:maraphons/page/timer_page.dart';
import 'package:maraphons/page/view_page_list.dart';
import 'package:maraphons/widgets/app_bar_title.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final localDb = await SharedPreferences.getInstance();
  runApp(MyApp(preferences: localDb));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.preferences, super.key});

  final SharedPreferences preferences;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              AppBlocBloc(StorageRepository(StorageDataSource(preferences))),
        ),
        BlocProvider(
          create: (context) => RatingBloc(
            StorageRepository(StorageDataSource(preferences)),
          ),
        )
      ],
      child: SafeArea(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          home: BlocBuilder<AppBlocBloc, AppBlocState>(
            builder: (context, state) {
              context.read<AppBlocBloc>().add(const InitialValueEvent());
              final end = context.read<AppBlocBloc>().state.endsEvent;
              return Stack(
                children: [
                  Opacity(
                    opacity: 0.3,
                    child: Image.asset(
                      'assets/main_fon.jpg',
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: AppBarTitle(
                      titleText: context.read<AppBlocBloc>().state.nameEvent,
                      size: 28,
                      isMainAppBar: true,
                      height: MediaQuery.of(context).size.width,
                    ),
                    body: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          Expanded(flex: 2, child: TimerPage(endEvent: end)),
                          const Expanded(flex: 4, child: ViewPageList()),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
