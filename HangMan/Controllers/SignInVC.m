//
//  SignInVC.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "SignInVC.h"

@implementation SignInVC
@synthesize emailTxt, passwordTxt, activityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)signInBtnClicked:(id)sender {
    [self validateFields];
    [self signInUser];
}

//sing in user and redirect to MenuVC
- (void)signInUser {
    [activityIndicator startAnimating];
    //create credentials
    FIRAuthCredential *credential = [FIREmailAuthProvider credentialWithEmail:[emailTxt text] password:[passwordTxt text]];
    //sign in
    [[AppHelper auth] signInWithCredential:credential completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if(error) {
            [[self activityIndicator] stopAnimating];
            //show the error message
            [AppHelper presentSimpleAlertWithTitle:@"Error" Message:[error localizedDescription] adnViewController:self];
            return;
        }
        if([authResult user]) {
            [[self activityIndicator] stopAnimating];
            //redirect to MenuVC
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];

}

- (void)validateFields {
    [self checkIfTextFieldsAreEmpty];
    [self checkIfEmailIsValid];
}

- (void)checkIfTextFieldsAreEmpty {
     //check if fields are empty
    if(![emailTxt hasText] || [[emailTxt text] length] == 0 || ![passwordTxt hasText] || [[passwordTxt text] length] == 0){
        [activityIndicator stopAnimating];
        //user-friendly error notification
        [AppHelper presentSimpleAlertWithTitle:@"Error" Message:@"All fields are required!" adnViewController:self];
        return;
    }
}

- (void)checkIfEmailIsValid {
    BOOL isValid = [AppHelper isValidEmail:[emailTxt text]];
    if(!isValid) {
        [activityIndicator stopAnimating];
        //email is not valid
        //user-friendly error notification
        [AppHelper presentSimpleAlertWithTitle:@"Error" Message:@"Email is not valid" adnViewController:self];
        return;
    }
}
@end
