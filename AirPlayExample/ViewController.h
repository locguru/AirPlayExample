//
//  ViewController.h
//  AirPlayExample
//
//  Created by Itai Ram on 7/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController {
    
    UITextView			*consoleLog;
	UIImageView			*mainImageView;
	UIImageView			*extImageView;
    
    UIWindow			*mainWindow;
    UIWindow			*extWindow2;    

    UIScreen			*extScreen;
	NSArray				*availableModes;
}

@property (nonatomic, retain) IBOutlet UITextView *consoleLog;
@property (nonatomic, retain) IBOutlet UIImageView *mainImageView;
@property (nonatomic, retain) IBOutlet UIImageView *extImageView;
@property (nonatomic, retain) UIWindow *mainWindow;
@property (nonatomic, retain) UIWindow *extWindow2;
@property (nonatomic, retain) UIScreen *extScreen;
@property (nonatomic, retain) NSArray *availableModes;

- (IBAction)barButtonAction:(id)sender;


@end
