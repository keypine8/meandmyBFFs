//
//  MAMB09_viewHTMLViewController.h
//  Me&myBFFs
//
// MIT License
//
// Copyright (c) 2017 softwaredev
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

// @interface YourViewController : UIViewController <UIWebViewDelegate>

@interface MAMB09_viewHTMLViewController : UIViewController <MFMailComposeViewControllerDelegate, UIWebViewDelegate>
//@interface MAMB09_viewHTMLViewController : UIViewController <MFMailComposeViewControllerDelegate, UIGestureRecognizerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *outletWebView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outlet_infoButton;

// all globals   yyyyy  222

// now in gbl_fromHomeCurrentSelectionPSV
//@property (strong, nonatomic) NSString *fromHomeCurrentSelectionPSV;     // CSV  for per or grp or pair of people
//@property (strong, nonatomic) NSString *fromHomeCurrentSelectionType; // like "group" or "person" or "pair"
//@property (strong, nonatomic) NSString *fromHomeCurrentEntity;        // like "group" or "person" or "member"
//
//// @property (strong, nonatomic) NSString *fromUserSecondPerson;         // CSV  for per or grp or pair of people
//

//   xxxxx
//@property (strong, nonatomic) NSString *selectedYear;           // from selYearViewController  yyyy
//@property (strong, nonatomic) NSString *selectedPersonFromAll;  // from selPersonFromAllViewController
//@property (strong, nonatomic) NSString *selectedGroup;          // from selGroupViewController
//@property (strong, nonatomic) NSString *selectedDay ;           // from selDayViewController  yyyymmdd
//@property (strong, nonatomic) NSString *selectedPersonFromPair; // from selPersonFromPairViewController

//@property (strong, nonatomic) NSString *fromUserYearToDO;             // user-selected year
//@property (strong, nonatomic) NSString *fromUser_YYYYMMDD_ToDO;       // user-selected year

@end
