part of 'colors_bloc.dart';

abstract class ColorsState extends Equatable {
  const ColorsState();
  
  @override
  List<Object> get props => [];
}

class ColorsInitial extends ColorsState {}

class ColorsLoadingState extends ColorsState {}

class ColorsLoadedState extends ColorsState {
  final List<int> _loadedColors;
  ColorsLoadedState(this._loadedColors);

  List<int> get loadedColors =>
      _loadedColors;
}

class ColorsNavigationState extends ColorsState {
  final int colorIndex;
  ColorsNavigationState(this.colorIndex);
}

