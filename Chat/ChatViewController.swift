//
//  ChatViewController.swift
//  Chat
//
//  Created by Masato Hayakawa on 2019/02/18.
//  Copyright © 2019 masappe. All rights reserved.
//

import UIKit
import Firebase
import CoreGraphics

class ChatViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    //データベースへの参照
    var rootRef = Database.database().reference()
    var id:String!
    var NameArray = [String]()
    var textArray = [String]()
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var sendTextField: UITextField!
    @IBOutlet weak var IDLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //データの呼び出し
        rootRef.observeSingleEvent(of: .value, with: {(snap:DataSnapshot) in
            //Srting:NSDictionary型でキャストダウン
            let snapdata = snap.value as! [String:NSDictionary]
            //dataが存在しなかったらreturn
            if snap.childrenCount == 0 {
                return
            }
            //データを配列の先頭に格納
            for key in snapdata.keys.sorted(){
                let data = snapdata[key]
                let username = data!["username"] as! String
                let post = data!["post"] as! String
                self.NameArray.insert(username, at: 0)
                self.textArray.insert(post, at: 0)
                
            }
            //tableviewの更新
            self.table.reloadData()
            //スクロールを一番上にする
            let indexPath = IndexPath(row: 0, section: 0)
            self.table.scrollToRow(at: indexPath, at: .bottom, animated: false)

            })
//        なにかあるたびに毎回呼ばれる
//        rootRef.observe(.value){(snap: DataSnapshot) in
//            let snapdata = snap.value as! [String:NSDictionary]
//            for key in snapdata.keys.sorted(){
//                let data = snapdata[key]
//                let username = data!["username"] as! String
//                let post = data!["post"] as! String
//                print(username)
//                print(self.NameArray)
//                self.NameArray.append(username)
//                self.textArray.append(post)
//                self.dataArray[username] = post
//                print(self.dataArray)
//            }
//            print(snap.value!)
//            let snapdata = snap.value as! [String:NSDictionary]
//            print(snapdata.keys)
//            for key in snapdata.keys.sorted(){
//                let text = snapdata[key]
//                print(text)
//                print("post:\(text!["post"])")
//                print("username:\(text!["username"])")
//            }
//        }
        
        sendTextField.placeholder = "What is your current feelings"
        //テーブルを反転
//        self.table.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
        self.view.backgroundColor = UIColor(red: 71/255, green: 234/255, blue: 126/255, alpha: 1)
        //nibオブジェクト
        let nib = UINib(nibName: "OriginalTableViewCell", bundle: nil)
        //nibファイルの登録，cellが呼ばれる前にcellに対してnibを登録する
        //nibファイルの指定と表示する場所のcellの指定
        self.table.register(nib, forCellReuseIdentifier: "OriginalCell")
        if id == ""{
            id = "匿名メンター"
            IDLabel.text = "ID:匿名メンター"
        }else{
            IDLabel.text = "ID:\(id!)"
        }
        table.delegate = self
        table.dataSource = self
        sendTextField.delegate = self
    }
    
//    @IBAction func test(_ sender: Any) {
//        //データの書き込み
//        //childByAutoId()で何かしたのキーを新しく作成する
//        //childByAutoId()sで新しいキーを作成，それに対して並列にchildを作成
//        let newRef = rootRef.childByAutoId()
//        let postRef = newRef.child("post")
//        postRef.setValue("Snow")
//        let nameRef = newRef.child("username")
//        nameRef.setValue("hello")
//    }
    
    //表示するcellの量を表す
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NameArray.count
    }
    
    //表示するcellのデータ
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OriginalCell") as? OriginalTableViewCell
        cell?.cellNameLabel.text = NameArray[indexPath.row]
        cell?.cellTextLabel.text = textArray[indexPath.row]
        //cellを反転させる
//        cell?.transform = CGAffineTransform(a: 1, b: 0, c: 0, d: -1, tx: 0, ty: 0)
        return cell!
    }

    @IBAction func send(_ sender: Any) {
        senddata()
    }
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        senddata()
        return true
    }
    
    func senddata(){
        if  !("" == sendTextField.text){
            let value = sendTextField.text!
            textArray.insert(value, at: 0)
            NameArray.insert(id, at: 0)
            let newRef = rootRef.childByAutoId()
            let postRef = newRef.child("post")
            postRef.setValue(value)
            let nameRef = newRef.child("username")
            nameRef.setValue(id)
            sendTextField.text = ""
            table.reloadData()
            let indexPath = IndexPath(row: 0, section: 0)
            self.table.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }else{
            let alert = UIAlertController(title: "Error", message: "送信する文章がありません", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }

    }
}
