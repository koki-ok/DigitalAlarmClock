import Foundation  // Timerクラス使用に必要なモジュール
import PlaygroundSupport  // PlaygroundでTimerクラスを使用するのに必要


// デフォルトだとTimerクラスを継続的に処理させることができないため、フラグを変更
// 「PlaygroundPage」：PlaygroundPageとライブビューの状態を構成するために使用するオブジェクト
// 「needsIndefiniteExecution」無期限実行が有効かどうかをBool値で示す
PlaygroundPage.current.needsIndefiniteExecution = true

// アラーム時間の指定に使用するカレンダークラスをインスタンス化()
let calendar = Calendar(identifier: .gregorian)

// デジタル時計と仮定しているので「00:00:00」のフォーマットを指定
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .none
dateFormatter.timeStyle = .medium
dateFormatter.locale = Locale(identifier: "ja_JP")

let date = Date()
// ↓ アラームの指定
let timeDesignation = calendar.date(bySettingHour: 13, minute: 31, second: 0, of: date)
// ↓ 下２行「00:00:00」フォーマットに指定
let currentTime = dateFormatter.string(from: date)
let setTime = dateFormatter.string(from: timeDesignation ?? date)








class Alarm {
    var timer: Timer?
    var count: Int = 0
    var limit: Int = 5
    
    func start() {
        // 任意の箇所でTimerクラスを使用して1秒毎にcountup()メソッドを実行させるタイマーをセット
        timer = Timer.scheduledTimer(
            timeInterval: 1, // タイマーの実行間隔を指定(単位はn秒)
            target: self, // ここは「self」でOK
            selector: #selector(countup), // timeInterval毎に実行するメソッドを指定
            userInfo: nil, // ここは「nil」でOK
            repeats: true // 繰り返し処理を実行したいので「true」を指定
        )
    }

    // Timerクラスに設定するメソッドは「@objc」キワードを忘れずに付与する
    @objc func countup() {
        // countの値をインクリメントする
        count += 1
        print("カウントは\(count)です")
        // countの値がlimitの値以上になったif文を実行
        if limit <= count {
            print("ジリリリリ！(カウントをストップします)")
            // タイマーを止める
            timer?.invalidate()
        }
    }
}

let alarm = Alarm()
alarm.start()
