//
//  ViewController.m
//  AirPlayExample
//
//  Created by Itai Ram on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import <MediaPlayer/MediaPlayer.h>
//#import ""

@interface ViewController ()

@end

@implementation ViewController

@synthesize consoleLog;
@synthesize mainImageView;
@synthesize extImageView;
@synthesize mainWindow;
@synthesize extWindow2;
@synthesize extScreen;
@synthesize availableModes;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    CGRect rect = [UIScreen mainScreen].applicationFrame;
//    self.view = [[UIView alloc] initWithFrame:rect];
//    NSLog(@"rect %@", rect.size.width);
//    NSLog(@"rect %@", rect.size.height);


//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5,5,200,50)];
//    imageView.image = [UIImage imageNamed:@"ScreenOne.png"];
//    [self.view addSubview:imageView];
    
    MPVolumeView *airplayButton = [ [MPVolumeView alloc] init] ;
    [airplayButton setShowsVolumeSlider:NO];
    airplayButton.frame = CGRectMake(10, 10, 40, 40);
    [airplayButton sizeToFit];
    [self.view addSubview:airplayButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 243, 240, 21)];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment = UITextAlignmentCenter; // UITextAlignmentCenter, UITextAlignmentLeft
    label.text = @"Label";
    [self.view addSubview:label];
    
//    UIImage *image = [UIImage imageNamed: @"ScreenOne.png"];
//    UIImageView.image = image;
//    [mainView setImage:image];
//    [self.view addSubview:mainView];
//    [extWindow addSubview:mainView];
    
    mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    mainImageView.image = [UIImage imageNamed:@"ScreenOne.png"];
    
    extImageView = [[UIImageView alloc] initWithFrame:CGRectMake(150, 150, 50, 50)];
    extImageView.image = [UIImage imageNamed:@"ScreenTwo.png"];

//    UIImage *image2 = [UIImage imageNamed: @"ScreenTwo.png"];
//    [extView setImage:image2];
//    [self.view addSubview:extView];
//    [extWindow2 addSubview:mainView];

    // Register for screen connect and disconnect notifications.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidChange:) name:UIScreenDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(screenDidChange:) name:UIScreenDidDisconnectNotification object:nil];
    
    UISwitch *switch1 = [[UISwitch alloc] initWithFrame:CGRectMake(50,50,100,100)];
    [switch1 addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    switch1.on = TRUE;
    [self.view addSubview:switch1];
    
    [self screenDidChange:nil];
}


- (void)screenDidChange:(NSNotification *)notification
{
    
    NSLog(@"*********** screenDidChange");

    NSArray *screens;
    screens = [UIScreen screens];

//    NSLog(@"availableModes %@", [[[screens objectAtIndex:1] availableModes] objectAtIndex: 0]);
 //   UIScreenMode *current = [[[screens objectAtIndex:1] availableModes] objectAtIndex: 0];
//    NSLog(@"current %d", current.size.height);

    
    
    
    //SELECTING LARGEST SCREENSIZE
    CGSize maxSize;
    UIScreenMode *maxScreenMode;
    
    for(int i = 0; i < [[[[UIScreen screens] objectAtIndex:1] availableModes]count]; i++)
    {
        UIScreenMode *current = [[[[UIScreen screens]objectAtIndex:1]availableModes]objectAtIndex:i];
        
        NSLog(@"current.size is %@",NSStringFromCGSize(current.size));

        
        if(current.size.width > maxSize.width)
        {
            maxSize = current.size;
            maxScreenMode = current;
        }
    }
    
    NSLog(@"size of tab is %@",NSStringFromCGSize(maxSize));

    
    
    
    
    
    
    
    
    
    
    
    NSLog(@"screens %@", screens);
    NSUInteger screenCount = [screens count];
    NSLog(@"screenCount %d", screenCount);
    
    if (screenCount > 1) 
    {
        // Select first external screen
        self.extScreen = [screens objectAtIndex:1];    
    }
    else 
    {
        NSLog(@"*********** lalalalalalalalala");

        // Release external screen and window
        self.extScreen = nil;
        self.mainWindow = nil;
        [self externalWindow:self.mainWindow];
    }
}


- (IBAction)switchAction:(id)sender {
        
    NSLog(@"*********** switchAction");

    NSArray *screens;
    screens = [UIScreen screens];
   // NSLog(@"screens %@", screens);
    NSUInteger screenCount = [screens count];
    NSLog(@"screenCount %d", screenCount);
    
    
    if ([sender isOn] == YES)
    {
        //Mirror mode
        NSLog(@"*********** Mirror mode");
        extWindow2 = [[UIWindow alloc] initWithFrame:[[screens objectAtIndex:1] bounds]];
    }
    else 
    {
        //Split Screen mode
        NSLog(@"*********** Split mode");
        extWindow2 = [[UIWindow alloc] initWithFrame:[[screens objectAtIndex:1] bounds]];
      //  extWindow2 = [[UIWindow alloc] initWithFrame:[extScreen bounds]];
        extWindow2.screen = extScreen;
        UIView *view = [[UIView alloc] initWithFrame:[extWindow2 frame]];
        view.backgroundColor = [UIColor blueColor];
        
        //[extWindow2 addSubview:mainImageView];
        
        [view addSubview:mainImageView];
        [view addSubview:extImageView];

        [extWindow2 addSubview:view];
        
        [extWindow2 makeKeyAndVisible];
        self.mainWindow.rootViewController = self;
        [self.mainWindow makeKeyAndVisible];
    }
}

- (void)externalWindow:(UIWindow*)window
{

    NSLog(@"*********** externalWindow");

    [self logMessage:[NSString stringWithFormat:@"External window %@\n", window]];
    self.extWindow2 = window;
}


//- (void)presoMode:(BOOL)isOn
//{
//    
//    NSLog(@"*********** presoMode");
//
//  //  [self logMessage:[NSString stringWithFormat:@"Preso mode %@\n", isOn ? @"on": @"off"]];
// //   self.extWindow2.hidden = YES;
//
//    if (isOn == YES)
//    {
//        //Mirror mode
//        NSLog(@"*********** Mirror mode");
//
//        [extImageView removeFromSuperview];
//        [extWindow2 addSubview:mainImageView];
//    }
//    else {
//        //Split Screen mode
//        NSLog(@"*********** Split mode");
//        [mainImageView removeFromSuperview];
//        [extWindow2 addSubview:extImageView];
//    }
//
//    self.extWindow2.hidden = NO;
//}

- (void) logMessage:(NSString *)message
{
    consoleLog.text = [self.consoleLog.text stringByAppendingString:message];
    [consoleLog scrollRangeToVisible:NSMakeRange([consoleLog.text length], 0)];
}


- (void) logError:(NSError *)error
{
    NSString *message = [NSString stringWithFormat:@"Error: %@ %@\n", [error localizedDescription], [error localizedFailureReason]];
    [self logMessage:message];
}

- (void)viewDidUnload
{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenDidConnectNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIScreenDidDisconnectNotification object:nil];
        [super viewDidUnload];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Do not support UIInterfaceOrientationPortraitUpsideDown if the device is not an iPad.
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone && interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) 
    {
        return NO;
    }
    return YES;
}

@end

