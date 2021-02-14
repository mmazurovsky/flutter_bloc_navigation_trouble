import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'colors_event.dart';
part 'colors_state.dart';

class ColorsBloc extends Bloc<ColorsEvent, ColorsState> {
  ColorsBloc() : super(ColorsInitial());

  @override
  Stream<ColorsState> mapEventToState(
    ColorsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is InitialLoadColors) {
      yield ColorsLoadingState();
      final loadedColors =
          await Future.delayed(Duration(seconds: 2), () => dataProvided);
      yield ColorsLoadedState(loadedColors);
    } else if (event is NavigateDetailColor) {
      yield ColorsNavigationState(event.colorIndex);
    }
  }

  final List<int> dataProvided = [
    900,
    800,
    700,
    600,
    500,
    400,
    300,
    200,
    100,
    50
  ];
}
