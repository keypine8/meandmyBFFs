//
//  MAMB09_homeTableViewController.m
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//
//dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//    code here
//});
//
// To determine the current selected cell
//- (NSIndexPath *)indexPathForSelectedRow

//When you tap a cell, the willSelectRowAtIndexPath and didSelectRowAtIndexPath are called - supplying you the currently selected NSIndexPath
//– tableView:willSelectRowAtIndexPath:
//– tableView:didSelectRowAtIndexPath:
//– tableView:willDeselectRowAtIndexPath:
//– tableView:didDeselectRowAtIndexPath:

#import "MAMB09_homeTableViewController.h"
#import "MAMB09_selectReportsTableViewController.h"

@interface MAMB09_homeTableViewController ()

//- (NSURL*) getDocumentDirectoryURL;


@end

@implementation MAMB09_homeTableViewController

//@synthesize mambyObjectList;

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
        
    // mambyObjectList = [[NSArray alloc]initWithObjects:@"mamby obj 1", @"mamby obj 2", nil];
    
    // example data in DB
    //
    NSArray *mambGroup =
    @[
      @"~Swim Team|not imported",
      @"~My Family|not imported"
    ];
    NSArray *mambPerson =
    @[
      @"~Father|7|11|1961|11|8|1|Los Angeles|California|United States|",
      @"~Mother|3|12|1965|10|45|0|Los Angeles|California|United States|",
      @"~Sister1|2|31|1988|0|30|1|Los Angeles|California|United States|",
      @"~Sister2|2|13|1990|3|35|0|Los Angeles|California|United States|",
      @"~Brother|11|6|1986|8|1|1|Los Angeles|California|United States|",
      @"~Grandma|8|17|1939|8|5|0|Los Angeles|California|United States|",
      @"~Mike|4|20|1992|6|30|1|Los Angeles|California|United States|",
      @"~Anya|10|19|1990|8|20|0|Los Angeles|California|United States|",
      @"~Billie|8|4|1991|10|30|1|Los Angeles|California|United States|",
      @"~Emma|5|17|1993|0|1|1|Los Angeles|California|United States|",
      @"~Jacob|10|10|1992|0|1|1|Los Angeles|California|United States|",
      @"~Grace|8|21|1994|1|20|0|Los Angeles|California|United States|",
      @"~Ingrid|3|13|1993|4|10|1|Los Angeles|California|United States|",
      @"~Jen|6|22|1992|4|10|0|Los Angeles|California|United States|",
      @"~Liz|3|13|1991|4|10|1|Los Angeles|California|United States|",
      @"~Jim|2|3|1993|0|1|1|Los Angeles|California|United States|",
      @"~Olivia|4|13|1994|0|53|1|Los Angeles|California|United States|",
      @"~Dave|4|8|1993|0|1|1|Los Angeles|California|United States|",
      @"~Noah|12|19|1994|11|4|0|Los Angeles|California|United States|",
      @"~Sophia|9|20|1991|4|0|0|Los Angeles|California|United States|",
      @"~Susie|2|3|1992|8|10|0|Los Angeles|California|United States|"
    ];
    NSArray *mambGroupMember =
    @[
      @"~My Family|~Brother",
      @"~My Family|~Father",
      @"~My Family|~Grandma",
      @"~My Family|~Mother",
      @"~My Family|~Sister1",
      @"~My Family|~Sister2",
      @"~Swim Team|~Anya",
      @"~Swim Team|~Billie",
      @"~Swim Team|~Dave",
      @"~Swim Team|~Emma",
      @"~Swim Team|~Grace",
      @"~Swim Team|~Ingrid",
      @"~Swim Team|~Jacob",
      @"~Swim Team|~Jen",
      @"~Swim Team|~Jim",
      @"~Swim Team|~Liz",
      @"~Swim Team|~Mike",
      @"~Swim Team|~Noah",
      @"~Swim Team|~Olivia",
      @"~Swim Team|~Sophie",
      @"~Swim Team|~Susie"
    ];
    
    
//    for (id s in mambGroup)       {NSLog(@"eltG: %@",s);}
//    for (id s in mambPerson)      {NSLog(@"eltP: %@",s);}
//    for (id s in mambGroupMember) {NSLog(@"eltGM: %@",s);}
//
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
 
    // get Document directory as URL and Str
    //
    NSFileManager* sharedFM = [NSFileManager defaultManager];
    NSArray* possibleURLs = [sharedFM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    NSURL* appDocDirURL = nil;
    if ([possibleURLs count] >= 1) {
        appDocDirURL = [possibleURLs objectAtIndex:0];
    }
    NSString *appDocDirStr = [appDocDirURL path];
    
    // get DB names as URL and Str
    NSString *pathToGroup       = [appDocDirStr stringByAppendingPathComponent: @"mambGroup.txt"];
    NSString *pathToPerson      = [appDocDirStr stringByAppendingPathComponent: @"mambPerson.txt"];
    NSString *pathToGroupMember = [appDocDirStr stringByAppendingPathComponent: @"mambGroupMember.txt"];
    NSURL *URLToGroup           = [NSURL fileURLWithPath: pathToGroup isDirectory:NO];
    NSURL *URLToPerson          = [NSURL fileURLWithPath: pathToPerson isDirectory:NO];
    NSURL *URLToGroupMember     = [NSURL fileURLWithPath: pathToGroupMember isDirectory:NO];
    NSString *pathToGroupLastGood       = [appDocDirStr stringByAppendingPathComponent: @"mambGroupLastGood.txt"];
    NSString *pathToPersonLastGood      = [appDocDirStr stringByAppendingPathComponent: @"mambPersonLastGood.txt"];
    NSString *pathToGroupMemberLastGood = [appDocDirStr stringByAppendingPathComponent: @"mambGroupMemberLastGood.txt"];
    NSURL *URLToGroupLastGood           = [NSURL fileURLWithPath: pathToGroupLastGood isDirectory:NO];
    NSURL *URLToPersonLastGood          = [NSURL fileURLWithPath: pathToPersonLastGood isDirectory:NO];
    NSURL *URLToGroupMemberLastGood     = [NSURL fileURLWithPath: pathToGroupMemberLastGood isDirectory:NO];

    BOOL haveGrp, havePer, haveGrM,  haveGrpLastGood, havePerLastGood, haveGrMLastGood;

//    NSLog(@"%@", appDocDirURL.lastPathComponent);
//    NSLog(@"docdir = %@", appDocDirStr);
//    NSLog(@"%@", pathToGroup);       NSLog(@"url str=%@", [URLToGroup path]);
//    NSLog(@"%@", pathToPerson);      NSLog(@"url str=%@", [URLToPerson path]);
//    NSLog(@"%@", pathToGroupMember); NSLog(@"url str=%@", [URLToGroupMember path]);
    
    // check if DB files are there
    // if all are there, good to go
    // else
    //   if all lastGood are there,
    //      remove all regular named files
    //      copy lastGood DB files to regular names
    //   else
    //      remove any lastGood files
    //      write example data from arrays into new DB files
    //
    //   read regular DB files into arrays
    BOOL ret01;   NSError *err01;
    //NSMutableArray *arrayGrp, *arrayPer, *arrayGrM;
    
    //   FOR test   remove all regular named files
//    [sharedFM removeItemAtURL:URLToGroup error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grp %@", err01); }
//    [sharedFM removeItemAtURL:URLToPerson error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"per %@", err01); }
//    [sharedFM removeItemAtURL:URLToGroupMember error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grM %@", err01); }
    

    haveGrp = [sharedFM fileExistsAtPath: pathToGroup];
    havePer = [sharedFM fileExistsAtPath: pathToPerson];
    haveGrM = [sharedFM fileExistsAtPath: pathToGroupMember];
    NSLog(@"%d  %d  %d", haveGrp, havePer, haveGrM);
    if ( haveGrp && havePer && haveGrM ) {   // good to go
        NSLog(@"%@", @"use regular files!");
    } else {
        haveGrpLastGood = [sharedFM fileExistsAtPath: pathToGroupLastGood];
        havePerLastGood = [sharedFM fileExistsAtPath: pathToPersonLastGood];
        haveGrMLastGood = [sharedFM fileExistsAtPath: pathToGroupMemberLastGood];
        NSLog(@"%d  %d  %d", haveGrpLastGood, havePerLastGood, haveGrMLastGood);
        
        if ( haveGrpLastGood && havePerLastGood && haveGrMLastGood ) {
            NSLog(@"%@", @"use  LastGood files!");
            //      remove all regular named files (these cannot exist - no overcopy)
            [sharedFM removeItemAtURL:URLToGroup error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grp %@", err01); }
            [sharedFM removeItemAtURL:URLToPerson error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"per %@", err01); }
            [sharedFM removeItemAtURL:URLToGroupMember error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grM %@", err01); }

            //      copy lastGood DB files to regular names
            [sharedFM copyItemAtURL:URLToGroupLastGood toURL:URLToGroup error:&err01];
            if (err01) { NSLog(@"cp lg to grp %@", err01); }
            [sharedFM copyItemAtURL:URLToPersonLastGood toURL:URLToPerson error:&err01];
            if (err01) { NSLog(@"cp lg to per %@", err01); }
            [sharedFM copyItemAtURL:URLToGroupMemberLastGood toURL:URLToGroup error:&err01];
            if (err01) { NSLog(@"cp lg to grM %@", err01); }

        } else {   // INIT
            NSLog(@"%@", @"use example data arrays!");
            // remove any lastGood files (err code NSFileNoSuchFileError = 4)
            [sharedFM removeItemAtURL:URLToGroupLastGood error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grpLg %@", err01); }
            [sharedFM removeItemAtURL:URLToPersonLastGood error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"perLg %@", err01); }
            [sharedFM removeItemAtURL:URLToGroupMemberLastGood error:&err01];
            if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grMLg %@", err01); }
            
            // write out example data files
            ret01 = [mambGroup writeToURL:URLToGroup atomically:YES];
            if (!ret01)  NSLog(@"Error write to Grp \n  %@", [err01 localizedFailureReason]);
            ret01 = [mambPerson writeToURL:URLToPerson atomically:YES];
            if (!ret01)  NSLog(@"Error write to Per \n  %@", [err01 localizedFailureReason]);
            ret01 = [mambGroupMember writeToURL:URLToGroupMember atomically:YES];
            if (!ret01)  NSLog(@"Error write to GrM \n  %@", [err01 localizedFailureReason]);
            
        }
    } // check data files
    
    
    // read data files  with regular names into arrays
    // and sort the arrays in place by name
    //
    _arrayGrp = [[NSMutableArray alloc] initWithContentsOfURL:URLToGroup];
    if (_arrayGrp == nil) { NSLog(@"%@", @"Error reading Grp"); }
    _arrayPer = [[NSMutableArray alloc] initWithContentsOfURL:URLToPerson];
    if (_arrayPer == nil) { NSLog(@"%@", @"Error reading Per"); }
    _arrayGrM = [[NSMutableArray alloc] initWithContentsOfURL:URLToGroupMember];
    if (_arrayGrM == nil) { NSLog(@"%@", @"Error reading GrM"); }
    [_arrayGrp sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [_arrayPer sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [_arrayGrM sortUsingSelector:@selector(localizedCaseInsensitiveCompare:)];

    
    // home page - show Groups or people?  highlight which row in table?
    //
    // get lastEntityStr from  mambLastEntity.txt
    //
    //  need way to store "last used" info in @"mambLastEntity.txt"
    // Group=~Swim Team
    // Person=~Anya
    //
    // Later, enable @"lastReport.txt"
    // Report=Best Match
    // Report=Personality
    //
    NSString *pathToLastEntity = [appDocDirStr stringByAppendingPathComponent: @"mambLastEntity.txt"];
    NSURL     *URLToLastEntity = [NSURL fileURLWithPath: pathToLastEntity isDirectory:NO];
    BOOL haveLastEntity        = [sharedFM fileExistsAtPath: pathToLastEntity];
  
    // haveLastEntity = NO;
    
    if ( ! haveLastEntity ) {
        // remove old, write out new lastEntity file with default entity
        [sharedFM removeItemAtURL:URLToLastEntity error:&err01];
        if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"lastEntity %@", err01); }
        
        NSString *defaultEntity = @"person=~Anya";
        ret01 = [defaultEntity writeToURL:URLToLastEntity atomically:YES encoding:NSUTF8StringEncoding error:&err01];
        if (!ret01) { NSLog(@"Error write to lastEntity \n  %@", [err01 localizedFailureReason]); }
    }
    // get contents of LastEntity file and
    // populate _mambCurrentEntity and _mambCurrentSelection and _mambCurrentSelectionType
    NSString *lastEntityStr = [[NSString alloc]
                           initWithContentsOfURL:URLToLastEntity
                           encoding:NSUTF8StringEncoding
                           error:&err01
                           ];
    if (lastEntityStr == nil) {
        NSLog(@"%@", @"Error reading lastEntity");
        lastEntityStr = @"person=~Anya";
    }
    NSLog(@"lastEntityStr=%@", lastEntityStr);
    _arr = [lastEntityStr componentsSeparatedByCharactersInSet:
                    [NSCharacterSet characterSetWithCharactersInString:@"="]];
    // NSLog(@"_arr=%@", _arr);
    _mambCurrentEntity         = _arr[0];  //  group OR Person
    _mambCurrentSelection      = _arr[1];  // like "~Anya" or "~Swim Team"
    _mambCurrentSelectionType  = _arr[0];  //  group OR person or pair
    NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);
    NSLog(@"_mambCurrentSelection=%@",_mambCurrentSelection);
    NSLog(@"_mambCurrentSelectionType=%@",_mambCurrentSelectionType);

    /* highlight correct entity in seg control at top */
    if ([_mambCurrentEntity isEqualToString:@"group"]) {
        _segEntityOutlet.selectedSegmentIndex = 0;
    }
    if ([_mambCurrentEntity isEqualToString:@"person"]) {
        _segEntityOutlet.selectedSegmentIndex = 1;
    }




//    NSMutable_array *arrayTst;
//    arrayTst = [[NSMutableArray alloc] initWithContentsOfURL:URLToGroup];
//    if (arrayTst == nil) { NSLog(@"%@", @"Error reading Grp"); }
//    for (id eltTst in arrayTst) { NSLog(@"eltGrp=%@", eltTst); }
//    arrayTst = [[NSMutableArray alloc] initWithContentsOfURL:URLToPerson];
//    if (arrayTst == nil) { NSLog(@"%@", @"Error reading Per"); }
//    for (id eltTst in arrayTst) { NSLog(@"eltPer=%@", eltTst); }
//    arrayTst = [[NSMutableArray alloc] initWithContentsOfURL:URLToGroupMember];
//    if (arrayTst == nil) { NSLog(@"%@", @"Error reading GrM"); }
//    for (id eltTst in arrayTst) { NSLog(@"eltGrM=%@", eltTst); }
    
    
    
} // - (void)viewDidLoad


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
    // Return the number of rows in the section.
    //return 0;
    //return mambyObjectList.count;
    if ([_mambCurrentEntity isEqualToString:@"group"])  return _arrayGrp.count;
    if ([_mambCurrentEntity isEqualToString:@"person"]) return _arrayPer.count;
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"in cellForRowAtIndexPath");

    // create an NSString  we can use as the reuse identifier
    static NSString *CellIdentifier = @"MyCell1";
    
    // check to see if we can reuse a cell from a row that has just rolled off the screen
    // if there are no cells to be reused, create a new cell
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
//    NSLog(@"in cellForRowAtIndexPath 2222");
//    NSLog(@"all array[%@]", mambyObjectList);
//    NSLog(@"current  row=[%@]", [mambyObjectList objectAtIndex:indexPath.row]);

    // set the text attribute to the name of
    // whatever we are currently looking at in our array
    // name is 1st element in csv
    //
    // NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);

    NSString *currentLine, *nameOfGrpOrPer;
    // NSLog(@"_mambCurrentEntity=%@",_mambCurrentEntity);

    if ([_mambCurrentEntity isEqualToString:@"group"]) {
        currentLine = [_arrayGrp objectAtIndex:indexPath.row];
    } else {
        if ([_mambCurrentEntity isEqualToString:@"person"]) {
            currentLine = [_arrayPer objectAtIndex:indexPath.row];
        } else {
            currentLine = @"Unknown|";
        }
    }
    // NSLog(@"currentLine=%@",currentLine);

    _arr = [currentLine componentsSeparatedByCharactersInSet:
             [NSCharacterSet characterSetWithCharactersInString:@"|"]];
    nameOfGrpOrPer = _arr[0];
    //NSLog(@"nameOfGrpOrPer=%@",nameOfGrpOrPer);
    cell.textLabel.text = nameOfGrpOrPer;
    
//    UIFont *myFont = [ UIFont fontWithName:@"Menlo" size:16];
//    cell.textLabel.font            = myFont;
// cell.textLabel.font.lineHeight = 20;

//    if ([_mambCurrentEntity isEqualToString:@"group"]) {
//        cell.textLabel.text = nameOfGrpOrPer;
//        // cell.textLabel.text = [_arrayGrp objectAtIndex:indexPath.row];
//    } else {
//    if ([_mambCurrentEntity isEqualToString:@"person"])
//        // cell.textLabel.text = [_arrayPer objectAtIndex:indexPath.row];
//    }

//    NSLog(@"in cellForRowAtIndexPath 3333");
//    NSLog(@"current  row 222=[%@]", [mambyObjectList objectAtIndex:indexPath.row]);
//    NSLog(@"text =[%@]", cell.textLabel.text);
    
    // set the detail disclosure indicator
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //   NSLog(@"in cellForRowAtIndexPath 5555");
  
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
//
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"in HOME prepareForSegue!");

    // get the indexpath of current row
    NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];

    /* segueHomeToReportList
    */
    if ([segue.identifier isEqualToString:@"segueHomeToReportList"]) {
        // UINavigationController *nc = segue.destinationViewController;
        // UINavigationController *nc = segue.destinationViewController;
        MAMB09_selectReportsTableViewController *myDestTableViewController = segue.destinationViewController;
        
        myDestTableViewController.fromHomeCurrentSelectionType = _mambCurrentSelectionType; // "group" or "person" or "pair"
        myDestTableViewController.fromHomeCurrentEntity = _mambCurrentEntity; // "group" or "person"

    
        if ([_mambCurrentEntity isEqualToString:@"group"])  {
            // NSLog(@"current  row 231=[%@]", [_arrayGrp objectAtIndex:myIdxPath.row]);
            myDestTableViewController.fromHomeCurrentSelection = [_arrayGrp objectAtIndex:myIdxPath.row];  /* CSV */
        }
        if ([_mambCurrentEntity isEqualToString:@"person"]) {
            // NSLog(@"current  row 232=[%@]", [_arrayPer objectAtIndex:myIdxPath.row]);
            myDestTableViewController.fromHomeCurrentSelection = [_arrayPer objectAtIndex:myIdxPath.row];  /* CSV */
        }
        
        NSLog(@"myDestTableViewController.selectedObjectFromHome =%@",myDestTableViewController.fromHomeCurrentSelection);

    } /* segueHomeToReportList */

    
    
        // myDestTableViewController = [nc.viewControllers objectAtIndex:0]; // First view in nav controller
        
        
        // Is the detailTableViewController embedded in a Navigation Controller? If so, you'll need to access it this way:
//        <.>
//        - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//            if ([[segue identifier] isEqualToString:@"nextScreen"]) {
//                UINavigationController *nc = segue.destinationViewController;
//                DetailTableViewController * detailTableViewController = [nc.viewControllers objectAtIndex:0]; // First view in nav controller
//                NSInteger tagIndex = [(UIButton *)sender tag];
//                detailTableViewController.productType = tagIndex;
//            }
//        <.>

        
        //MAMB09_selectReportsTableViewController *myDestTableViewController =
        // UITableViewController *myDestTableViewController = segue.destinationViewController;
        // MAMB09_selectReportsTableViewController *myDestTableViewController = segue.destinationViewController;
        
//        if ([_mambCurrentEntity isEqualToString:@"group"]) {
//            NSLog(@"current  row 222=[%@]", [_arrayGrp objectAtIndex:myIdxPath.row]);
//            myDestTableViewController.selectedObjectFromHome = [_arrayGrp objectAtIndex:myIdxPath.row]
//        } else if ([_mambCurrentEntity isEqualToString:@"person"]) {
//            NSLog(@"current  row 223=[%@]", [_arrayPer objectAtIndex:myIdxPath.row]);
//            myDestTableViewController.selectedObjectFromHome = [_arrayPer objectAtIndex:myIdxPath.row]
//        }
    
        //myDestTableViewController.delegate = self;
        
//    - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//        if ([segue.identifier isEqualToString:@"showRecipeDetail"]) {
//            NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
//            RecipeDetailViewController *destViewController = segue.destinationViewController;
//            destViewController.recipeName = [recipes objectAtIndex:indexPath.row];
//        }
//    }
    
//        PlayerDetailsViewController *playerDetailsViewController =
//            [[navigationController viewControllers] objectAtIndex:0];
//        playerDetailsViewController.delegate = self;

    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.

//    
//    UITableViewController *SelectTblViewController = [[UITableViewController alloc] init];
//    SelectTblViewController = [segue destinationViewController];
    
    // get the indexpath
    //NSIndexPath *myIdxPath = [self.tableView indexPathForSelectedRow];
    
    // here, pass information to destination tableview
    //if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
        // MyDetailViewController *detailViewController = [segue destinationViewController];
        //  UIViewController *detailViewController = [segue destinationViewController];
    //NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    //detailViewController.data = [self.dataController objectInListAtIndex: myIndexPath.row];

    //}

} /* prepareForSegue */


- (IBAction)actionSwitchEntity:(id)sender {  // segemented control on home page
    NSLog(@"in actionSwitchEntity!");
    NSLog(@"_mambCurrentEntity2=%@",_mambCurrentEntity);

    if ([_mambCurrentEntity isEqualToString:@"group"]) {
        NSLog(@"change grp to per!");
        _mambCurrentEntity     = @"person";
        _mambCurrentSelectionType = @"person";
    } else if ([_mambCurrentEntity isEqualToString:@"person"]){
        NSLog(@"change per to grp!");
        _mambCurrentEntity     = @"group";
        _mambCurrentSelectionType = @"group";
    }

    NSLog(@"_mambCurrentEntity3=%@",_mambCurrentEntity);

    if ([_mambCurrentEntity isEqualToString:@"group"]) {
        _segEntityOutlet.selectedSegmentIndex = 0;
    }
    if ([_mambCurrentEntity isEqualToString:@"person"]) {
        _segEntityOutlet.selectedSegmentIndex = 1;
    }

    NSLog(@"reload table here!");
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    
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

    if ([_mambCurrentEntity isEqualToString:@"group"])   NSLog(@"current  row 225=[%@]", [_arrayGrp objectAtIndex:previouslyselectedIndexPath.row]);
    if ([_mambCurrentEntity isEqualToString:@"person"])  NSLog(@"current  row 226=[%@]", [_arrayPer objectAtIndex:previouslyselectedIndexPath.row]);

    
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



