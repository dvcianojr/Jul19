//
//  View.m
//  Jul19
//
//  Created by Dominick Ciano on 7/18/12.
//  Copyright (c) 2012 Abel / Noser Corp. All rights reserved.
//

#import "View.h"
#import "ViewController.h"

@implementation View


- (id) initWithFrame: (CGRect) frame controller: (ViewController *) c {
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor whiteColor];
		self.editable = NO;	//Don't pop up a keyboard.
		self.font = [UIFont fontWithName: @"Courier" size: 14]; //monospace
		viewController = c;
		
		
		
		CGFloat height = [@"A" sizeWithFont: self.font].height;
		
		//Center the UITextField in the TextFieldView.
		CGRect b = self.bounds;
		
		CGRect f = CGRectMake(
							  b.origin.x,
							  b.origin.y + 30,
							  480,//b.size.width,
							  height
							  );
		
		textField = [[UITextField alloc] initWithFrame: f];
		textField.borderStyle = UITextBorderStyleNone;	//default
		textField.backgroundColor = [UIColor yellowColor];
		textField.textColor = [UIColor blackColor];
		
		textField.clearButtonMode = UITextFieldViewModeAlways;
		textField.keyboardType = UIKeyboardTypeDefault;
		textField.returnKeyType = UIReturnKeyDone;
		
		textField.font = self.font;
		textField.placeholder = @"      <Enter stock symbol here>";
		textField.textAlignment = UITextAlignmentLeft;	//default
		textField.autocapitalizationType = UITextAutocapitalizationTypeNone; //default
		textField.autocorrectionType = UITextAutocorrectionTypeNo;
		textField.secureTextEntry = NO;	//for secret passwords
		
		textField.delegate = self;
		
		
		f = CGRectMake(
					   b.origin.x,
					   b.origin.y,// + textField.bounds.size.height + 10,
					   480,//b.size.width,
					   30//height
					   );
		
		label = [[UILabel alloc] initWithFrame: f];
		label.backgroundColor = [UIColor redColor];
		label.font = [UIFont fontWithName: @"Courier-Bold" size: 16];
		label.textColor = [UIColor whiteColor];
		label.text = viewController.text;
		[self addSubview: label];	
		[self addSubview: textField];	
	}
	return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.

- (void) drawRect: (CGRect) rect
{
	// Drawing code
	
	// get IBM price from yahoo finance URL
	NSString *urlGetString =@"http://finance.yahoo.com/d/quotes.csv?s=";
	urlGetString = [urlGetString stringByAppendingFormat:
					@"%@&f=sd1t1l1ohgpjkee7e8e9dyqr1b4rp5p6a2n",viewController.symKey];
	NSURL *url = [[NSURL alloc] initWithString: urlGetString];
	NSError *err;
	NSString *sData = [[NSString alloc]
					   initWithContentsOfURL: url
					   encoding: NSUTF8StringEncoding
					   error: &err
					   ];
		
	self.text = [viewController.text stringByAppendingString: @"\n"];
	UIView *v = self;
	if (v != nil)
	{
		if (sData == nil) 
			self.text = [err localizedDescription]; // display error message
		else 
		{
			// TODO:parse data
			NSArray *components = [sData componentsSeparatedByString:@","];
			NSString *sym = [components objectAtIndex:0];	
			sym = [sym substringWithRange: NSMakeRange (1, sym.length - 2)];//remove double quotes
			NSString *date = [components objectAtIndex:1];
			date = [date substringWithRange: NSMakeRange (1, date.length - 2)];//remove double quotes
			NSString *time = [components objectAtIndex:2];
			time = [time substringWithRange: NSMakeRange (1, time.length - 2)];//remove double quotes
			NSString *lastPrice = [components objectAtIndex:3];
			NSString *open  = [components objectAtIndex:4];
			NSString *high  = [components objectAtIndex:5];
			NSString *low   = [components objectAtIndex:6];
			NSString *close = [components objectAtIndex:7];
			NSString *fiftyTwoWeekLow = [components objectAtIndex:8];
			NSString *fiftyTwoWeekHigh = [components objectAtIndex:9];
			NSString *eps = [components objectAtIndex:10];
			NSString *epsEstCurrYr  = [components objectAtIndex:11];
			NSString *epsEstNextYr  = [components objectAtIndex:12];
			NSString *epsEstNextQtr = [components objectAtIndex:13];
			NSString *div = [components objectAtIndex:14];
			NSString *divYield = [components objectAtIndex:15];
			NSString *exDivDate = [components objectAtIndex:16];
			exDivDate = [exDivDate substringWithRange: NSMakeRange (1, exDivDate.length - 2)];//remove double quotes			
			NSString *divPayDate = [components objectAtIndex:17];
			divPayDate = [divPayDate substringWithRange: NSMakeRange (1, divPayDate.length - 2)];//remove double quotes				
			NSString *bookValue = [components objectAtIndex:18];
			NSString *peRatio = [components objectAtIndex:19];
			NSString *priceToSalesRatio = [components objectAtIndex:20];			
			NSString *priceToBookRatio = [components objectAtIndex:21];	
			NSString *avgDailyVol = [components objectAtIndex:22];
			NSString *companyName = [components objectAtIndex:23];
			companyName = [companyName substringWithRange: NSMakeRange (1, companyName.length - 4)];//remove double quotes
			
			// format adv with commas			
			NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init]; // Create formatter 
			[formatter setNumberStyle:NSNumberFormatterDecimalStyle]; // Set to decimal style with commas
			NSNumber *nADV = [NSNumber numberWithDouble:([avgDailyVol doubleValue])];
			NSString *formattedADV = [formatter stringForObjectValue: nADV];
			
			// display data according to view	
			if ([viewController.viewTitle isEqualToString: @"Prices"])
				self.text = [self.text stringByAppendingFormat:
							 @"\n\nSymbol: %@ at %@ on %@\n\nLast        : %@\nOpen        : %@\nHigh        : %@\nLow         : %@\nClose       : %@\n52 Week Low : %@\n52 Week High: %@",sym,time,date,lastPrice,open,high,low,close,fiftyTwoWeekLow,fiftyTwoWeekHigh];
			else if ([viewController.viewTitle isEqualToString: @"Earnings"])
				self.text = [self.text stringByAppendingFormat:
							 @"\n\nSymbol: %@ at %@ on %@\n\nEPS Reported    : %@\nEPS Est Curr Yr : %@\nEPS Est Next Qtr: %@\nEPS Est Next Yr : %@",sym,time,date,eps,epsEstCurrYr,epsEstNextQtr,epsEstNextYr];
			else if ([viewController.viewTitle isEqualToString: @"Dividends"])
				self.text = [self.text stringByAppendingFormat:
							 @"\n\nSymbol: %@ at %@ on %@\n\nDiv         : %@\nDiv Yield   : %@\nEx-Div Date : %@\nDiv Pay Date: %@",sym,time,date,div,divYield,exDivDate,divPayDate];
			else if ([viewController.viewTitle isEqualToString: @"Fundamentals"])
				self.text = [self.text stringByAppendingFormat:
							 @"\n\nSymbol: %@ at %@ on %@\nName  : %@...\n\nLast Price          : %@\nEPS                 : %@\nDiv                 : %@\nBook Value          : %@\nP/E Ratio           : %@\nDiv Yield           : %@\nPrice to Sales Ratio: %@\nPrice to Book Ratio : %@\nAvg Daily Vol       : %@\n",sym,time,date,companyName,lastPrice,eps,div,bookValue,peRatio,divYield,priceToSalesRatio,priceToBookRatio,formattedADV];
			else if ([viewController.viewTitle isEqualToString: @"Charts"])
				self.text = [self.text stringByAppendingFormat:
							 @"\n\nSymbol: %@ at %@ on %@\n\n\n",sym,time,date];	 
		}
	}

}

#pragma mark -
#pragma mark methods of UITextFieldDelegate protocol

//Called when return key is pressed.
//Decide if the app should accept this input and hide the keyboard.

- (BOOL) textFieldShouldReturn: (UITextField *) tf {
	if ([tf.text isEqualToString: @""]) {
		textField.placeholder = @"<Enter valid stock symbol here>";
	} else {
		[tf resignFirstResponder];	//Hide keyboard.
	}
	return YES;	//The text field should do its default behavior.
}

//Called when keyboard is hidden.
//Process the text that was input.

- (void) textFieldDidEndEditing: (UITextField *) tf {
	if ([textField.text isEqualToString: @""]) {
		
	} else {
		NSString *uppercase = [textField.text uppercaseString];		

		for (int i=0; i<4; ++i)
		{
			ViewController *v = [viewController.tabBarController.viewControllers objectAtIndex:i];
			v.symKey = uppercase;//label.text;
			(void)v.view.setNeedsDisplay;
		}
		textField.text = @"";
	}
}



@end
