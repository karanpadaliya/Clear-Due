part of 'take_order_bloc.dart';

sealed class TakeOrderState extends Equatable {
  const TakeOrderState();

  @override
  List<Object> get props => [];
}

final class TakeOrderInitial extends TakeOrderState {}

// class TabChangeState extends TakeOrderState {
//   final int selectedIndex;

//   const TabChangeState({required this.selectedIndex});

//   @override
//   List<Object> get props => [selectedIndex];
// }

final class VisitRunning extends TakeOrderState {
  final Duration duration;

  const VisitRunning(this.duration);

  @override
  List<Object> get props => [duration];
}

final class VisitStopped extends TakeOrderState {
  final Duration duration;

  const VisitStopped(this.duration);

  @override
  List<Object> get props => [duration];
}

class ProductSearchState extends TakeOrderState {
  final List<String> fileteredProducts;

  const ProductSearchState({required this.fileteredProducts});

  @override
  List<Object> get props => [fileteredProducts];
}

// ======== Get Retailer Details State

class GetRetailerDetailsLoadingState extends TakeOrderState {}

class GetRetailerDetailsErrorState extends TakeOrderState {
  final String error;
  const GetRetailerDetailsErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class GetRetailerDetailsSuccessState extends TakeOrderState {
  final RetailerDetailsEntity retailerDetailsEntity;
  const GetRetailerDetailsSuccessState({required this.retailerDetailsEntity});
  @override
  List<Object> get props => [retailerDetailsEntity];
}

class FrequentProductsLoadingState extends TakeOrderState {}

class FrequentProductsErrorState extends TakeOrderState {
  final String error;
  const FrequentProductsErrorState({required this.error});
  @override
  List<Object> get props => [error];
}

class FrequentProductsSuccessState extends TakeOrderState {
  final GetFrequentProductsEntity getFrequentProductsEntity;
  const FrequentProductsSuccessState({required this.getFrequentProductsEntity});
  @override
  List<Object> get props => [getFrequentProductsEntity];
}

class TakeOrderMainState {
  final bool isLoading;
  final String error;
  final GetProductCategoryEntity getProductCategoryEntity;
  final int selectedCategoryIndex;

  TakeOrderMainState({
    required this.isLoading,
    required this.error,
    required this.getProductCategoryEntity,
    required this.selectedCategoryIndex,
  });

  TakeOrderMainState copyWith({
    bool? isLoading,
    String? error,
    GetProductCategoryEntity? getProductCategoryEntity,
    int? selectedCategoryIndex,
  }) => TakeOrderMainState(
    isLoading: isLoading ?? this.isLoading,
    error: error ?? this.error,
    getProductCategoryEntity:
        getProductCategoryEntity ?? this.getProductCategoryEntity,
    selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
  );

  List<Object> get props => [
    isLoading,
    error,
    getProductCategoryEntity,
    selectedCategoryIndex,
  ];
}

class TakeOrderMainInitialState extends TakeOrderMainState {
  TakeOrderMainInitialState()
    : super(
        isLoading: true,
        error: '',
        getProductCategoryEntity: GetProductCategoryEntity(),
        selectedCategoryIndex: 0,
      );
}
