class LoginEvent{
  bool isLogin = false;
  LoginEvent(this.isLogin);
}

class NewMsgEvent{
  bool needScrollToBottom = false;
  NewMsgEvent(this.needScrollToBottom);
}