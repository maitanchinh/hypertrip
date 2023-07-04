import 'package:bloc/bloc.dart';

import 'state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit() : super(AccountState().init());
}
