class cell {
  bool isOpen = false;
  // 爆弾があるか
  bool isMine = false;
  // 周りの爆弾の数
  int aroundMineCnt = 0;
  // コンストラクタ
  cell(this.isOpen, this.isMine, this.aroundMineCnt);
  // 初期化
  void reset() {
    isOpen = false;
    isMine = false;
    aroundMineCnt = 0;
  }

  void SetMine(bool value) {
    isMine = value;
    print('爆弾を設定 $value');
  }

  void SetBombCount() {
    aroundMineCnt++;
  }

  void Open() {
    isOpen = true;
  }
}
