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


@interface MAMB09_selectReportsTableViewController ()
@property (strong, nonatomic) UIView *HomeNavBar;

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
    NSLog(@"in sel Reports viewDidLoad!");

    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    // set data gotten from Home page
    //
    //[[self navigationItem] setTitle: self.fromHomeCurrentSelection];                // CSV  for per or grp or pair of people
    
    // put name of grp or per as title
    //
    NSArray *arrSpecs = [self.fromHomeCurrentSelection componentsSeparatedByCharactersInSet:
            [NSCharacterSet characterSetWithCharactersInString:@"|"]];
    [[self navigationItem] setTitle: arrSpecs[0]];                // CSV  for per or grp or pair of people
   
    NSLog(@"fromHomeCurrentSelection=%@",self.fromHomeCurrentSelection);            // CSV  for per or grp or pair of people
    NSLog(@"fromHomeCurrentSelectionType=%@",self.fromHomeCurrentSelectionType);    // like "group" or "person" or "pair"
    NSLog(@"fromHomeCurrentEntity=%@",self.fromHomeCurrentEntity);                  // like "group" or "person"

} /* viewDidLoad */


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSLog(@"self.fromHomeCurrentSelectionType=%@",self.fromHomeCurrentSelectionType);

    // Return the number of rows in the section.
    // return 0;
    if ([self.fromHomeCurrentSelectionType isEqualToString:@"person"]) {
        return 5;
        //rowcount = mambReportsPerson.count;

    }
    if ([self.fromHomeCurrentSelectionType isEqualToString:@"group"])  {
        //rowcount = mambReportsGroup.count;
        return 11;

    }
    if ([self.fromHomeCurrentSelectionType isEqualToString:@"pair"])   {
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
    @"<per1> Personality",
    @"per1 6789012345 Calendar Year ...",
    @"<per1> Best Match",
    @"<per1> Personality",
    @"",
    @"<per2> Personality",
    @"<per2> Calendar Year ...",
    @"<per2> Best Match",
    @"<per2> Personality",
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
    
    if ([self.fromHomeCurrentSelectionType isEqualToString:@"person"]) {
        cell.textLabel.text = [mambReportsPerson objectAtIndex:indexPath.row];
    }
    if ([self.fromHomeCurrentSelectionType isEqualToString:@"group"])  {
        cell.textLabel.text = [mambReportsGroup objectAtIndex:indexPath.row];
    }
    if ([self.fromHomeCurrentSelectionType isEqualToString:@"pair"])   {
        cell.textLabel.text = [mambReportsPair objectAtIndex:indexPath.row];
    }

    return cell;
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
    // NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    
    // segueRptSelToViewHTML
    //
    if ([segue.identifier isEqualToString:@"segueRptSelToViewHTML"]) {
        
        MAMB09_viewHTMLViewController *myDestViewController = segue.destinationViewController;
        
        myDestViewController.fromHomeCurrentSelectionType = self.fromHomeCurrentSelectionType; // "group" or "person" or "pair"
        myDestViewController.fromHomeCurrentEntity        = self.fromHomeCurrentEntity; // "group" or "person"
        myDestViewController.fromHomeCurrentSelection     = self.fromHomeCurrentSelection; //  CSV for "group" or "person"
        NSLog(@"dest(html)selTypeFromHome =%@",myDestViewController.fromHomeCurrentSelectionType);
        NSLog(@"dest(html)entFromHome =%@",myDestViewController.fromHomeCurrentEntity);
        NSLog(@"dest(html)selFromHome =%@",myDestViewController.fromHomeCurrentSelection);

        // this is the "currently" selected row now
        NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];

        myDestViewController.fromSelRptRowNumber = currentlyselectedIndexPath.row; // "group" or "person" or "pair"
        
        UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
        // now you can use cell.textLabel.text
        myDestViewController.fromSelRptRowString = currcell.textLabel.text;

    } // segueRptSelToViewHTML

} /* prepareForSegue */

    
    
    //<.>  from home code
    // these 4 methods solely handlelight grey highlight correctly
    // when returning from report viewer
    //
    // viewDidAppear
    // willDeselectRowAtIndexPath
    // didSelectRowAtIndexPath
    // viewWillAppear
    //
- (void)viewDidAppear:(BOOL)animated
{
    // [super viewDidAppear];
    
    // set cell to whatever you want to be selected first
    // yellow highlight that cell
    //
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    if (indexPath) {
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        // [self.tableView selectRowAtIndexPath:indexPath animated:YES  scrollPosition:UITableViewScrollPositionNone];
    }
}

// - (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"in willDeselectRowAtIndexPath!");
    
    // When the user selects a cell, you should respond by deselecting the previously selected cell (
    // by calling the deselectRowAtIndexPath:animated: method) as well as by
    // performing any appropriate action, such as displaying a detail view.
    
    // this is the "previously" selected row now
    NSIndexPath *previouslyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    NSLog(@"previouslyselectedIndexPath.row=%ld", (long)previouslyselectedIndexPath.row);
    
//    if ([_mambCurrentEntity isEqualToString:@"group"])   NSLog(@"current  row 225=[%@]", [_arrayGrp objectAtIndex:previouslyselectedIndexPath.row]);
//    if ([_mambCurrentEntity isEqualToString:@"person"])  NSLog(@"current  row 226=[%@]", [_arrayPer objectAtIndex:previouslyselectedIndexPath.row]);
//    
    
    // here deselect "previously" selected row
    // and remove yellow highlight
    [self.tableView deselectRowAtIndexPath: previouslyselectedIndexPath
                                  animated: YES];
    return previouslyselectedIndexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
    NSLog(@"in didSelectRowAtIndexPath!");
    
    // this is the "currently" selected row now
    NSIndexPath *currentlyselectedIndexPath = [self.tableView indexPathForSelectedRow];
    
    NSLog(@"currentlyselectedIndexPath.row=%ld", (long)currentlyselectedIndexPath.row);
    
    //    if ([_mambCurrentEntity isEqualToString:@"group"])
    //        NSLog(@"current  row 227=[%@]", [_arrayGrp objectAtIndex:currentlyselectedIndexPath.row]);
    //    if ([_mambCurrentEntity isEqualToString:@"person"])
    //        NSLog(@"current  row 228=[%@]", [_arrayPer objectAtIndex:currentlyselectedIndexPath.row]);
    
    // select the row in UITableView
    // This puts in the light grey "highlight" indicating selection
    [self.tableView selectRowAtIndexPath:currentlyselectedIndexPath
                                animated:YES
                          scrollPosition:UITableViewScrollPositionNone];
    
    [self.tableView scrollToNearestSelectedRowAtScrollPosition: currentlyselectedIndexPath.row
                                                      animated: YES];
}

-(void) viewWillAppear:(BOOL)animated {
    // get the indexpath of current row
    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    
    // [tableView reloadData];
    if(myIdxPath) {
        [self.tableView selectRowAtIndexPath:myIdxPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    }
}






@end
