import 'package:mobx/mobx.dart';

part 'store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  @observable
  String login = '';

  @observable
  String password = '';

  @action
  void setLogin(String value) => login = value;

  @action
  void setPassword(String value) => password = value;

  @computed
  bool get isLoginAndPasswordValid =>
      login.isNotEmpty &&
          password.length >= 2 &&
          !password.contains(RegExp(r'[^a-zA-Z0-9]')) &&
          login.length <= 20 &&
          password.length <= 20 &&
          !login.endsWith(' ') &&
          !password.endsWith(' ');
}
