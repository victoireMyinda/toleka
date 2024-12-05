import 'package:bloc/bloc.dart';
import 'package:toleka/data/repository/abonnement_repository.dart';

part 'abonnement_state.dart';

class AbonnementCubit extends Cubit<AbonnementState> {
  AbonnementCubit() : super(AbonnementState(field: initialState()));

  initForm() async {
    List abonnementData = await AbonnementRepository.getDataListAbonnementCache();
    emit(AbonnementState(field: {
      ...state.field!,
      "abonnementData": abonnementData,
    }));
  }

    initFormPayment() async {
    List paymentData = await AbonnementRepository.getDataListPaymentCache();
    emit(AbonnementState(field: {
      ...state.field!,
      "paymentData": paymentData,
    }));
  }

  void updateField(context, {required String field, String? data}) {
    emit(AbonnementState(field: {
      ...state.field!,
      field: data,
    }));
  }
}
