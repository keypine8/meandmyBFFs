//
//  MAMB09_homeTableViewController.h
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <UITableViewController.h>


@interface MAMB09_homeTableViewController : UITableViewController

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

@end
