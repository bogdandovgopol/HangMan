//
//  MenuVC.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "MenuVC.h"

@implementation MenuVC
@synthesize mode, score, welcomeTxt, scoreTxt, activityIndicator;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    [self isSignedIn];
}

//check if user is signed in, not signed in users are redirected to SignInVC
- (void) isSignedIn {
    FIRUser *fireUser = [[AppHelper auth] currentUser];
    if (fireUser) {
        // user is signed in
        //access firestore to get user details
        FIRDocumentReference *docRef =
        [[[AppHelper db] collectionWithPath:FIRESTORE_USERS] documentWithPath:[fireUser uid]];
        [docRef getDocumentWithCompletion:^(FIRDocumentSnapshot *snapshot, NSError *error) {
            if (snapshot.exists) {
                //data successfuly found
                NSDictionary<NSString *, id> *data = snapshot.data;
                
                //update ui
                [[self welcomeTxt] setText:[NSString stringWithFormat:@"Welcome %@", data[@"fullName"]]];
                [[self scoreTxt] setText:[NSString stringWithFormat:@"Your score: %@", data[@"score"]]];
                //remember score value
                NSString *rawScore = data[@"score"];
                self.score = [rawScore intValue];
                
            } else {
                //user-friendly error notification
                [AppHelper presentSimpleAlertWithTitle:@"Error" Message:@"User data not found" adnViewController:self];
            }
        }];
    } else {
        //user is not signed in, redirect to sign in scene
        [self presentSignInVC];
    }
}

//find sognin viewcontroller in authentication stroyboard and present it
- (void)presentSignInVC {
    //get Authentication.storyboard
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:AUTH_STORYBOARD bundle:nil];
    //get SignInVC
    SignInVC *signInController = (SignInVC *)[storyboard instantiateViewControllerWithIdentifier:SIGNINVC_ID];
    //present SognInVC with an animation
    [self presentViewController:signInController animated:NO completion:nil];
}

- (IBAction)easyModeClicked:(id)sender {
    mode = @"easy";
    [self performSegueWithIdentifier:TO_GAME_SEGUE sender:nil];
}

- (IBAction)hardModeClicked:(id)sender {
    mode = @"hard";
    [self performSegueWithIdentifier:TO_GAME_SEGUE sender:nil];
}

//sign out user. docs: https://firebase.google.com/docs/auth/ios/password-auth#next_steps
- (IBAction)logoutClicked:(id)sender {
    [[self activityIndicator] startAnimating];
    
    //sign out
    NSError *signOutError;
    BOOL status = [[AppHelper auth] signOut:&signOutError];
    if (!status) {
        [[self activityIndicator] stopAnimating];
        //user-friendly error notification
        [AppHelper presentSimpleAlertWithTitle:@"Error signing out" Message:[signOutError localizedDescription] adnViewController:self];
        return;
    }
    
    //successfuly logged out
    [[self activityIndicator] stopAnimating];
    //redirect to signin screen
    [self presentSignInVC];
}

//preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    //find segue
    if ([[segue identifier] isEqualToString:TO_GAME_SEGUE])
    {
        //get reference to the destination view controller
        GameVC *vc = [segue destinationViewController];
        
        //pass data to GameVC
        vc.mode = mode;
        vc.score = score;
    }
}
@end
