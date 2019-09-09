//
//  SignUpVC.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "SignUpVC.h"

@implementation SignUpVC
@synthesize nameTxt, emailTxt, passwordTxt, confirmPasswordTxt, activityIndicator;


- (void)viewDidLoad {
    [super viewDidLoad];
    //initialize db connection
}

- (IBAction)signUpBtnClicked:(id)sender {
    [activityIndicator startAnimating];
    [self validateFields];
    [self signUpUser];
}

- (IBAction)hasAccountClicked:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)signUpUser {
    //signing up user using firebase auth
    [[AppHelper auth] createUserWithEmail:[emailTxt text] password:[passwordTxt text] completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if(error) {
            [[self activityIndicator] stopAnimating];
            //catch an error while trying to signup and notify user with an alert.
            [AppHelper presentSimpleAlertWithTitle:@"Error" Message:[error localizedDescription] adnViewController:self];
            return;
        }
        //user signed up successfully
        if([authResult user]) {
            NSString *uid = [[authResult user] uid];
            //adding user's name to the firestore DB
            [[[[AppHelper db] collectionWithPath:FIRESTORE_USERS] documentWithPath:uid] setData:@{
                                                                                                  @"fullName": [self.nameTxt text],
                                                                                                  @"score": @0
                                                                                                  } completion:^(NSError * _Nullable error) {
                                                                                                      if (error) {
                                                                                                          //notify user about unsuccessful registration
                                                                                                          [[self activityIndicator] stopAnimating];
                                                                                                          [AppHelper presentSimpleAlertWithTitle:@"Error" Message:[error localizedDescription] adnViewController:self];
                                                                                                      } else {
                                                                                                          //redirect user to MenuVC
                                                                                                          [[self activityIndicator] stopAnimating];
                                                                                                          // redirect to MenuVC
                                                                                                          [[[self presentingViewController] presentingViewController] dismissViewControllerAnimated:YES completion:nil];
                                                                                                      }
                                                                                                  }];
            
        }
    }];
}


//validate fields
- (void)validateFields {
    [self checkIfTextFieldsAreEmpty];
    [self checkIfEmailIsValid];
    [self checkIfPasswordsAreSame];
}

- (void)checkIfTextFieldsAreEmpty {
    //check if fields are empty
    if(![nameTxt hasText] || [[nameTxt text] length] == 0 || ![emailTxt hasText] || [[emailTxt text] length] == 0 || ![passwordTxt hasText] || [[passwordTxt text] length] == 0 || ![confirmPasswordTxt hasText] || [[confirmPasswordTxt text] length] == 0){
        [activityIndicator stopAnimating];
        //user-friendly error notification
        [AppHelper presentSimpleAlertWithTitle:@"Error" Message:@"All fields are required!" adnViewController:self];
        return;
    }
}

- (void)checkIfPasswordsAreSame {
    if(![[passwordTxt text] isEqualToString:[confirmPasswordTxt text]]) {
        [activityIndicator stopAnimating];
        //user-friendly error notification
        [AppHelper presentSimpleAlertWithTitle:@"Error" Message:@"Passwords are not the same!" adnViewController:self];
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
