//
//  NSBundle+AXExtension.m
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import "NSBundle+AXExtension.h"

inline void AXLocalizedLabel(UILabel *label){
    label.text = NSLocalizedString(label.text, nil);
}


inline void AXLocalizedTextView(UITextView *textView){
    textView.text = NSLocalizedString(textView.text, nil);
}

inline void AXLocalizedTextField(UITextField *textField){
    textField.placeholder = NSLocalizedString(textField.placeholder, nil);
    textField.text = NSLocalizedString(textField.text, nil);
}


@implementation NSBundle (AXExtension)

@end
