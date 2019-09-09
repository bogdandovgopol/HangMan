//
//  AppHelper.m
//  HangMan
//
//  Created by Bogdan Dovgopol on 2/9/19.
//  Copyright © 2019 Bogdan Dovgopol. All rights reserved.
//

#import "AppHelper.h"

@implementation AppHelper

+ (FIRFirestore *) db { return [FIRFirestore firestore]; }
+ (FIRAuth *) auth { return [FIRAuth auth]; }

//presenting a simple alertview.
//source: https://developer.apple.com/documentation/uikit/uialertcontroller?changes=l_1&language=objc
+ (void)presentSimpleAlertWithTitle: (NSString*) title Message: (NSString*) message adnViewController: (UIViewController*) vc {
    UIAlertController* alert =
    [UIAlertController alertControllerWithTitle:title
                                        message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* defaultAction =
    [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                           handler:^(UIAlertAction * action) {}];
    
    [alert addAction:defaultAction];
    [vc presentViewController:alert animated:YES completion:nil];
}

+ (BOOL)isValidEmail: (NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:email];
}

@end
