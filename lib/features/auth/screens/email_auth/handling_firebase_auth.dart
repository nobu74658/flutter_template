ArgumentError handleFirebaseAuthError(String code) {
  switch (code) {
    case 'invalid-email':
      return ArgumentError('メールアドレスが有効ではありません。');
    case 'user-not-found':
      // ユーザーがいるかどうかのヒントを返す必要は無い
      return ArgumentError('メールアドレスが有効ではありません。');
    case 'missing-email':
      return ArgumentError('メールアドレスが有効ではありません。');
    case 'wrong-password':
      return ArgumentError('メールアドレスまたはパスワードに誤りがあります。');
    case 'weak-password':
      return ArgumentError('強度なパスワードを再設定してください。');
    case 'email-already-in-use':
      return ArgumentError('ご指定されたアカウントは既に存在してるようです。');
    default:
      return ArgumentError('不明なエラーが発生しました。');
  }
}
