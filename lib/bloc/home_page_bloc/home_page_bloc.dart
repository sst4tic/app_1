import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'abstract_home_page.dart';
part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final AbstractHomePage homePageRepo;
  HomePageBloc(this.homePageRepo) : super(HomePageInitial()) {
    on<LoadHome>((event, emit) async {
      try {
        if (state is! HomePageLoading) {
          emit(HomePageLoading());
          final homePage = await homePageRepo.getHomePage();
          if (homePage.isNotEmpty) {
            emit(HomePageLoaded(items: homePage));
          } else {
            emit(HomePageError());
          }
        }
      } catch (e) {
        emit(HomePageError(exception: e));
      } finally {
        event.completer?.complete();
      }
    });
  }
}
