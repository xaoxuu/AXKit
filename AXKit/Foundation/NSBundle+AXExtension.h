//
//  NSBundle+AXExtension.h
//  AXKit
//
//  Created by xaoxuu on 25/04/2017.
//  Copyright © 2017 Titan Studio. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 将UILabel中的文字转换成NSLocalizedString

 @param label 目标UILabel
 */
FOUNDATION_EXTERN void AXLocalizeLabel(UILabel *label);

/**
 将UITextView中的文字转换成NSLocalizedString
 
 @param textView 目标UITextView
 */
FOUNDATION_EXTERN void AXLocalizeTextView(UITextView *textView);

/**
 将UITextField中的文字转换成NSLocalizedString
 
 @param textField 目标UITextField
 */
FOUNDATION_EXTERN void AXLocalizeTextField(UITextField *textField);


/**
 将view里所有的UILabel中的文字转换成NSLocalizedString（含所有子视图）

 @param view 目标view
 */
FOUNDATION_EXTERN void AXLocalizeAllLabelsInView(UIView *view);

/**
 将view里所有的UITextField中的文字转换成NSLocalizedString（含所有子视图）
 
 @param view 目标view
 */
FOUNDATION_EXTERN void AXLocalizeAllTextFieldsInView(UIView *view);

/**
 将view里所有的UITextView中的文字转换成NSLocalizedString（含所有子视图）
 
 @param view 目标view
 */
FOUNDATION_EXTERN void AXLocalizeAllTextViewsInView(UIView *view);

/**
 将view里所有的控件中的文字转换成NSLocalizedString（含所有子视图中的所有控件）
 
 @param view 目标view
 */
FOUNDATION_EXTERN void AXLocalizeAllSubviewsInView(UIView *view);

@interface NSBundle (AXExtension)



@end
