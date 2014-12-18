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
    // NSLog(@"in sel Report  cellForRow!");
    NSArray *mambReportsPerson =
  @[
    @"Calendar Year ...",
    @"Personality",
    @"Compatibility Paired with ...",
    @"My Best Match in Group ...",
    @"How was your Day? ...",
    ];
    NSArray *mambReportsGroup =
  @[
    @"Best Match",
    @"",
    @"Most Assertive Person",
    @"Most Emotional",
    @"Most Restless",
    @"Most Passionate",
    @"Most Down-to-earth",
    @"Most Ups and Downs",
    @"",
    @"Best Year ...",
    @"Best Day ...",
    ];
    NSArray *mambReportsPair =
  @[
    @"Compatibility Potential",
    @"",
    @"<per1> Best Match",
    @"<per1> Personality",
    @"<per1> Calendar Year ...",
    @"",
    @"<per2> Best Match",
    @"<per2> Personality",
    @"<per2> Calendar Year ...",
    ];
    

    //NSLog(@"in selREP numberOfRowsInSection!");

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelReportsCellIDentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    // Configure the cell...
    
    //if ([self.fromHomeCurrentSelectionType isEqualToString:@"person"]) {
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {
        cell.textLabel.text = [mambReportsPerson objectAtIndex:indexPath.row];
    }
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"group"])  {
        cell.textLabel.text = [mambReportsGroup objectAtIndex:indexPath.row];
    }
    if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"pair"])   {
        cell.textLabel.text = [mambReportsPair objectAtIndex:indexPath.row];
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
 
        gbl_fromSelRptRowString = currcell.textLabel.text;

        
    } // segueRptSelToViewHTML

    if ([segue.identifier isEqualToString:@"segueRptSelToSelYear"]) {
        nbn(41);
        //MAMB09_viewHTMLViewController *myDestViewController = segue.destinationViewController;
        
        // pass forward this data to ViewHTML
        //myDestViewController.fromHomeCurrentSelectionType = self.fromHomeCurrentSelectionType; // "group" or "person" or "pair"
        //myDestViewController.fromHomeCurrentEntity        = self.fromHomeCurrentEntity; // "group" or "person"
        
        // now in gbl_fromHomeCurrentSelectionPSV
        //myDestViewController.fromHomeCurrentSelectionPSV     = self.fromHomeCurrentSelectionPSV; //  CSV for "group" or "person"
        
        gbl_fromSelRptRowString = currcell.textLabel.text;
        
        //myDestViewController.selectedYear = self.selectedYear;  // user-selected yr for Calendar Year report
        nb(49);
    } // segueRptSelToSelYear
    
    if ([segue.identifier isEqualToString:@"segueRptSelToSelPerson"]) {
        nbn(400);
        gbl_fromSelRptRowString = currcell.textLabel.text;
        NSLog(@"gbl_fromSelRptRowString=%@",gbl_fromSelRptRowString);

    } // segueRptSelToSelPerson
    

} /* prepareForSegue */


    //<.>  from home code
    // these 5 methods  handlelight grey highlight correctly
    // when returning from report viewer
    //
    // viewDidAppear
    // willDeselectRowAtIndexPath
    // viewWillAppear (?)
    // willSelectRowAtIndexPath
    // didSelectRowAtIndexPath
    //
- (void)viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear];

    // set cell to whatever you want to be selected first
    // yellow highlight that cell
    //
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
        //        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        // [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionNone];
    }

}

// - (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"in willDeselectRowAtIndexPath!");
    
    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.
    
    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    // NSLog(@"previouslyselectedIndexPath.row=%ld", (long)previouslyselectedIndexPath.row);
    
//    if ([_mambCurrentEntity isEqualToString:@"group"])   NSLog(@"current  row 225=[%@]", [gbl_arrayGrp objectAtIndex:previouslyselectedIndexPath.row]);
//    if ([_mambCurrentEntity isEqualToString:@"person"])  NSLog(@"current  row 226=[%@]", [gbl_arrayPer objectAtIndex:previouslyselectedIndexPath.row]);
//    
    
    // here deselect "previously" selected row
    // and remove yellow highlight
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


-(void) viewWillAppear:(BOOL)animated {
    tn(); NSLog(@"in viewWillAppear!");
    // for test
    //NSLog(@" in viewWillAppear in sel rpt tableview contrlr --------------- gbl_arrayPer=%@",gbl_arrayPer);

    // get the indexpath of current row
    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    
    // [tableView reloadData];
    if(myIdxPath) {
        [self.tableView selectRowAtIndexPath:myIdxPath animated:YES scrollPosition:UITableViewScrollPositionNone]; // puts highlight on this row (?)
    }
} // viewWillAppear



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    // NSLog(@"in didSelectRowAtIndexPath!");
    
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
        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
        });
    }

//    if ([stringForCurrentlySelectedRow hasPrefix: @"My Best Match"] ) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//    }
//    if ([stringForCurrentlySelectedRow hasPrefix: @"How was your Day"] ) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//    }
//    
//    if ([stringForCurrentlySelectedRow hasPrefix: @"Best Match"] ) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//    }
//    if ([stringForCurrentlySelectedRow hasPrefix: @"Most"] ) {  // trait
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//    }
//    if ([stringForCurrentlySelectedRow hasPrefix: @"Best Year"] ) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//    }
//    if ([stringForCurrentlySelectedRow hasPrefix: @"Best Day"] ) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//    }
//    
//    if ([stringForCurrentlySelectedRow hasSuffix: @"Compatibility Potential"] ) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//    }
//    if ([stringForCurrentlySelectedRow hasSuffix: @" Best Match"] ) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//    }
//    if ([stringForCurrentlySelectedRow rangeOfString:@" Calendar Year"].location != NSNotFound) {
//        dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
//            [self performSegueWithIdentifier:@"segueRptSelToSelPerson" sender:self];
//        });
//    }
} // didSelectRowAtIndexPath


@end
