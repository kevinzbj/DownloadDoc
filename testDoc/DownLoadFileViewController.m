//
//  ShowViewController.m
//  testDoc
//
//  Created by Zhang Yan on 12-9-12.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import "DownLoadFileViewController.h"

@interface DownLoadFileViewController ()
@property (retain, nonatomic) ASIHTTPRequest *request;
@property (retain, nonatomic) UIWebView *webView;
@property (retain, nonatomic) MBProgressHUD *hud;
@property (assign, nonatomic) NSString *dictionary;
@end

@implementation DownLoadFileViewController
@synthesize request = _request;
@synthesize webView = _webView;
@synthesize hud = _hud;
@synthesize dictionary = _dictionary;
@synthesize delegate;


-(void)dealloc
{
    [_request release];
    [_webView release];
    [_hud release];
    [super dealloc];
}

-(MBProgressHUD *)hud
{
    if(!_hud)
    {
        _hud = [[MBProgressHUD alloc] init];
        _hud.mode = MBProgressHUDModeAnnularDeterminate;
        _hud.delegate = self;
        _hud.labelText = @"下载中";

    }
    return _hud;
}

- (UIWebView *)webView
{
    if(_webView == nil)
    {
        _webView = [[UIWebView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
        _webView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    }
    return _webView;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = nil;
	// Do any additional setup after loading the view.
    if([self.delegate respondsToSelector:@selector(setDictionary)])
    {
        self.dictionary = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[[DocumentDictionary stringByAppendingPathComponent:[self.delegate setDictionary]] stringByAppendingPathComponent:[self.delegate setFileName]]];
        documentsDirectory = [[[path objectAtIndex:0] stringByAppendingPathComponent:DocumentDictionary] stringByAppendingPathComponent:[self.delegate setDictionary]];
    }else{
        self.dictionary = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[DocumentDictionary stringByAppendingPathComponent:[self.delegate setFileName]]];
        
        documentsDirectory = [[[path objectAtIndex:0] stringByAppendingPathComponent:DocumentDictionary] stringByAppendingPathComponent:[self.delegate setDictionary]];
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    [self.webView addSubview:self.hud];
    [self initFile];
    [self.view addSubview:self.webView];
}

-(void) viewWillDisappear:(BOOL)animated
{
    [self.request cancel];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark Handle Files

- (void) initFile
{
    if([self checkFile])
    {
        [self readLocalDoc];
    }else
    {
        self.request = [ASIHTTPRequest requestWithURL:[self.delegate fileURL]];
        [self.request setDelegate:self];
        [self.request setDownloadDestinationPath:self.dictionary];
        [self.request setDownloadProgressDelegate:self.hud];
        [self.request startAsynchronous];
        [self.hud show:YES];
    }
}

-(BOOL) checkFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:self.dictionary];
}

-(void) readLocalDoc
{
    NSURL *url = [NSURL fileURLWithPath:self.dictionary];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    self.webView.scalesPageToFit = YES;
}

-(void) deleteFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:self.dictionary error:nil];
}

-(void) clearDoc
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:DocumentDictionary];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
}

#pragma mark ASIHTTPRequest Delegate
- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self.hud hide:YES];
    if([request responseStatusCode] == 404)
    {
        //删除文件
        [self deleteFile];
        UIAlertView* aview = [[UIAlertView alloc] initWithTitle:@"错误" message:@"文件不存在" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [aview show];
        [aview release];
    }
    else if([request responseStatusCode] == 200)
    {
        [self readLocalDoc];
    }
}


-(void)requestFailed:(ASIHTTPRequest *)request
{
    [self.hud hide:YES];
    if([[request error] code] == 1)
    {
        UIAlertView* aview = [[UIAlertView alloc] initWithTitle:@"错误" message:@"下载失败，无网络" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
        [aview show];
        [aview release];
    }
    
}
#pragma mark Alert Delegate
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
