import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_frequent_prodcts_entity.dart';
import 'package:myco_flutter/features/take_order/domain/entities/get_product_category_entity.dart';
import 'package:myco_flutter/features/take_order/domain/entities/retailer_details_entity.dart';
import 'package:myco_flutter/features/take_order/domain/usecases/get_frequent_products_usecase.dart';
import 'package:myco_flutter/features/take_order/domain/usecases/get_product_category_usecase.dart';
import 'package:myco_flutter/features/take_order/domain/usecases/get_retailer_details_usecase.dart';

part 'take_order_event.dart';
part 'take_order_state.dart';

class TakeOrderBloc extends Bloc<TakeOrderEvent, TakeOrderState> {
  Timer? _timer;
  Duration _duration = Duration.zero;
  GetRetailerDetailsUsecase getRetailerDetails;
  TakeOrderBloc(this.getRetailerDetails) : super(TakeOrderInitial()) {
    // Tab Event
    // on<TabChangeEvent>(tabChangeEvent);

    // Visit Timer Event
    on<StartVisitEvent>(onStart);
    on<StopVisitEvent>(onStop);
    on<RefreshTimerEvent>(onRefresh);
    on<TickEvent>(onTick);
    on<SearchQueryChangeEvent>(onSearch);

    // Get Retailer Details
    on<GetRetailerDetailsEvent>(getRetailersDetails);
  }

  // void tabChangeEvent(TabChangeEvent event, Emitter<TakeOrderState> emit) {
  //   emit(TabChangeState(selectedIndex: event.index));
  // }

  void onStart(StartVisitEvent event, Emitter<TakeOrderState> emit) {
    _timer?.cancel();

    // Reset the Duration
    _duration = Duration.zero;

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(TickEvent()),
    );
    emit(VisitRunning(_duration));
  }

  void onStop(StopVisitEvent event, Emitter<TakeOrderState> emit) {
    _timer?.cancel();
    emit(VisitStopped(_duration));
  }

  void onRefresh(RefreshTimerEvent event, Emitter<TakeOrderState> emit) {}
  void onTick(TickEvent event, Emitter<TakeOrderState> emit) {
    _duration += const Duration(seconds: 1);
    emit(VisitRunning(_duration));
  }

  void onSearch(SearchQueryChangeEvent event, Emitter<TakeOrderState> emit) {
    final query = event.query.toLowerCase();

    if (query == '') {
      emit(ProductSearchState(fileteredProducts: event.allProducts));
    } else {
      final filtered = event.allProducts
          .where((product) => product.toLowerCase().contains(query))
          .toList();

      emit(ProductSearchState(fileteredProducts: filtered));
    }
  }

  FutureOr<void> getRetailersDetails(
    GetRetailerDetailsEvent event,
    Emitter<TakeOrderState> emit,
  ) async {
    emit(GetRetailerDetailsLoadingState());

    final result = await getRetailerDetails();

    result.fold(
      (failure) => emit(GetRetailerDetailsErrorState(error: failure.message)),
      (retailerDetails) => emit(
        GetRetailerDetailsSuccessState(retailerDetailsEntity: retailerDetails),
      ),
    );
  }
}

class TakeOrderMainBloc extends Bloc<TakeOrderEvent, TakeOrderMainState> {
  List categories = [];
  GetProductCategoryUsecase getProductCategoryUsecase;
  TakeOrderMainBloc(this.getProductCategoryUsecase)
    : super(TakeOrderMainInitialState()) {
    on<GetProductCategoryEvent>(getProductCatgory);
    on<GetProductByCategoryEvent>(getProductByCategory);
  }

  FutureOr<void> getProductCatgory(
    GetProductCategoryEvent event,
    Emitter<TakeOrderMainState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, error: ''));

    final result = await getProductCategoryUsecase();

    result.fold(
      (failure) =>
          emit(state.copyWith(isLoading: false, error: failure.message)),
      (response) {
        log(response.toString(), name: 'before_emit');
        emit(
          state.copyWith(isLoading: false, getProductCategoryEntity: response),
        );
        log(response.toString(), name: 'after_emit');
      },
    );
  }

  FutureOr<void> getProductByCategory(
    GetProductByCategoryEvent event,
    Emitter<TakeOrderMainState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: false,
        selectedCategoryIndex: event.selectedIndex,
      ),
    );
  }
}

class FrequentProductsBloc extends Bloc<TakeOrderEvent, TakeOrderState> {
  GetFrequentProductsUsecase getFrequentProductsUsecase;
  FrequentProductsBloc(this.getFrequentProductsUsecase)
    : super(TakeOrderInitial()) {
    on<GetFrequentProductsEvent>(getFrequentProducts);
  }

  FutureOr<void> getFrequentProducts(
    GetFrequentProductsEvent event,
    Emitter<TakeOrderState> emit,
  ) async {
    emit(FrequentProductsLoadingState());

    final result = await getFrequentProductsUsecase();

    result.fold(
      (failure) => emit(FrequentProductsErrorState(error: failure.message)),
      (response) => emit(
        FrequentProductsSuccessState(getFrequentProductsEntity: response),
      ),
    );
  }
}
