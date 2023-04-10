abstract class BlocState<T> {
  T? data;

  BlocState({required this.data});
}

class BlocEmptyState extends BlocState {
  BlocEmptyState({required super.data});
}

class BlocStableState<T> extends BlocState {
  BlocStableState({required super.data});
}

class BlocLoadingState<T> extends BlocState {
  BlocLoadingState({super.data});
}

class BlocErrorState<T> extends BlocState {
  BlocErrorState({super.data});
}
