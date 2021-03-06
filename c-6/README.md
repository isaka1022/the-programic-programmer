# 並行性

- 「並行処理」とは複数のコードがあたかも同時に実行されているかのように振る舞うこと
    - 実行中にコードの異なる部分に制御を切り替えられるような環境でコードを実行する必要がある
    - ファイバー、スレッド、プロセス
- 「並列処理」とは複数のコードが本当に同時に実行されること
    - ２つの物事を同時に実行できるハードウェアが必要になる

### すべては並行処理

- 並行処理という観点を盛り込まずに進めることはほぼ不可能
- コードの間以外にも「時間的結合」が存在
    - システムが動作する順番にも柔軟性がないとだめ
- 並行処理や並列処理が難しい
    - 逐次的システムを使ってプログラムを学習した
    - 使用している言語自体が逐次的
    - 最大の問題は状態の共有
- アクターモデルを使用する
    - データを共有しない独立したプロセスが、明確に定義されたシンプルなセマンティックスを用い、チャンネルを介して通信する
- ホワイトボード
    - オブジェクトストアと、スマートなPubSubの組み合わせとして機能するシステム

## 時間的な結合を破壊する

- 並行性（同時に発生すること）と順序（時間軸上における相対的な位置関係）
- プログラムの実行順序が指定されると柔軟性、現実性が乏しいものになる

### 並行部分を探す

- アクティビティ図といった表記法を用いてワークフローを補足する
- **並行性を向上させるためにワークフローを分析する**

### 並行処理の機会

- データベースのキューイング、外部サービスへのアクセス、ユーザーからの入力待ちといったものすべては完了までシステムを停止させる
- ここでより有益な仕事をサせるようにする

### 並列処理の機会

- 分割したここの作業が比較的独立していて他の作業を待つという状況がないもの
- Elixirのコンパイラ

### 機会の洗い出しは難しくない

- あとはいかに安全に実装するか

## 共有状態は間違った状態

- **共有状態は間違った状態**
- 2つのプロセスが同じメモリ領域に書き込めるところが問題
    - どちらのプロセスも参照したメモリの整合性を保証できない

セマフォー、そしてその他の相互排除形式

- セマフォーは、ある時点で誰か一人しか専有できない「何らかのもの」
- 伝統的にセマフォーを取得する操作は「P」、返却する操作は「V」と呼ばれていた
- 今日では「ロック/アンロック」、「取得/解放」となる

リソースをトランザクション化する

- 単一の呼び出しで一括化する


### 複数リソースのトランザクション

### トランザクション以外での更新

- 変更処理の問題は、ファイルやデータベース、外部サービスなどアプリケーションのコードが変更可能なリソースを共有していればどこでも発生しうる
- リソース自体が明確でない
- **無秩序なエラーはしばしば並行処理によって引き起こされる**

### その他の排他的アクセス

- ほとんどの言語には共有リソースに対するある種の排他的アクセス機構がある
    - ミューテックス、モニター、セマフォー

### お医者さん！痛むのです...

- 共有リソース環境における並行処理は難しく、その管理は苦難の連続である

## アクターとプロセス

- 共有メモリーの同期という重荷を背負うことなく並行処理を実現する興味深い方法を提供
    - 「アクター」は局所的かつ固有の（プライベートな）状態を保持した、独立したプロセッサ
        - 各アクターがメールボックスを備えている
        - メッセージが届いた際に、待機中なら処理
        - 完了したらメールボックスの別のメッセージを処理するか待機状態になる
        - メッセージの処理の際にアクターは他のアクターを生成したり、他のアクターにメッセージを送ったり、次のメッセージを処理する際に遷移する新しい状態を作ったりする
    - 「プロセス」はより汎用目的の仮想プロセッサー
        - 並行処理を容易にする目的でOSによって実装される
        - プロセスは制約によってアクターのように振る舞うような規約が課されている

### アクターは平衡状態のみが存在する

- アクターの定義に「記述されていないこと」
    - 統制されている「ものごと」は一つも存在していない
        - 次に起こることを決めたり、生データから最終的な出力に情報を移送する上での調整役となるものは存在しない
    - システムにおける「唯一の状態」はメッセージと各アクターがローカルに保持する状態に格納されている
    - すべてのメッセージは一方通行で応答という考え方はない
    - アクターによる各メッセージの処理は一つづつ
- **共有状態を持たないアクターを並行処理で使用する**

### シンプルなアクター

- レストランの例（アクター：顧客、ウェイター、陳列ケース）
- 我々が顧客に、空腹を感じるように指示
- 応答として顧客がウェイターにパイがあるかどうかを尋ねる
- ウェイターが陳列ケースに対して、パイを顧客に提供するように要求
- 陳列ケースがパイを提供できるのであれば、それを顧客に送り届け、同時にウェイターに対してパイを請求書に書き加えるように通知
- パイがない場合、その旨をウェイターに伝え、ウェイターは顧客にお詫びする

### 明示的でない並行処理

- アクターモデルでは状態を共有しない
- E2Eのロジックも必要ない

### Erlangにおけるアクターモデル

- Erlangはアクターの素晴らしい実装例
- プロセスを管理するスーパービジョンシステムがある

## ホワイトボード

- 刑事のホワイトボードによる調査のメタファー
- ホワイトボードから情報を引き出し、自分が見つけたものを書き込んでいく
- 異なった訓練所、教育、技術レベルで、目的だけ共有してりう
- 何人もの刑事がプロセス過程で出入りして、異なったシフトで操作もできる
- ホワイトボードに記述する内容に関する制限はない
- 並列処理におけるレッセフェール（自由放任主義）
    - 刑事らは独自つしたプロセス、エージェント、アクター

### ホワイトボードの使用例

- 考えうる全ての組み合わせと状況が複雑な場合
- 法的要求をカプセル化したルールエンジンを強調させる
- **ワークフローを協調させるにはホワイトボードというコンセプトを活用すること**

### メッセージシステムはホワイトボードのようになる

- 多くのアプリケーションは小さな分離されたサービスを用いている
- ある種のメッセージシステムを介している
- ホワイトボードシステムとして利用しながらアクターとして利用できる

### とはいうものの、話はそう簡単ではない

- アクター/ホワイトボード/マイクロサービスというアプローチによって、並行処理の問題は摘み取れる
- 多くのアクションが影響し合うため予測しにくいものになる
- メッセージ形式/APIの中央リポジトリを配置しておくこと
- メッセージや事実がシステムを通じてやりとりされるさまをトレースできるツール
    - 特定の業務機能が起動された際に固有のトレースIDをう付与する
- トレードオフ
    - メリット：システムの粒度を細かくできるでき、システムを止めることなくアップデートできる
    - デメリット：配備や管理がむすかしくなる
