//
//  SignUpVC.h
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

@interface SignUpVC : UIViewController
//outlets
@property (weak, nonatomic) IBOutlet UITextField *nameTxt;
@property (weak, nonatomic) IBOutlet UITextField *emailTxt;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTxt;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

//actions
- (IBAction)signUpBtnClicked:(id)sender;
- (IBAction)hasAccountClicked:(id)sender;

//support methods
- (void)signUpUser;
- (void)validateFields;
- (void)checkIfTextFieldsAreEmpty;
- (void)checkIfPasswordsAreSame;
- (void)checkIfEmailIsValid;
@end

NS_ASSUME_NONNULL_END
