//
//  DeleteAccountVC.h
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/10/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppHelper.h"
#import "Constants.h"
#import "SignInVC.h"
@import Firebase;

NS_ASSUME_NONNULL_BEGIN

@interface DeleteAccountVC : UIViewController
//Properties
@property FIRUser *user;
//Outlets
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxt;

//Actions
- (IBAction)deleteBtn:(id)sender;

//Support methods
- (void)checkIfTextFieldsAreEmpty;
- (void)goBack;
- (void)deleteAccount;
@end

NS_ASSUME_NONNULL_END
