part of 'colors_bloc.dart';

abstract class ColorsEvent extends Equatable {
  const ColorsEvent();

  @override
  List<Object> get props => [];
}

class InitialLoadColors extends ColorsEvent {
  InitialLoadColors();
}

class NavigateDetailColor extends ColorsEvent {
  final int colorIndex;
  NavigateDetailColor(this.colorIndex);
}

