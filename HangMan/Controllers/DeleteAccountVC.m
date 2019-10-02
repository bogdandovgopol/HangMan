//
//  DeleteAccountVC.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/10/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "DeleteAccountVC.h"

@implementation DeleteAccountVC
@synthesize passwordTxt, activityIndicator, user;

- (void)viewDidLoad {
    [super viewDidLoad];
    //get current user
    user = [[AppHelper auth] currentUser];
}

//delete an account. docs: https://firebase.google.com/docs/auth/ios/manage-users#delete_a_user
- (IBAction)deleteBtn:(id)sender {
    [activityIndicator startAnimating];
    //create credentials
    FIRAuthCredential *credentials = [FIREmailAuthProvider credentialWithEmail:[user email] password:[passwordTxt text]];
    //reauthenticate user
    [user reauthenticateWithCredential:credentials completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
        if(error){
            [[self activityIndicator] stopAnimating];
            //user-friendly error notification
            [AppHelper presentSimpleAlertWithTitle:@"Cannot delete an account" Message:[error localizedDescription] adnViewController:self];
            return;
        }
        
        //delete account
        [self deleteAccount];
    }];
}

- (void)deleteAccount {
    //delete account
    [user deleteWithCompletion:^(NSError *_Nullable error) {
        if (error) {
            [[self activityIndicator] stopAnimating];
            //user-friendly error notification
            [AppHelper presentSimpleAlertWithTitle:@"Cannot delete an account" Message:[error localizedDescription] adnViewController:self];
        } else {
            //account deleted.
            //delete data from db/firestore. docs: https://firebase.google.com/docs/firestore/manage-data/delete-data#delete_documents
            [[[[AppHelper db] collectionWithPath:FIRESTORE_USERS] documentWithPath:[[self user] uid]]
             deleteDocumentWithCompletion:^(NSError * _Nullable error) {
                 if (error != nil) {
                     [[self activityIndicator] stopAnimating];
                     //user-friendly error notification
                     [AppHelper presentSimpleAlertWithTitle:@"Error removing data" Message:[error localizedDescription] adnViewController:self];
                 } else {
                     //data removed
                     [[self activityIndicator] stopAnimating];
                     //redirect to signin screen
                     [self presentSignInVC];
                 }
             }];
        }
    }];
}

- (void)checkIfTextFieldsAreEmpty {
     //check if fields are empty
    if(![passwordTxt hasText] || [[passwordTxt text] length] == 0){
        [activityIndicator stopAnimating];
        //user-friendly error notification
        [AppHelper presentSimpleAlertWithTitle:@"Error" Message:@"All fields are required!" adnViewController:self];
        return;
    }
}

//find sognin viewcontroller in authentication stroyboard and present it
- (void)presentSignInVC {
    //get Authentication.storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:AUTH_STORYBOARD bundle:nil];
    //get SignInVC
    SignInVC *signInController = (SignInVC *)[storyboard instantiateViewControllerWithIdentifier:SIGNINVC_ID];
    //go back to menuVC
    [[self navigationController] popToRootViewControllerAnimated:YES];
}
@end
