//
//  ViewController.m
//  testDoc
//
//  Created by Zhang Yan on 12-9-7.
//  Copyright (c) 2012年 Zhang Yan. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (assign, nonatomic) NSString *fileName;
@property (assign, nonatomic) NSString *fileURL;
@end

@implementation ViewController
@synthesize fileName;
@synthesize fileURL;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (void)dealloc {
    [super dealloc];
}

-(void)showFile:(NSString *)filename
{
    DownLoadFileViewController *show = [[DownLoadFileViewController alloc] init];
    [show setDelegate:self];
    self.fileName = filename;
    show.title = filename;
    [self.navigationController pushViewController:show animated:YES];
    [show release];
}


- (IBAction)doc:(id)sender {
    [self showFile:@"newhelp.doc"];
}

- (IBAction)xls:(id)sender {
    [self showFile:@"x.xls"];
}

- (IBAction)ppt:(id)sender {
    [self showFile:@"ptest.ppt"];
}

- (IBAction)pdf:(id)sender {
    [self showFile:@"oc.pdf"];
}

- (IBAction)fakeFile:(id)sender {
    [self showFile:@"test.test"];
}

- (IBAction)clear:(id)sender {
    DownLoadFileViewController *show=[[DownLoadFileViewController alloc] init];
    [show clearDoc];
    [show release];
}

#pragma mark DownLoadFile Delegate
-(NSString *)setFileName
{
    return self.fileName;
}

-(NSURL *)fileURL
{
    return [NSURL URLWithString:[NSString stringWithFormat:@"http://211.100.76.72:8010/%@",self.fileName]];
}

-(NSString *)setDictionary
{
    return @"test";
}



@end
