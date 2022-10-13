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

class Alarm {
    var timer: Timer?
    
    // タイマーのスタート
    func start() {
        print("設定時刻「\(dateFormatter.string(from: Date()))」")
        timer = Timer.scheduledTimer(
            timeInterval: 0.5,  // 秒単位。1にすると現在時刻とタイマーが噛み合わずにならない。
            target: self,
            selector: #selector(alarmSounds),
            userInfo: nil,
            repeats: true
        )
    }
    
    // 0.5秒ごとに実行され条件に合えばアラームが鳴る。
    @objc func alarmSounds() {
        let date = Date()
        // ↓ アラームの指定
        let timeDesignation = calendar.date(bySettingHour: 14, minute: 56, second: 0, of: date)
        // ↓ 下２行「00:00:00」フォーマットに指定
        let currentTime = dateFormatter.string(from: date)
        let setTime = dateFormatter.string(from: timeDesignation ?? date)
        if currentTime == setTime {
            print("ジリリリリ（アラームが鳴りました。）")
            print("アラーム時刻「\(currentTime)」")
            timer?.invalidate()
        }
    }
}

let alarm = Alarm()
alarm.start()

// 実行前にalarmSoundsメソッドのtimeDesignationに設定時間を記述する。
