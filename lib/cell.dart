class cell {
  bool _isOpen = false;
  // 爆弾があるか
  bool _isMine = false;
  // 周りの爆弾の数
  int _aroundMineCnt = 0;
  // コンストラクタ
  cell(this._isOpen, this._isMine, this._aroundMineCnt);
  // 初期化
  void reset() {
    _isOpen = false;
    _isMine = false;
    _aroundMineCnt = 0;
  }

  void SetMine(bool isMine) => _isMine = isMine;
  void Open() {
    _isOpen = true;
  }
}
