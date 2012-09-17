//
//  ShowViewController.h
//  testDoc
//
//  Created by Zhang Yan on 12-9-12.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "asinetwork/ASIHTTPRequest.h"
#import "MBProgressHUD.h"
@protocol DownLoadFileDelegate
-(NSString *)setFileName;
-(NSURL *)fileURL;
@optional
-(NSString *)setDictionary;
@end

#define DocumentDictionary @"DownloadFile"

@interface DownLoadFileViewController : UIViewController<ASIHTTPRequestDelegate,MBProgressHUDDelegate,UIAlertViewDelegate>
@property (assign, nonatomic) id<DownLoadFileDelegate> delegate;
-(void) clearDoc;

@end
