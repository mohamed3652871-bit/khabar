abstract class NewsState {}
class NewsInitial extends NewsState {}

class NewsLoadingState extends NewsState {}
class NewsSuccessState extends NewsState {}
class NewsErrorState extends NewsState {}
