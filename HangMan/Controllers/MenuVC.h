//
//  MenuVC.h
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SignInVC.h"
#import "GameVC.h"
#import "Constants.h"
#import "AppHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuVC : UIViewController
//properties
@property NSString *mode;
@property int score;

//outlets
@property (weak, nonatomic) IBOutlet UILabel *welcomeTxt;
@property (weak, nonatomic) IBOutlet UILabel *scoreTxt;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;


//actions
- (IBAction)easyModeClicked:(id)sender;
- (IBAction)hardModeClicked:(id)sender;
- (IBAction)logoutClicked:(id)sender;

//support methods
- (void)presentSignInVC;
- (void)isSignedIn;

@end

NS_ASSUME_NONNULL_END
