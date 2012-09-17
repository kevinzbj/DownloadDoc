//
//  ViewController.h
//  testDoc
//
//  Created by Zhang Yan on 12-9-7.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownLoadFileViewController.h"


@interface ViewController : UIViewController <DownLoadFileDelegate>
- (IBAction)doc:(id)sender;
- (IBAction)xls:(id)sender;
- (IBAction)ppt:(id)sender;
- (IBAction)pdf:(id)sender;
- (IBAction)fakeFile:(id)sender;


@end
