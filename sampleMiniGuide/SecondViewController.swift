//
//  SecondViewController.swift
//  sampleMiniGuide
//
//  Created by Yuji Yamamoto on 2017/06/19.
//  Copyright © 2017年 Yuji Yamamoto. All rights reserved.
//

import UIKit
import MapKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var myTextView: UITextView!
 
    @IBOutlet weak var myImageView: UIImageView!
    
    @IBOutlet weak var myMapView: MKMapView!
    
    
    var areaName = ""
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("前の画面から選択された行\(areaName)")
        
        
        //プロパティリストファイルパスを取得 ここの”placelist”は左のファイル名と同じ名前　”plist”は拡張子
        let filePath = Bundle.main.path(forResource: "placelist", ofType: "plist")
        
        
        //プロパティリストからdataを取得（ディクショナリー型） filePath! はファイルの場所を示している
        let dic = NSDictionary(contentsOfFile: filePath!)
        
        //指定されたエリア名をキーにして、場面に必要な情報を取得
        let detailInfo:NSDictionary = dic![areaName] as! NSDictionary
        
//        print(detailInfo["image"] as! String)
//        print(detailInfo["description"] as! String)
//        print(detailInfo["latitude" as! String])
//        print(detailInfo["longitude" as! String])
        
        
        
        //textとimageがこれで出力される
        myTextView.text = detailInfo["description"] as! String
        myImageView.image = UIImage(named:detailInfo["image"] as! String)
      
        
        //中心となる場所の座標軸を作成する
        //例アヤラを中心にする
        //このカッコの中はdouble型にならないといけない
        let long:Double = Double(detailInfo["longitude"] as! String)!
        let lati:Double = Double(detailInfo["latitude"] as! String)!
        
        let coordinate = CLLocationCoordinate2DMake(lati,long)
        
        //縮尺を設定する
        let span = MKCoordinateSpanMake(0.025, 0.025)
        
        //範囲オブジェクトを作成(範囲を知らせるために必要)
        let region = MKCoordinateRegionMake(coordinate,span)
        
        //MapViewに範囲オブジェクトを設定
        myMapView.setRegion(region, animated: true)
        
        
        //アヤラにピンを立てる
        //ピン生成
        let myPin = MKPointAnnotation()
        
        //ピンの座標を生成する
        myPin.coordinate = coordinate
        //        myPin.coordinate = CLLocationCoordinate2DMake(10.317347, 123.905759) ←こういう書き方もできる
        
//        //タイトル・サブタイトルの設定、選択すると吹き出しが出る
//        myPin.title = "アヤラ"
//        myPin.subtitle = "おすすめ"
//        
//        itPin.title = "ITパーク"
//        itPin.subtitle = "近くの都会？"
//        
//        waterPin.title = "ウォーターフロント"
//        waterPin.subtitle = "ギャンブルするなら"
        
        //MapViewにピンを追加する
        myMapView.addAnnotation(myPin)
        
    
        }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
 
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
