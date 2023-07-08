import 'package:bloc/bloc.dart';

import 'state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatState().init());
}
