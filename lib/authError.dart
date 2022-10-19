// Firebase Authentication利用時の日本語エラーメッセージ
const int ERRCODE_INVALID_EMAIL = 123123;
const int ERRCODE_WRONG_PASSWORD = 123123;
const int ERRCODE_NOT_FOUND = 123123;

class Authentication_error_to_ja {
  // ログイン時の日本語エラーメッセージ
  login_error_msg(int error_code, String org_error_msg) {
    String error_msg;

    if (error_code == ERRCODE_INVALID_EMAIL) {
      error_msg = '有効なメールアドレスを入力してください。';
    } else if (error_code == ERRCODE_NOT_FOUND) {
      // 入力されたメールアドレスが登録されていない場合
      error_msg = 'メールアドレスかパスワードが間違っています。未登録の場合、先に「アカウント作成」へ。';
    } else if (error_code == ERRCODE_WRONG_PASSWORD) {
      // 入力されたパスワードが間違っている場合
      error_msg = 'メールアドレスかパスワードが間違っています。';
    } else {
      error_msg = org_error_msg + '[' + error_code.toString() + ']';
    }

    return error_msg;
  }

  // アカウント登録時の日本語エラーメッセージ
  register_error_msg(int error_code, String org_error_msg) {
    String error_msg;

    if (error_code == 360587416) {
      error_msg = '有効なメールアドレスを入力してください。';
    } else if (error_code == 34618382) {
      // メールアドレスかパスワードがEmpty or Nullの場合
      error_msg = '既に登録済みのメールアドレスです。';
    } else if (error_code == 447031946) {
      // メールアドレスかパスワードがEmpty or Nullの場合
      error_msg = 'メールアドレスとパスワードを入力してください。';
    } else {
      error_msg = org_error_msg + '[' + error_code.toString() + ']';
    }

    return error_msg;
  }
}
