//
//  MAMB09_homeTableViewController.h
//  Me and My BFFs
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
//#import <UITableViewController.h>


@interface MAMB09_homeTableViewController : UITableViewController < UIGestureRecognizerDelegate >


@property (strong, nonatomic) IBOutlet UITableView *outletToHomeTableview;

// @property (strong, nonatomic) NSArray * mambyObjectList;

//@property (strong, nonatomic) NSMutableArray *arrayGrp;  off to globals
//@property (strong, nonatomic) NSMutableArray *arrayPer;
//@property (strong, nonatomic) NSMutableArray *arrayGrM;

@property (strong, nonatomic) NSString *mambCurrentEntity;         //  "group" OR "person"
@property (strong, nonatomic) NSString *mambCurrentSelection;      // like "~Anya" or "~Swim Team"
@property (strong, nonatomic) NSString *mambCurrentSelectionType;  // like "group" or "person" or "pair"

// work
@property (strong, nonatomic) NSArray *arr;


//@property (strong, nonatomic) IBOutlet UIView *HomeNavBar;

- (IBAction)actionSwitchEntity:(id)sender;
- (void) dealloc ;
- (void) doStuffOnEnteringForeground ;


@property(nonatomic) NSInteger selectedSegmentIndex;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segEntityOutlet;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *outlet_infoButton;

@end
