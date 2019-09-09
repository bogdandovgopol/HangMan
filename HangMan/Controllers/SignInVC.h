//
//  SignInVC.h
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppHelper.h"
#import "Constants.h"
#import "MenuVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface SignInVC : UIViewController
//Outlets
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

//Actions
- (IBAction)signInBtnClicked:(id)sender;

//support methods
- (void)signInUser;
- (void)validateFields;
- (void)checkIfTextFieldsAreEmpty;
- (void)checkIfEmailIsValid;

@end

NS_ASSUME_NONNULL_END
