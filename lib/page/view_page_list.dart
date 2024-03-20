import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maraphons/bloc/rating_bloc/rating_bloc.dart';
import 'package:maraphons/model/colors.dart';
import 'package:maraphons/model/word.dart';
import 'package:maraphons/widgets/app_bar_title.dart';

class ViewPageList extends StatefulWidget {
  const ViewPageList({super.key});

  @override
  State<ViewPageList> createState() => _ViewPageListState();
}

class _ViewPageListState extends State<ViewPageList> {
  @override
  void initState() {
    context.read<RatingBloc>().add(LoadUrl());
    super.initState();
  }

  @override
  void dispose() {
    context.read<RatingBloc>().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      appBar: AppBarTitle(
        titleText: Word.rating,
        size: 22,
        height: MediaQuery.of(context).size.height,
      ),
      body: BlocBuilder<RatingBloc, RatingState>(
        builder: (context, state) {
          if (state is RatingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is RatingError) {
            return Center(child: Text(state.message));
          }
          if (state is RatingLoaded) {
            final data = state.data;
            return Padding(
              padding: const EdgeInsets.only(right: 8, left: 8, bottom: 16),
              child: Padding(
                padding: const EdgeInsets.all(0),
                child: ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          color: index == 0
                              ? AppColors.tableHeader
                              : data[index].rating == '1'
                                  ? AppColors.goldBackground
                                  : data[index].rating == '2'
                                      ? AppColors.silverBackground
                                      : data[index].rating == '3'
                                          ? AppColors.bronzeBackground
                                          : AppColors.background,
                        ),
                        child: ListTile(
                          title: IntrinsicHeight(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Center(
                                    child: data[index].rating == '1'
                                        ? const Text(
                                            '🥇',
                                            style: TextStyle(
                                              fontSize: 40,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : data[index].rating == '2'
                                            ? const Text(
                                                '🥈',
                                                style: TextStyle(fontSize: 32),
                                              )
                                            : data[index].rating == '3'
                                                ? const Text(
                                                    '🥉',
                                                    style:
                                                        TextStyle(fontSize: 28),
                                                  )
                                                : Text(
                                                    data[index].rating,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontFamily: 'SegoePrint',
                                                      fontWeight: index == 0
                                                          ? FontWeight.bold
                                                          : FontWeight.normal,
                                                      fontSize:
                                                          index == 0 ? 32 : 20,
                                                    ),
                                                  ),
                                  ),
                                ),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                Expanded(
                                    flex: 5,
                                    child: Text(
                                      state.data[index].fio,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: index == 0
                                          ? TextAlign.center
                                          : TextAlign.start,
                                      style: TextStyle(
                                        fontFamily: 'SegoePrint',
                                        fontWeight: index == 0
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                        fontSize: index == 0 ? 32 : 24,
                                      ),
                                    )),
                                const VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    data[index].count,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: index == 0
                                          ? 'SegoePrint'
                                          : '1stenterprises3D',
                                      fontStyle: index == 0
                                          ? FontStyle.normal
                                          : FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                      fontSize: index == 0 ? 32 : 28,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(color: Colors.black),
          );
        },
      ),
    );
  }
}
