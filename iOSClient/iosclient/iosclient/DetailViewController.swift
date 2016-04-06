//
//  DetailViewController.swift
//  iosclient
//
//  Created by 典 杨 on 16/3/30.
//  Copyright © 2016年 典 杨. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation


class DetailViewController: UIViewController {
    
    @IBOutlet weak var labelTitle: UILabel!
    
    var courseTitle: String!
    var courseDescription: String!
    var courseImage: UIImage!
    var courseVideoUrl: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let screenSize : CGRect = UIScreen.mainScreen().bounds;
        labelTitle.text = courseTitle

        //play online video
        if (courseVideoUrl != nil){
            let videoURL = NSURL(string: courseVideoUrl)
            let player = AVPlayer(URL: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.player = player
            playerViewController.view.frame = CGRectMake(0, 110, screenSize.width, 300)
            self.addChildViewController(playerViewController)
            self.view.addSubview(playerViewController.view)
            playerViewController.player!.play()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //分享文本
    func sendText(text:String, inScene: WXScene)->Bool{
        let req=SendMessageToWXReq()
        req.text=text
        req.bText=true
        req.scene=Int32(inScene.rawValue)
        return WXApi.sendReq(req)
    }
    
    //分享视频
    func sendVideo(title: String, description: String, image: UIImage, url: String, inScene: WXScene) {
        let message =  WXMediaMessage()
        message.title = title
        message.description = description
        message.setThumbImage(image)
        
        let ext =  WXVideoObject()
        ext.videoUrl = url
        message.mediaObject = ext
        
        let req =  SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = Int32(inScene.rawValue)
        WXApi.sendReq(req)
    }
    
    
    
    @IBAction func shareBtn(sender: AnyObject) {
        //sendText("这是来自学啥iOS端的分享", inScene: WXSceneSession) //分享文本到朋友圈
        sendVideo(courseTitle, description: courseDescription, image: courseImage, url: courseVideoUrl, inScene: WXSceneSession)
        
        /*
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.barButtonItem = (sender as! UIBarButtonItem)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection()
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        // Anything you want to exclude
        activityViewController.excludedActivityTypes = [
            UIActivityTypePostToWeibo,
            UIActivityTypePrint,
            UIActivityTypeAssignToContact,
            UIActivityTypeSaveToCameraRoll,
            UIActivityTypeAddToReadingList,
            UIActivityTypePostToFlickr,
            UIActivityTypePostToVimeo,
        ]
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
         */
    }
    
    
    
    
}