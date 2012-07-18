//
//  View.h
//  Jul19
//
//  Created by Dominick Ciano on 7/18/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;

@interface View: UITextView  <UITextFieldDelegate>{
	ViewController *viewController;
	UITextField *textField;
	UILabel *label;	
}

- (id) initWithFrame: (CGRect) frame controller: (ViewController *) c;
@end