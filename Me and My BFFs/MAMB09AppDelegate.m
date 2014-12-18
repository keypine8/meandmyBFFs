//
//  MAMB09AppDelegate.m
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import "MAMB09AppDelegate.h"
#import "mamblib.h"

@implementation MAMB09AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"in app delg");
    
    // Override point for customization after application launch.
    
    // to access global method in appDelegate .h and .m
    //MAMB09AppDelegate *gbl_myappDelegate=[[UIApplication sharedApplication] delegate];

    // make all "Back" buttons have just the arrow
    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];     // make all "Back" buttons have just the arrow


    gbl_show_example_data = YES;  // add option later to not show them
    
    gbl_didThisAppJustLaunch = YES;  // hope this runs just once per start or re-awake of this App

    // UIColor uses a 0-1 instead of 0-255 system so you just need to convert it like so:
    //
    gbl_colorReportsBG          = [UIColor alloc];
    gbl_colorSelParamForReports = [UIColor alloc];
    
    //    gbl_colorReportsBG          = [UIColor colorWithRed:242./255.0 green:247./255.0 blue:255./255.0 alpha:1.0];  //  apple blue 2.5
    gbl_colorReportsBG          = [UIColor colorWithRed:238./255.0 green:247./255.0 blue:255./255.0 alpha:1.0];  //  apple blue 2.5  <---
    gbl_colorSelParamForReports = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:136.0/224.0 alpha:1.0];
    gbl_colorSelParamForReports = gbl_colorReportsBG;

    
    
    
    return YES;
    
} // didFinishLaunchingWithOptions


// global method called from anywhere like this:
//MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
//NSString *myStrToUpdate = PSVthatWasFound;
//
//myupdatedStr = [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
//                                        delimitedBy: (NSString *) @"|"
//                           updateOneBasedElementNum: (NSInteger)  myElementNum
//                                     withThisString: (NSString *) changeToThis
//                ];
//
//[gbl_arrayPer replaceObjectAtIndex: arrayIdx  withObject: myupdatedStr];
//
- (NSString *) updateDelimitedString: (NSMutableString *) DSV
                   delimitedBy: (NSString *) delimiters
      updateOneBasedElementNum: (NSInteger)  oneBasedElementnum
                withThisString: (NSString *) newString
{
    // NSLog(@"in updateDelimitedString!");
    // NSLog(@"DSV=%@",DSV);
    // NSLog(@"delimiters=%@",delimiters);
    // NSLog(@"oneBasedElementnum=%ld",(long)oneBasedElementnum);
    // NSLog(@"newString=%@",newString);

    NSArray *myarr = [DSV componentsSeparatedByCharactersInSet: [NSCharacterSet characterSetWithCharactersInString: delimiters]];
    // NSLog(@"myarr=%@",myarr);
    
    NSMutableArray *myMarr = [NSMutableArray arrayWithArray: myarr];
    myMarr[oneBasedElementnum -1] = newString;
    // NSLog(@"myMarr=%@",myMarr);
    
    NSString * updatedStr = [myMarr componentsJoinedByString: @"|"];
  
    // NSLog(@"updatedStr after=%@",updatedStr);
    return updatedStr;
}

- (void) rememberSelectionForEntity: (NSString *) personOrGroup    // eg. input strings = person, ~Liz, year, 2005
                         havingName: (NSString *) entityName
           updatingRememberCategory: (NSString *) rememberCategory
                         usingValue: (NSString *) changeToThis
{
    
//    [myappDelegate rememberSelectionForEntity: (NSString *) @"person"
//                                   havingName: (NSString *) myPSVarr[0]
//                     updatingRememberCategory: (NSString *) @"year"
//                                   usingValue: (NSString *) gbl_selectedYear
//     ];
//NSLog(@"in rememberSelectionForEntity!");
//  NSLog(@"personOrGroup=%@",personOrGroup);
    
    NSString *PSVthatWasFound;
    NSString *prefixStr = [NSString stringWithFormat: @"%@|", entityName];
    NSInteger myElementNum = 0;
    NSInteger arrayIdx;
    NSString *myupdatedStr;

    if ([personOrGroup isEqualToString:@"person"]) {
        // get the PSV of  ~Liz in gbl_arrayPer
        PSVthatWasFound = NULL;
        arrayIdx = 0;
        for (NSString *element in gbl_arrayPer) {
            // NSLog(@"arrayIdx=%ld",(long)arrayIdx);
            // NSLog(@"element=%@",element);

            if ([element hasPrefix: prefixStr]) {
                //NSLog(@"FOUND!!!!!!!!!");
                // NSLog(@"inside for  = arrayIdx=%ld",(long)arrayIdx);

                PSVthatWasFound = element;
                break;
            }
            arrayIdx = arrayIdx + 1;
        }
        // NSLog(@"outside for  = arrayIdx=%ld",(long)arrayIdx);

        if ([rememberCategory isEqualToString: @"year"])   myElementNum = 11;
        if ([rememberCategory isEqualToString: @"day"])    myElementNum = 12;
        if ([rememberCategory isEqualToString: @"person"]) myElementNum = 13;
        if ([rememberCategory isEqualToString: @"group"])  myElementNum = 14;

        if (PSVthatWasFound != NULL) {
            // NSLog(@"in remember!!  before ®gbl_arrayPer =%@",gbl_arrayPer);
            MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // to access global method myappDelegate in appDelegate.m
            NSString *myStrToUpdate = PSVthatWasFound;
            
            myupdatedStr = [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
                                                    delimitedBy: (NSString *) @"|"
                                       updateOneBasedElementNum: (NSInteger)  myElementNum
                                                 withThisString: (NSString *) changeToThis
             ];
            // NSLog(@"arrayIdx=%ld",(long)arrayIdx);
            // NSLog(@"myElementNum=%ld",(long)myElementNum);
            // NSLog(@"gbl_arrayPer[arrayIdx]=%@",gbl_arrayPer[arrayIdx]);

            [gbl_arrayPer replaceObjectAtIndex: arrayIdx  withObject: myupdatedStr];

            // NSLog(@"in remember!!  after gbl_arrayPer =%@",gbl_arrayPer);
        }
        
        

    }
    
    if ([entityName isEqualToString:@"group"]) {
    }
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources,   *SAVE USER DATA*   , invalidate timers,
    // and store enough application state information to restore your application
    // to its current state in case it is terminated later.
    // If your application supports background execution,
    // this method is called instead of applicationWillTerminate: when the user quits.
    //
    
    do {  // save person + group in order to remember the last selections
 
        // all copied from home
        BOOL ret01;   NSError *err01;
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
        NSURL *URLToGroup           = [NSURL fileURLWithPath: pathToGroup isDirectory:NO];
        NSURL *URLToPerson          = [NSURL fileURLWithPath: pathToPerson isDirectory:NO];

        //      remove all regular named files (these cannot exist - no overcopy)
        [sharedFM removeItemAtURL:URLToGroup error:&err01];
        if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grp %@", err01); }
        [sharedFM removeItemAtURL:URLToPerson error:&err01];
        if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"per %@", err01); }
        
        // write out  data files from internal arrays
        ret01 = [gbl_arrayGrp       writeToURL:URLToGroup atomically:YES];
        if (!ret01)  NSLog(@"Error write to Grp \n  %@", [err01 localizedFailureReason]);
        ret01 = [gbl_arrayPer      writeToURL:URLToPerson atomically:YES];
        if (!ret01)  NSLog(@"Error write to Per \n  %@", [err01 localizedFailureReason]);

    } while (FALSE);
    
    
} // applicationDidEnterBackground


- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

