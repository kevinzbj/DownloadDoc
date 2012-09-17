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
@end

@implementation ViewController
@synthesize fileName;

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

#pragma mark DownLoadFile Delegate
-(NSString *)setFileName
{
    return self.fileName;
}



@end
