//
//  ViewController.swift
//  Combo_TableView
//
//  Created by teacher on 2016/10/24.
//  Copyright © 2016年 teacher. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var table: UITableView!
    let values = ["たくみ", "しらさぎ", "こながい"]
    var buttonFlag = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //リストの登録と設定
        table.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        table.isHidden = true
        
        //データソースとデリゲートの登録
        table.dataSource = self
        table.delegate = self
        textField.delegate = self
        
        //アクション時のターゲットを設定
        button.addTarget(self, action: #selector(buttonTapped(sender:)), for: .touchDown)
        listButton.addTarget(self, action: #selector(listButtonTapped(sender:)), for: .touchDown)
        
        //ビューに追加
        view.addSubview(textField)
        view.addSubview(table)
        view.addSubview(button)
        view.addSubview(listButton)
    }
    
    //送信ボタン用関数
    func buttonTapped(sender: UIButton){
        let textResult: String
        
        //変数にテキストフィールドの値を格納
        textResult = textField.text!
        
        //アラートの登録と設定
        let alertController: UIAlertController = UIAlertController(title: "結果", message: textResult, preferredStyle: .alert)
        
        //アラートのボタンの設定
        let OK = UIAlertAction(title: "OK", style: .default){
            action in
            print("OK")
        }
        //アラートのOKボタンをアクションに追加
        alertController.addAction(OK)
        //アラートをビューに登録
        present(alertController, animated: true, completion: nil)
    }
    
    //リストビュー表示用関数
    func listButtonTapped(sender: UIButton){
        //▼を押すごとにリストの表示非表示を設定
        if(buttonFlag == 0){
            table.isHidden = false
            buttonFlag = 1
        }else {
            table.isHidden = true
            buttonFlag = 0
        }
    
    }
    
    //データソース
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //UITabkeViewに登録されているデータの値を返す
        return values.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //UITableViewのセルにデータを設定する
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        
        cell.textLabel!.text = "\(values[indexPath.row])"
        
        return cell
    }
    
    //デリゲート
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //UITableViewのセルがタップされたときの動作
        textField.text = values[indexPath.row]
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //UITextFieldの編集が開始される直前
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //UITextFieldが編集が開始された直後

    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        //UITextFieldの編集が終了される直前
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        //UITextFieldの編集が終了された直後
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //キーボードのReturnまたは改行キーが押される直前
        textField.resignFirstResponder()
        self.viewDidLoad()
        return true
    }
}

