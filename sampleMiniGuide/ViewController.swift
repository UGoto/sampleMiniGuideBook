//
//  ViewController.swift
//  sampleMiniGuide
//
//  Created by Yuji Yamamoto on 2017/06/19.
//  Copyright © 2017年 Yuji Yamamoto. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var myNavigationItem: UINavigationItem!
    @IBOutlet weak var myTable: UITableView!
//    var guideList = ["Ayala","Moalboal"]
    
    //propatylistから読み込んだdataを格納する配列。
    //[String]→　配列の中身がstring型のデータが入ってくる配列
    
    var placeList:[String] = []
    
    //選択された名前
    var selectedName = ""
//    var selectedName:Int!
    
    
    //TODO:２枚目の画面作成し、タップされたエリア名を２枚目の画面で表示してください（ラベル使用）
    //ヒント：エリア名をそのまま２枚目の画面に渡してください。
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //プロパティリストファイルパスを取得 ここの”placelist”は左のファイル名と同じ名前　”plist”は拡張子
        let filePath = Bundle.main.path(forResource: "placelist", ofType: "plist")
        
        
        //プロパティリストからdataを取得（ディクショナリー型） filePath! はファイルの場所を示している
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        
        //TableViewで扱いやすい配列（エリア名の入っている配列）を作成
        //高速列挙（for文）で値を取得
        for (key,data) in dic!{
//            print("KEY=\(key)")
//            print("DATA=\(data)")
            
            placeList.append(key as! String)
            print(placeList)
            
//        myNavigationItem.title = 
        
        }
        
        
        //printで配列の中身を確認（念のため）
       
    }
    
    //②行数を決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeList.count
    }
    
    //③リストに表示する文字列を決定し表示する
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //表示するセルの中身を作る
        cell.textLabel?.text = placeList[indexPath.row]
        cell.textLabel?.textColor = UIColor.brown
        cell.textLabel?.font = UIFont.systemFont(ofSize:20)
        cell.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        
        return cell
    }
    
    
    //セルをタップした時に、セグエを指定して画面遷移する
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //print("選択されたデータ：\placeList([indexPath.row])") //この中で行番号がわかる
        //表示されているエリア名をメンバ変数に格納

        selectedName = placeList[indexPath.row]
        
        //セグエを指定して画面遷移
        performSegue(withIdentifier: "goSecond", sender: nil )
        
    }
    
    //次の画面へ移動する時にプロパティに選択したエリア名を渡す
    //segueをつけって別画面に移動する時発動
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //①セグエを使って、ボタンを押した瞬間に、これが起動してインスタンス化させる。次の画面のためのインスタンスを生成
        //②SecondViewController の　var pList ="" で　pListの初期値が空であることいっている。
        //移動先の画面のインスタンスを作成
        //セグエは本来、次の画面に遷移できないが、セルを押した瞬間にここでsegueのインスタンスを作る。
    let svc = segue.destination as! SecondViewController
        
        print(placeList)
        
        
        //③値を書き換える。つまり②の空から値を置き換える。
        //移動先の画面のプロパティにエリア名を指定
        //svc.myLabel.text = selectedName　考え方はOKだがインスタンス化されるタイミングがもっとあとなのでエラーになってしまう。
        svc.areaName = selectedName
        
        
        //④SecondViewControllerが起動した際に、③の値が代入されたものが起動する。
        //⑤SecondViewControllerのViewDidLoad以下のところが実行される。

       
        
    }
   


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
    }


}

