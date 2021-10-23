# 柳に雪折れ無し

- コードに柳の枝のような柔軟性をもたせることができれば、雪の重みという外界の変化に負けないようになる

## 分離

- コンポーネント間の結合をできる限り減らすべき
- **分離されたコードは変更しやすい**
- グローバリゼーション
    - 静的なものに潜むわな
- 相続問題
    - サブクラス化が危険な理由
- 気をつけるべき結合の症状
    - 無関係なモジュールやライブラリとの奇妙な依存関係
    - システム中の無関係なモジュールに伝播していく、単一なモジュールへの「シンプル」な変更
    - どういった影響が引き起こされるかわからないため、コードの変更に恐れを抱く開発者
    - 変更によって誰の担当に影響が及ぶかがわからないために全員参加が矯正されるミーティング

### 列車の衝突事故：メソッド呼び出しの連鎖
- コードの変更箇所の判断基準として、責務について考える
- 照会せずに依頼する（TDA, Tell, Don't Ask）
- オブジェクトの内部状態に基づく意思決定をし、その結果で該当オブジェクトを更新してはならない
- あらゆるアプリケーションには普遍的なトップレベルのコンセプトが存在
    - 「顧客」や「注文」など

デルメルの法則：LoD

- クラス「C」に定義されたメソッドは以下のアクセスのみを行うべき
    - C内に定義された他のインスタンスメソッド
    - そのパラメーター
    - スラック上やヒープ内に格納されているオブジェクトに関連づけられているメソッド
    - 大域変数
- **メソッド呼び出しを連鎖させないこと**
- 例外：連鎖させようとしているものが本当に変更される可能性がない場合
    - 言語に付随してくるライブラリとか

連鎖とパイプライン

- データを変換し、ある機能から次の機能に引き渡す
- データの形式は次の機能が受け入れる形式と互換性がなければいけない

### グローバリゼーション

- **大域データを避ける**

大域データにはsingletonも含まれる

- インスタンス変数を保持したSingletonも大域データである

大域データには外部リソースも含まれる

- 大域データにするだけの重要なものである場合、APIでラップする

### 相続問題：サブクラス化が危険な理由

### もう一度：全ては変更についてである

- 結合されたコードの変更は大変
- コードが直接知っていることのみを実行できるようにする

## 実世界を扱う

- レスポンシブなアプリケーション開発

### イベント

- 情報の利用可能性
- イベントに応答するための4つの戦略
    - 有限状態機械（FSM）
    - Observerパターン
    - Publish/Subscribeプロトコル
    - リアクティブプログラミングとストリーム、イベント

### 有限状態機械

- とても簡単である

実践的FSMのススメ

- イベントに対してどのように振る舞うのかを規定したものでしかない
- 一連の状態で構成
    - いずれかが現在の状態
    - イベントごとにシステムが遷移する次の状態が定義されている

アクションの追加

- 純粋なFSMはイベントのストリームに対するパーサー

有限状態機械を出発点に

- あまり開発では活用されていない
- 積極的に活用してほしい

### Observer パターン

- 観測可能イベントの発生源とそのイベントに関連付けられたオブザーバーと呼ばれるクライアントのリストを管理することになる
- オブザーバーは興味のある観測可能な対象に向けて、呼び出してほしい関数への参照を引き渡す
- その後、イベントが発生した場合、その観測可能な対象は、オブザーバーのリストに登録された関数を順番に呼び出していく
- 関数呼び出しにはこのイベント自体が引数として渡される
- 観測可能な対象を作成するためのコードはさほど大きなものではない
- 関数への参照をリストに追加し、イベントが発生した際にこれらの関数を呼び出すだけ
- ライブラリを使わない場合における優れた例
- ユーザーインタフェースシステムにおいて、何らのインタラクションが発生した際にコールバックによってアプリケーションにその旨を知らせるという局面で特に多用される
- オブザーバーは観測可能な対象に登録しないといけないが、結合を導入することになる
- コールバックの実装では観測可能な対象の処理と同じスレッド内でコールバックが逐次的に処理されることになる

PUblish/Subscribeプロトコル

- Observerパターンを一般化すると同時に結合とパフォーマンスの問題を解決する
- パブリッシャーとサブスクライバーを用意する
    - チェンネルを介して接続
        - ライブラリ、プロセス、分散インフラなどコード本体から切り離された形で実装
        - 実装の詳細はコードから隠蔽
        - すべてのチャンネルには名前がつく
    - サブスクライバーはチャンネルの中から興味があるものを登録し、パブリッシャーはイベントをチャンネルに書き込む
    - パブリッシャーとサブスクライバー間の通信はコード以外のところで潜在的かつ非同期に行われる
- pubsubライブラリを使用するのがおすすめ
- アプリケーションを実行中でも既存のコードを変更することなくコードを追加したり変更したりすることができるようになる
- 過度に使用するとどこで問題が起こっているかわからなくなる
- Observerパターンに比べて共有インターフェースを通じた抽象化によって結合を引き下げる素晴らしい例
- イベントの組み合わせに対応するシステムを作るにはさらなる処理が必要

### リアクティブプログラミングとストリーム、イベント

- 他のセルが変わったときに反応（React）する
- ストリームを用いることでイベントをデータのコレクションとして扱える
- 操作や結合、フィルタリングなどデータに対して適用できるすべてのことができる
- 非同期にもできる
- [http://reactivex.io](http://reactivex.io) にてリアクティブなイベント処理における現時点でのデファクトが定義されている

イベントのストリームは非同期のコレクション

- ユーザーリストは静的なもの
- セッションが作成されたときにそのユーザーIDを保持した観測可能イベントを生成し、観測可能なものにする
- 時間を管理対象として扱わなくてもよくなる
- イベントストリームによって一般的かつ扱いやすいAPIの背後で同期処理と非同期処理が実行される

### イベントはユビキタスなもの

- イベントを中心にしたコードは、直列的に処理をしていくコードよりもよりレスポンシブで、より分離したものになる

## 変換のプログラミング

- プログラムは入力を出力に変換するもの
- **プログラミングとはコードについての話であるが、プログラムはデータについての話である**

変換を見つける

- 要求を出発点にして、入力と出力を見極める

`|>`演算子

- パイプライン演算子が利用できる
- 左側に記述されている値を右側に記述されている関数の第一パラメーターに挿入する
- パイプを使用することでデータの変換という観点からものごとを捉えられるようになる

### なぜこれが素晴らしいのか

- 変換をつなぎ合わせただけ
- オブジェクト指向プログラミングであれば、データをカプセル化したくなる
- **状況を溜め込まず、引き渡すようにする**
- データのプールをばらまくのではなく、データを流れとして捉える
- アプリケーションの変換が入力から出力に向かっていく進捗も表現できる

エラーの取り扱い方

- 値とともにその値が有効であるかをラップしたデータ構造または型を作成する
    - HaskellのMaybe、F#やScalaのOption

パイプラインの中で取り扱う

- 関数が変換時のエラー対応という重荷を抱え込んでいる
- エラーが発生した場合にパイプラインの下流にあるコードを実行せず、それらコードにエラーの発生を意識させたくない
- 束縛関数
    - 何かをラップした値を受け取り、その値に対して関数を適用し、新たにラップした値を返す

### 変換によるプログラミングがもたらす意識の変換

- コードを変換の連続と捉える
- よりクリーンに、関数は短く、設計もフラットなものになる

## インヘリタンス（相続）税

- 継承を伝っているのであれば今すぐ手を止めてください

### 背景

- 継承が登場したのは1969年のSimula 67
- 同一リストに存在してるさまざまな型のイベントを待ち行列に入れる際の問題に対するソリューション
    - 前置クラス

```python
link CLASS car;

link CLASS bycycle;
```

- linkは連結リストの機能を追加する前置クラス
- クラスlinkのインスタンスデータと実装はcarとbycycleクラスの実装のふりをする
- linkは自動車と自転車を内包するコンテナ
    - ポリモーフィズム
- Simulaの次のSmalltalk
    - 振る舞いにのみ着目したサブクラス化
- SimulaアプローチはC++やJava
- SmalltalkはRubyやJavascript
- タイピングが嫌いな人
    - UserとProductクラスをActiveRecord::Baseのサブクラスにしてタイピング入力を節約
- タイプが好きな人
    - Car is-a Vehicleのように関係を表す

### コード共有のために継承を使う場合の問題点

- 継承は結合

型の構築のために継承を使う場合の問題点

- 階層が階層を呼び、クラス間の微妙な違いを書き足さないといけない
- この複雑さでアプリケーションは脆いものとなり、変更が多くのレイヤーをまたがり、切り裂く
- 多重継承の問題
- C++は多重継承のあいまいさを解消するために不自然なセマンティックスを導入した結果、多重継承の悪名を高めた
- **イヘリタンス（相続）税を払わないこと**

### 優れた代替が存在する

- インターフェイスとプロトコル
- 委譲
- mixinとtrait

インターフェイスとプロトコル

- ほとんどのオブジェクト指向言語は１つ以上の振る舞いの集合を実装するクラスの定義が可能i
- インターフェイスとプロトコルは型として扱え、実装しているあらゆるクラスがその型と互換性があるものになる
- **ポリモーフィズムの表現にはインターフェースを愛用すること**

委譲

- 継承により、親クラスにメソッドがたくさんできてしまう場合がある
- **サービスに移譲すること：has-aはis-aに勝る**
- 結合を分離しても、より多くのコードを記述するコストが発生する