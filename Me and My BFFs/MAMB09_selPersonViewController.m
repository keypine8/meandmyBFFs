//
//  MAMB09_selPersonViewController.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2014-12-01.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import "MAMB09_selPersonViewController.h"
#import "MAMB09_viewHTMLViewController.h"
#import "mamblib.h"
#import "MAMB09AppDelegate.h"   // to get globals

@implementation MAMB09_selPersonViewController

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
    fopen_fpdb_for_debug();
    NSLog(@"in Selct Person   viewDidLoad!");
    
    [super viewDidLoad];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
        [[self navigationItem] setTitle: @"Second Person"];
    });

 
    NSLog(@"gbl_fromHomeCurrentSelectionPSV =%@",gbl_fromHomeCurrentSelectionPSV);
    NSLog(@"gbl_fromHomeCurrentSelectionType=%@",gbl_fromHomeCurrentSelectionType);
    NSLog(@"gbl_fromHomeCurrentEntity=%@",gbl_fromHomeCurrentEntity);
    
    
    // populate arrayPersonsToPickFrom
    //
    // if we came here from a person, the domain is all persons except current person
    // if we came here from a group,  the domain is all persons in the group
    //   gbl_fromHomeCurrentSelectionType;    // like "group" or "person" or "pair"
    if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"person"]) {   // came from a person
        
        [_PSVs_for_person_picklist removeAllObjects];
        _PSVs_for_person_picklist   = [[NSMutableArray alloc] init];
        
        [gbl_arrayPersonsToPickFrom removeAllObjects];
        gbl_arrayPersonsToPickFrom = [[NSMutableArray alloc] init];

        for (id myPerPSV in gbl_arrayPer) {
            if (gbl_show_example_data ==  NO  &&
                [myPerPSV hasPrefix: @"~"]) {  // skip example record
                continue;         //  ======================-------------------------------------- PUT BACK when we have non-example data!!!
            }
            NSArray *psvArray;
            NSString *person1, *person2;
            
            psvArray = [myPerPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"|"]];
            person1 = psvArray[0];

            psvArray = [gbl_fromHomeCurrentSelectionPSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: @"|"] ];
            person2 = psvArray[0];
            if ([person1 isEqualToString: person2]) {            // do not show person himself
                continue;
            }
            [gbl_arrayPersonsToPickFrom addObject: person1 ];                        //  Person name for pick
            [_PSVs_for_person_picklist addObject: myPerPSV ]; //  Person PSV  for ViewHTML
            
            // NSLog(@"gbl_arrayPersonsToPickFrom=%@",gbl_arrayPersonsToPickFrom);
        }
        //NSLog(@"gbl_arrayPersonsToPickFrom.count=%lu",(unsigned long)gbl_arrayPersonsToPickFrom.count);
        //NSLog(@"_PSVs_for_person_picklist=%@",_PSVs_for_person_picklist);
    }
  
    
    if ([gbl_fromHomeCurrentSelectionType isEqualToString: @"group"]) {   // came from a person
        NSLog(@"TODO  for  from-group sel!");
    }

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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"gbl_arrayPersonsToPickFrom.count=%lu",(unsigned long)gbl_arrayPersonsToPickFrom.count);

    return gbl_arrayPersonsToPickFrom.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // NSLog(@"in sel Person  cellForRow!");
    
    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"SelPersonCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    // if there are no cells to be reused, create a new cell
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //NSLog(@"cwll=%@",cell);

    // Configure the cell...
    cell.textLabel.text = [gbl_arrayPersonsToPickFrom   objectAtIndex:indexPath.row];
    //NSLog(@"cell.textLabel.text=%@",cell.textLabel.text);

    return cell;
} // cellForRowAtIndexPath

// color cell bg
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.tableView setBackgroundView:nil];
    [self.tableView setBackgroundColor: gbl_colorReportsBG];
    cell.backgroundColor = [UIColor clearColor];
    
}



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
    // [super viewDidAppear];
    
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
    //NSLog(@"in viewWillAppear!");
    
    // get the indexpath of current row
    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    
    // [tableView reloadData];
    if(myIdxPath) {
        [self.tableView selectRowAtIndexPath:myIdxPath animated:YES scrollPosition:UITableViewScrollPositionNone]; // puts highlight on this row (?)
    }
} // viewWillAppear



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath
{
     NSLog(@"in SelctPerson  didSelectRowAtIndexPath!");
    
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
    
    // Because background threads are not prioritized and will wait a very long time
    // before you see results, unlike the mainthread, which is high priority for the system.
    //
    // Also, all UI-related stuff must be done on the *main queue*. That's way you need that dispatch_async.
    //
    
    UITableViewCell *currcell = [self.tableView cellForRowAtIndexPath:currentlyselectedIndexPath];
    // now you can use cell.textLabel.text
    //   gbl_fromSelRptRowString = currcell.textLabel.text;
    gbl_selectedPerson = currcell.textLabel.text;
    gbl_fromSelRptRowPSV    = [_PSVs_for_person_picklist objectAtIndex: currentlyselectedIndexPath.row];
    nbn(100);
    NSLog(@"gbl_fromSelRptRowString=%@",gbl_fromSelRptRowString);

    dispatch_async(dispatch_get_main_queue(), ^{                                // <===  <.>
        [self performSegueWithIdentifier:@"seguePerSelToViewHTML" sender:self];
    });

    
} // didSelectRowAtIndexPath





@end
