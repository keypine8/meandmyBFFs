//
//  MAMB09_selectReportsTableViewController.m
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

//#import "MAMB09_homeTableViewController.h"
#import "MAMB09_selectReportsTableViewController.h"
#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals


@interface MAMB09_selectReportsTableViewController ()
{
    //@property (strong, nonatomic) UIView *HomeNavBar;

}
@end

@implementation MAMB09_selectReportsTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    fopen_fpdb_for_debug();
    tn();
    NSLog(@"in sel Reports viewDidLoad!");

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // put name of grp or per as title
    //
    // NSArray *arrSpecs = [self.fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet:
    //                   [NSCharacterSet characterSetWithCharactersInString:@"|"]];
    NSArray *arrSpecs = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet:
                         [NSCharacterSet characterSetWithCharactersInString:@"|"]];
    
    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
        [[self navigationItem] setTitle: arrSpecs[0]];
    });
    
    // NSLog(@"fromHomeCurrentEntity=%@",self.fromHomeCurrentEntity);                  // like "group" or "person"
    NSLog(@"gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
    NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
    NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);

} /* viewDidLoad */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"The App received an Memory Warning"
                                                    message: @"The system has determined that the \namount of available memory is very low."
                                                   delegate: nil
                                          cancelButtonTitle: @"OK"
                                          otherButtonTitles: nil];
    [alert show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //return 0;
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    NSInteger rowcount;
    rowcount = 0;

    // Return the number of rows in the section.
    // return 0;
    // if ([self.fromHomeCurrentSelectionType isEqualToString:@"person"]) {
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {
        return 5;
        //rowcount = mambReportsPerson.count;

    }
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"])  {
        //rowcount = mambReportsGroup.count;
        return 11;

    }
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"pair"])   {
        //rowcount = mambReportsPair.count;
        return 11;

    }
    //NSLog(@"rowcount=%ld",(long)rowcount);
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"in selREP numberOfRowsInSection!");

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelReportsCellIDentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...

    NSString *myPrefix;  // for 3-char code in rptsel array PSV field # 1
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) myPrefix = @"p";
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"])  myPrefix = @"g";
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"pair"])   myPrefix = @"2";

    // match the tableview index we are on 
    // to the same index in gbl_mambReports  (but for the correct prefix  p,g,2)
    int myIdxInto_gbl_mambReports = (int) indexPath.row;

    // goto gbl_mambReports 
    // consider  elements who have correct prefix    like "p" for person reports
    // get str with index of  myIdxInto_gbl_mambReports into those
    // grab field #2 of that PSV (will be report table text)
    //
    int idx = -1;
    for (NSString *perRptPSV in gbl_mambReports) {

        if ( ! [perRptPSV hasPrefix: myPrefix]) continue;

        idx = idx + 1;
        if (idx == myIdxInto_gbl_mambReports) {
            NSCharacterSet *mySeparators = [NSCharacterSet characterSetWithCharactersInString:@"|"];
            NSArray *myRptSelarr         = [perRptPSV componentsSeparatedByCharactersInSet: mySeparators];
            cell.textLabel.text          = myRptSelarr[1];  // field # 2  in like,  @"pcy|Calendar Year ...",
        }
    }

    return cell;
} // cellForRowAtIndexPath

// color cell bg
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor: gbl_colorReportsBG];
    cell.backgroundColor = [UIColor clearColor];

}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"in SELREPORTS prepareForSegue!");

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    // get the indexpath of current row

    // this is the "currently" selected row now
    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
    // now you can use cell.textLabel.text

    // segueRptSelToViewHTML
    //
    if ([segue.identifier isEqualToString:@"segueRptSelToViewHTML"]) {
        
        //MAMB09_viewHTMLViewController *myDestViewController = segue.destinationViewController;
        // now globals
        // pass forward this data to ViewHTML
        //myDestViewController.fromHomeCurrentSelectionType = self.fromHomeCurrentSelectionType; // "group" or "person" or "pair"
        //myDestViewController.fromHomeCurrentEntity        = self.fromHomeCurrentEntity; // "group" or "person"
        
        // now in gbl_fromHomeCurrentSelectionPSV
        // myDestViewController.fromHomeCurrentSelectionPSV     = self.fromHomeCurrentSelectionPSV; //  PSV for "group" or "person"
        
        // this is the "currently" selected row now
        //NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];

        //myDestViewController.fromSelRptRowNumber = currentlyselectedIndexPath.row; // "group" or "person" or "pair"
        // gbl_fromSelRptRowNumber =currentlyselectedIndexPath.row; // "group" or "person" or "pair"
        
        //UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
        // now you can use cell.textLabel.text
 

        
    } // segueRptSelToViewHTML

    if ([segue.identifier isEqualToString:@"segueRptSelToSelYear"]) {
        nbn(41);
        //MAMB09_viewHTMLViewController *myDestViewController = segue.destinationViewController;
        
        // pass forward this data to ViewHTML
        //myDestViewController.fromHomeCurrentSelectionType = self.fromHomeCurrentSelectionType; // "group" or "person" or "pair"
        //myDestViewController.fromHomeCurrentEntity        = self.fromHomeCurrentEntity; // "group" or "person"
        
        // now in gbl_fromHomeCurrentSelectionPSV
        //myDestViewController.fromHomeCurrentSelectionPSV     = self.fromHomeCurrentSelectionPSV; //  CSV for "group" or "person"
        
        //myDestViewController.selectedYear = self.selectedYear;  // user-selected yr for Calendar Year report
        nb(49);
    } // segueRptSelToSelYear
    
    if ([segue.identifier isEqualToString:@"segueRptSelToSelPerson"]) {
        nbn(400);

    } // segueRptSelToSelPerson
    

} /* prepareForSegue */


    //<.>  from home code
    // these 5 methods  handlelight grey highlight correctly
    // when returning from report viewer
    //
    // viewWillAppear   first  (after viewdidload)
    // viewDidAppear    then this
    // willDeselectRowAtIndexPath
    // willSelectRowAtIndexPath
    // didSelectRowAtIndexPath
    //
-(void) viewWillAppear:(BOOL)animated {
    tn(); NSLog(@"in viewWillAppear  in rpt sel!");
    // for test
    //NSLog(@" in viewWillAppear in sel rpt tableview contrlr --------------- gbl_arrayPer=%@",gbl_arrayPer);

    // get the indexpath of current row
    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    NSLog(@"myIdxPath.row=%ld", (long)myIdxPath.row);
    NSLog(@"myIdxPath=%@",myIdxPath );

    // [tableView reloadData];
    if(myIdxPath) {
        [self.tableView selectRowAtIndexPath:myIdxPath animated:YES scrollPosition:UITableViewScrollPositionNone]; // puts highlight on this row
    } else {

//        // use remembered selection, if present
//        NSUInteger *myLastSelectedIndex;
//        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m
//        myLastSelectedIndex = [myappDelegate lastSelTblIdxForEntity: (NSString *) personOrGroup
//                                                      havingName: (NSString *) entityName
//                                              inRememberCategory: (NSString *) rememberCategory ;
//        if (myLastSelectedIndex) {
//            NSIndexPath *myIdxPath2 = [NSIndexPath indexPathWithIndex: *myLastSelectedIndex];
//            [self.tableView selectRowAtIndexPath:myIdxPath2
//                                        animated:YES
//                                  scrollPosition:UITableViewScrollPositionNone]; // puts highlight on this row
//        }
//
    }

    // here highlight the  remembered row  for the current  person
// TODO   <.>
    

} // viewWillAppear


- (void)viewDidAppear:(BOOL)animated
{
    tn(); NSLog(@"in viewDidAppear  in rpt sel!");
    //[super viewDidAppear];


// for test

//
//    // set cell to whatever you want to be selected first
//    // yellow highlight that cell
//    //
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
//    if (indexPath) {
//        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
//        //        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
//        // [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionNone];
//    }
//





}

// - (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"in willDeselectRowAtIndexPath!");
    
    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.
    // 
    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    // NSLog(@"previouslyselectedIndexPath.row=%ld", (long)previouslyselectedIndexPath.row);
    
//    if ([_mambCurrentEntity isEqualToString:@"group"])   NSLog(@"current  row 225=[%@]", [gbl_arrayGrp objectAtIndex:previouslyselectedIndexPath.row]);
//    if ([_mambCurrentEntity isEqualToString:@"person"])  NSLog(@"current  row 226=[%@]", [gbl_arrayPer objectAtIndex:previouslyselectedIndexPath.row]);
//    
    
    // here we are deselecting "previously" selected row
    // and removing light grey highlight
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
                                  animated: NO];
    //animated: YES];
    return previouslyselectedIndexPath;
} // willDeselectRowAtIndexPath


// willSelectRowAtIndexPath message is sent to the UITableView Delegate
// after the user lifts their finger from a touch of a particular row
// and before didSelectRowAtIndexPath.
//
// willSelectRowAtIndexPath allows you to either confirm that the particular row can be selected,
// by returning the indexPath, or select a different row by providing an alternate indexPath.
//
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath: (NSIndexPath*)indexPath {
    
    // NSLog(@"willSelectRowAtIndexPath!");

    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    // here deselect "previously" selected row
    // and remove yellow highlight
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
                                  animated: NO];
    return(indexPath);
} // willSelectRowAtIndexPath



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    NSLog(@"in didSelectRowAtIndexPath! in sel rpt");
        MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // to access global methods in appDelegate.m
    
    // this is the "currently" selected row now
    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
    [self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: currentlyselectedIndexPath.row
                                                      animated: NO];
    // animated:YES
    //  animated: YES];
    
    // GOTO  the Correct View for Input Params
    // or, directly to ViewHTML to see the Selected Report
    //
    
    UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
    // NSLog(@"currcell=%@",currcell);

    // now you can use cell.textLabel.text
    NSString *stringForCurrentlySelectedRow = currcell.textLabel.text;
    // NSLog(@"currcell.textLabel.text=%@",currcell.textLabel.text);


    if ([stringForCurrentlySelectedRow hasPrefix: @"Calendar Year"] ) {
        NSLog(@"in dispatch  for SELECT YEAR  !");
        
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) @"pcy"
        ];

        // Because background threads are not prioritized and will wait a very long time
        // before you see results, unlike the mainthread, which is high priority for the system.
        //
        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
        //
        nbn(331);
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToSelYear" sender:self];
        });
        nbn(332);
        
        // no improvement in 2 sec
        //        if (NSThread.isMainThread == YES){
        //            nksn("are in Mainthread    main main main main !!!!!!!!!!");
        //            [self performSegueWithIdentifier:@"segueRptSelToSelYear" sender:self];
        //        } else {
        //            nksn("dispatching to main thread   !!!!!!!!! ");
        //
        //            dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
        //                [self performSegueWithIdentifier:@"segueRptSelToSelYear" sender:self];
        //            });
        //        }
        
        
        // NSLog(@"34!");
        // ntrn("=========================================");
    } // Calendar Year
    
    if ([stringForCurrentlySelectedRow hasPrefix: @"Personality"] ) {
        //[self performSegueWithIdentifier:@"segueRptSelToViewHTML"         sender:self];
        
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) @"ppe"
        ];

        // Because background threads are not prioritized and will wait a very long time
        // before you see results, unlike the mainthread, which is high priority for the system.
        //
        // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
        //
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToViewHTML" sender:self];
        });
    }
    
    if ([stringForCurrentlySelectedRow hasPrefix: @"Compatibility Paired"] ) {
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) @"pco"    ];

        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
        });
    }

    if ([stringForCurrentlySelectedRow hasPrefix: @"My Best Match"] ) {
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) @"pbm"    ];
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//
    }
    if ([stringForCurrentlySelectedRow hasPrefix: @"What Color is Today"] ) {
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"person"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) @"pwc"    ];
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//
    }
    
    if ([stringForCurrentlySelectedRow hasPrefix: @"Best Match"] ) {
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) @"gbm"    ];
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//

    }
    if ([stringForCurrentlySelectedRow hasPrefix: @"Most"] ) {  // trait

        // get rpt 3 char code
        NSString *code3;
        if ([stringForCurrentlySelectedRow hasPrefix: @"Most Assertive"] )     code3 = @"gma";
        if ([stringForCurrentlySelectedRow hasPrefix: @"Most Emotional"] )     code3 = @"gme";
        if ([stringForCurrentlySelectedRow hasPrefix: @"Most Restless"] )      code3 = @"gmr";
        if ([stringForCurrentlySelectedRow hasPrefix: @"Most Passionate"] )    code3 = @"gmp";
        if ([stringForCurrentlySelectedRow hasPrefix: @"Most Down-to-earth"] ) code3 = @"gmd";
        if ([stringForCurrentlySelectedRow hasPrefix: @"Most Ups and Downs"] ) code3 = @"gmu";

        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) code3     ];

//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//
    }
    if ([stringForCurrentlySelectedRow hasPrefix: @"Best Year"] ) {
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) @"gby"    ];
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//
    }
    if ([stringForCurrentlySelectedRow hasPrefix: @"Best Day"] ) {
        [myappDelegate saveLastSelectionForEntity: (NSString *) @"group"
                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
                         updatingRememberCategory: (NSString *) @"rptsel"
                                       usingValue: (NSString *) @"gbd"    ];
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//
    }
   
    // below are report for pairs of people (picked from a group report having pairs)
    // NO REMEMBERING WHICH REPORT WAS SELECTED
    
    if ([stringForCurrentlySelectedRow hasSuffix: @"Compatibility Potential"] ) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
    }
    if ([stringForCurrentlySelectedRow hasSuffix: @" Best Match"] ) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//
    }
    if ([stringForCurrentlySelectedRow rangeOfString:@" Calendar Year"].location != NSNotFound) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//
    }

} // didSelectRowAtIndexPath


@end


    // NSLog(@"in sel Report  cellForRow!"); <.>
//    NSArray *mambReportsPerson =
//  @[
//    @"Calendar Year ...",
//    @"Personality",
//    @"Compatibility Paired with ...",
//    @"My Best Match in Group ...",
//    @"What Color is Today? ...",
//    ];
//
//    NSArray *mambReportsGroup =
//  @[
//    @"Best Match",
//    @"",
//    @"Most Assertive Person",
//    @"Most Emotional",
//    @"Most Restless",
//    @"Most Passionate",
//    @"Most Down-to-earth",
//    @"Most Ups and Downs",
//    @"",
//    @"Best Year ...",
//    @"Best Day ...",
//    ];
//    NSArray *mambReportsPair =
//  @[
//    @"Compatibility Potential",
//    @"",
//    @"<per1> Best Match",
//    @"<per1> Personality",
//    @"<per1> Calendar Year ...",
//    @"",
//    @"<per2> Best Match",
//    @"<per2> Personality",
//    @"<per2> Calendar Year ...",
//    ];
//    
//

