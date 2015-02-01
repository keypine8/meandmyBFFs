//
//  MAMB09AppDelegate.m
//  Me and My BFFs
//
//  Created by Richard Koskela on 2014-09-22.
//  Copyright (c) 2014 Richard Koskela. All rights reserved.
//

#import "MAMB09AppDelegate.h"
#import "mamblib.h"
#import "NSData+MAMB09_NSData_encryption.h"


@implementation MAMB09AppDelegate




#define KEY_LAST_ENTITY_STR  @"myLastEntityStr"

//#define DEFAULT_LAST_ENTITY  @"person|~Anya|group|~SwimTeam"
#define DEFAULT_LAST_ENTITY  @"person|~Sophia|group|~SwimTeam"    // for test  (testing has "~Anya 567789..." , not "~Anya"


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"in didFinishLaunchingWithOptions()  in appdelegate");
    

    // Override point for customization after application launch.
    
    // to access global method in appDelegate .h and .m
    //MAMB09AppDelegate *gbl_myappDelegate=[[UIApplication sharedApplication] delegate];

    // make all "Back" buttons have just the arrow
    [UIBarButtonItem.appearance setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];     // make all "Back" buttons have just the arrow


    // SET GBL DATA  HERE
    

    // This is the initial example data in DB when app first starts.
    // This is NOT the ongoing data, which is in  data files.
    //
    gbl_arrayExaGrp =   // field 1=name-of-group  field 2=locked-or-not
    @[
      @"~Swim Team||",
      @"~My Family||",
    ];

    gbl_arrayExaPer = // field 11= locked or not
    @[
      @"~Father|7|11|1961|11|8|1|Los Angeles|California|United States||",
      @"~Mother|3|12|1965|10|45|0|Los Angeles|California|United States||",
      @"~Sister1|2|31|1988|0|30|1|Los Angeles|California|United States||",
      @"~Sister2|2|13|1990|3|35|0|Los Angeles|California|United States||",
      @"~Brother|11|6|1986|8|1|1|Los Angeles|California|United States||",
      @"~Grandma|8|17|1939|8|5|0|Los Angeles|California|United States||",
      @"~Mike|4|20|1992|6|30|1|Los Angeles|California|United States||",
      @"~Anya 789012345|10|19|1990|8|20|0|Los Angeles|California|United States||",
      @"~Billy 89012345|8|4|1991|10|30|1|Los Angeles|California|United States||",
      @"~Emma|5|17|1993|0|1|1|Los Angeles|California|United States||",
      @"~Jacob|10|10|1992|0|1|1|Los Angeles|California|United States||",
      @"~Grace|8|21|1994|1|20|0|Los Angeles|California|United States||",
      @"~Ingrid|3|13|1993|4|10|1|Los Angeles|California|United States||",
      @"~Jen|6|22|1992|4|10|0|Los Angeles|California|United States||",
      @"~Liz|3|13|1991|4|10|1|Los Angeles|California|United States||",
      @"~Jim|2|3|1993|0|1|1|Los Angeles|California|United States||",
      @"~Olivia|4|13|1994|0|53|1|Los Angeles|California|United States||",
      @"~Dave|4|8|1993|0|1|1|Los Angeles|California|United States||",
      @"~Noah|12|19|1994|11|4|0|Los Angeles|California|United States||",
      @"~Sophia|9|20|1991|4|0|0|Los Angeles|California|United States||",
      @"~Susie|2|3|1992|8|10|0|Los Angeles|California|United States||",
    ];

    gbl_arrayExaMem = // field 11= locked or not
    @[
      @"~My Family|~Brother|",
      @"~My Family|~Father|",
      @"~My Family|~Grandma|",
      @"~My Family|~Mother|",
      @"~My Family|~Sister1|",
      @"~My Family|~Sister2|",
      @"~Swim Team|~Anya|",
      @"~Swim Team|~Billy 89012345|",
      @"~Swim Team|~Dave|",
      @"~Swim Team|~Emma|",
      @"~Swim Team|~Grace|",
      @"~Swim Team|~Ingrid|",
      @"~Swim Team|~Jacob|",
      @"~Swim Team|~Jen|",
      @"~Swim Team|~Jim|",
      @"~Swim Team|~Liz|",
      @"~Swim Team|~Mike|",
      @"~Swim Team|~Noah|",
      @"~Swim Team|~Olivia|",
      @"~Swim Team|~Sophie|",
      @"~Swim Team|~Susie|",
    ];

    // REMEMBER DATA for each Group 
    //     field 1  name-of-group
    //     field 2  last report selected for this Group:
    //              ="gbm"  for   "Best Match"
    //              ="gma"  for   "Most Assertive Person"
    //              ="gme"  for   "Most Emotional"
    //              ="gmr"  for   "Most Restless"
    //              ="gmp"  for   "Most Passionate"
    //              ="gmd"  for   "Most Down-to-earth"
    //              ="gmu"  for   "Most Ups and Downs"
    //              ="gby"  for   "Best Year ..."
    //              ="gbd"  for   "Best Day ..."
    //     field  3  last year  last selection for this report parameter for this Group
    //     field  4  day        last selection for this report parameter for this Group
    //     + extra "|" at end
    // 
    gbl_arrayExaGrpRem = 
    @[
      @"~Family||||",
      @"~My Family||||",
    ];

    // REMEMBER DATA for each Person
    //     field 1  name-of-person
    //     field 2  last report selected for this Person:
    //              ="pbm"  for   "Best Match"
    //              ="pcy"  for   "Calendar Year ...",
    //              ="ppe"  for   "Personality",
    //              ="pco"  for   "Compatibility Paired with ...",
    //              ="pbg"  for   "My Best Match in Group ...",
    //              ="pwc"  for   "What color is today? ...",
    //     field 3  last year
    //     field 4  person (this is 2nd person for rpt pco|Compatibility Paired with ...)
    //                      NOT home, which is saved with   file for  myLastEntityStr, mambd1
    //     field 5  group
    //     field 6  day
    //              extra "|" at end
    //
    gbl_arrayExaPerRem = 
    @[
      @"~Father||||||",
      @"~Mother||||||",
      @"~Sister1||||||",
      @"~Sister2||||||",
      @"~Brother||||||",
      @"~Grandma||||||",
      @"~Mike||||||",
      @"~Anya 789012345||||||",
      @"~Billy 89012345||||||",
      @"~Emma||||||",
      @"~Jacob||||||",
      @"~Grace||||||",
      @"~Ingrid||||||",
      @"~Jen||||||",
      @"~Liz||||||",
      @"~Jim||||||",
      @"~Olivia||||||",
      @"~Dave||||||",
      @"~Noah||||||",
      @"~Sophia||||||",
      @"~Susie||||||",
    ];


//
//    gbl_mambReportsPerson =
//    @[
//        @"Calendar Year ...",
//        @"Personality",
//        @"Compatibility Paired with ...",
//        @"My Best Match in Group ...",
//        @"What Color is Today? ...",
//    ];
//    gbl_mambReportsGroup =
//    @[
//        @"Best Match",
//        @"",
//        @"Most Assertive Person",
//        @"Most Emotional",
//        @"Most Restless",
//        @"Most Passionate",
//        @"Most Down-to-earth",
//        @"Most Ups and Downs",
//        @"",
//        @"Best Year ...",
//        @"Best Day ...",
//    ];
//    gbl_mambReportsPair =
//    @[
//        @"Compatibility Potential",
//        @"",
//        @"<per1> Best Match",
//        @"<per1> Personality",
//        @"<per1> Calendar Year ...",
//        @"",
//        @"<per2> Best Match",
//        @"<per2> Personality",
//        @"<per2> Calendar Year ...",
//    ];
//
    gbl_mambReports =
    @[
        @"pcy|Calendar Year ...",             // person reports
        @"ppe|Personality",
        @"pco|Compatibility Paired with ...",
        @"pbm|My Best Match in Group ...",
        @"pwc|What Color is Today? ...",
        @"p|",
        @"gbm|Best Match",                    // group reports
        @"g|",
        @"gma|Most Assertive Person",
        @"gme|Most Emotional",
        @"gmr|Most Restless",
        @"gmp|Most Passionate",
        @"gmd|Most Down-to-earth",
        @"gmu|Most Ups and Downs",
        @"g|",
        @"gby|Best Year ...",
        @"gbd|Best Day ...",
        @"2co|Compatibility Potential",       // pair reports
        @"2|",
        @"2bm|<per1> Best Match",
        @"21p|<per1> Personality",
        @"21c|<per1> Calendar Year ...",
        @"2|",
        @"22m|<per2> Best Match",
        @"22p|<per2> Personality",
        @"22c|<per2> Calendar Year ...",
    ];
    


    gbl_show_example_data = YES;  // add option later to not show them
    
    // UIColor uses a 0-1 instead of 0-255 system so you just need to convert it like so:
    //
    gbl_colorReportsBG          = [UIColor alloc];
    gbl_colorSelParamForReports = [UIColor alloc];
    
    //    gbl_colorReportsBG          = [UIColor colorWithRed:242./255.0 green:247./255.0 blue:255./255.0 alpha:1.0];  //  apple blue 2.5
    gbl_colorReportsBG          = [UIColor colorWithRed:238.0/255.0 green:247.0/255.0 blue:255.0/255.0 alpha:1.0];  //  apple blue 2.5  <---
    gbl_colorSelParamForReports = [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:136.0/224.0 alpha:1.0];
    gbl_colorSelParamForReports = gbl_colorReportsBG;

    

    // get Document directory as URL and Str
    //
    gbl_sharedFM = [NSFileManager defaultManager];
    gbl_possibleURLs = [gbl_sharedFM URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
    gbl_appDocDirURL = nil;
    if ([gbl_possibleURLs count] >= 1) {
        gbl_appDocDirURL = [gbl_possibleURLs objectAtIndex:0];
    }
    gbl_appDocDirStr = [gbl_appDocDirURL path];
    
    // get DB names as URL and Str
    gbl_pathToGroup  = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd2"];  // @"mambGroup.txt"];
    gbl_pathToPerson = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd3"];  // @"mambPerson.txt"];
    gbl_pathToMember = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd4"];  // @"mambMember.txt"];
//    gbl_pathToGrpExa = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd5"];  // group  example data
//    gbl_pathToPerExa = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd6"];  // person example data
//    gbl_pathToMemExa = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd7"];  // member example data
//

    gbl_pathToGrpRem = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd5"];  // group  remember data
    gbl_pathToPerRem = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd6"];  // person remember data

    gbl_URLToGroup   = [NSURL fileURLWithPath: gbl_pathToGroup  isDirectory:NO];
    gbl_URLToPerson  = [NSURL fileURLWithPath: gbl_pathToPerson isDirectory:NO];
    gbl_URLToMember  = [NSURL fileURLWithPath: gbl_pathToMember isDirectory:NO];
//    gbl_URLToGrpExa  = [NSURL fileURLWithPath: gbl_pathToGrpExa isDirectory:NO];
//    gbl_URLToPerExa  = [NSURL fileURLWithPath: gbl_pathToPerExa isDirectory:NO];
//    gbl_URLToMemExa  = [NSURL fileURLWithPath: gbl_pathToMemExa isDirectory:NO];
//
    gbl_URLToGrpRem  = [NSURL fileURLWithPath: gbl_pathToGrpRem isDirectory:NO];
    gbl_URLToPerRem  = [NSURL fileURLWithPath: gbl_pathToPerRem isDirectory:NO];

    
    //  end of   SET GBL DATA  HERE
    
    return YES;
    
} // didFinishLaunchingWithOptions


// global method called from anywhere like this:
//MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
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
    
} // updateDelimitedString



// <.> TODO  ?? after remembering N things, write out the remember Files    todo ??
//
//    [myappDelegate selectionMemorizeForEntity: (NSString *) @"person"
//                                   havingName: (NSString *) myPSVarr[0]
//                     updatingRememberCategory: (NSString *) @"year"
//                                   usingValue: (NSString *) gbl_lastSelectedYear
//     ];

//e.g.
//        [myappDelegate selectionMemorizeForEntity: (NSString *) @"person"
//                                       havingName: (NSString *) gbl_fromHomeCurrentEntityName
//                         updatingRememberCategory: (NSString *) @"rptsel"
//                                       usingValue: (NSString *) @"pcy"
//        ];
//
//- (void) selectionMemorizeForEntity: (NSString *) personOrGroup    // eg. input strings = person, ~Liz, year, 2005
- (void) saveLastSelectionForEntity: (NSString *) argPersonOrGroup    // eg. input strings = person, ~Liz, year, 2005
                         havingName: (NSString *) argEntityName
           updatingRememberCategory: (NSString *) argRememberCategory
                         usingValue: (NSString *) argChangeToThis
{
NSLog(@"in saveLastSelectionForEntity !");
    
    NSString *PSVthatWasFound;
    NSString *prefixStr = [NSString stringWithFormat: @"%@|", argEntityName];
    NSInteger myElementNum = 0;
    NSInteger arrayIdx;
    NSString *myupdatedStr;

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

    if ([argPersonOrGroup isEqualToString:@"person"]) {

        // get the PSV of  ~Liz in gbl_arrayPerRem
        PSVthatWasFound = NULL;
        arrayIdx = 0;
        for (NSString *element in gbl_arrayPerRem) {
            if ([element hasPrefix: prefixStr]) {
                PSVthatWasFound = element;
                break;
            }
            arrayIdx = arrayIdx + 1;
        }

        if      ([argRememberCategory isEqualToString: @"rptsel"]) myElementNum = 2;  // one-based index number
        else if ([argRememberCategory isEqualToString: @"year"])   myElementNum = 3;
        else if ([argRememberCategory isEqualToString: @"person"]) myElementNum = 4;
        else if ([argRememberCategory isEqualToString: @"group"])  myElementNum = 5;
        else if ([argRememberCategory isEqualToString: @"day"])    myElementNum = 6;
        else {
            NSLog(@"should not happen   cannot find group  rememberCategory= %@", argRememberCategory );
            return;  // should not happen
        }

        if (PSVthatWasFound != NULL) {
            // NSLog(@"in remember!!  before ®gbl_arrayPerRem =%@",gbl_arrayPerRem);
            NSString *myStrToUpdate = PSVthatWasFound;
            
            myupdatedStr = [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
                                                    delimitedBy: (NSString *) @"|"
                                       updateOneBasedElementNum: (NSInteger)  myElementNum
                                                 withThisString: (NSString *) argChangeToThis ];
            // NSLog(@"arrayIdx=%ld",(long)arrayIdx);
            // NSLog(@"myElementNum=%ld",(long)myElementNum);
            // NSLog(@"gbl_arrayPerRem[arrayIdx]=%@",gbl_arrayPerRem[arrayIdx]);

            [gbl_arrayPerRem replaceObjectAtIndex: arrayIdx  withObject: myupdatedStr];

        }
    }  // person
    

    if ([argPersonOrGroup isEqualToString:@"group"]) {
        // get the PSV of  "~Swim Team" in gbl_arrayGrpRem
        PSVthatWasFound = NULL;
        arrayIdx = 0;
        for (NSString *element in gbl_arrayGrpRem) {
            if ([element hasPrefix: prefixStr]) {
                PSVthatWasFound = element;
                break;
            }
            arrayIdx = arrayIdx + 1;
        }

        if      ([argRememberCategory isEqualToString: @"rptsel"]) myElementNum = 2;  // one-based index number
        else if ([argRememberCategory isEqualToString: @"year"])   myElementNum = 3;
        else if ([argRememberCategory isEqualToString: @"day"])    myElementNum = 4;
        else {
            NSLog(@"should not happen   cannot find group  rememberCategory= %@", argRememberCategory );
            return;  // should not happen
        }


        if (PSVthatWasFound != NULL) {
            // NSLog(@"in remember!!  before ®gbl_arrayGrpRem =%@",gbl_arrayGrpRem);
            NSString *myStrToUpdate = PSVthatWasFound;
            myupdatedStr = [myappDelegate updateDelimitedString: (NSMutableString *) myStrToUpdate
                                                    delimitedBy: (NSString *) @"|"
                                       updateOneBasedElementNum: (NSInteger)  myElementNum
                                                 withThisString: (NSString *) argChangeToThis ];
            // NSLog(@"arrayIdx=%ld",(long)arrayIdx);
            // NSLog(@"myElementNum=%ld",(long)myElementNum);
            // NSLog(@"gbl_arrayGrpRem[arrayIdx]=%@",gbl_arrayGrpRem[arrayIdx]);

            [gbl_arrayGrpRem replaceObjectAtIndex: arrayIdx  withObject: myupdatedStr];

            // NSLog(@"in memorize!!  after gbl_arrayGrpRem =%@",gbl_arrayGrpRem);
        }
    }
    
NSLog(@"in saveLastSelectionForEntity !!  after gbl_arrayGrpRem =%@",gbl_arrayGrpRem);
NSLog(@"in saveLastSelectionForEntity !!  after gbl_arrayPerRem =%@",gbl_arrayPerRem);
    gbl_fromHomeCurrentSelectionPSV = myupdatedStr;

} // saveLastSelectionForEntity 


// grabLastSelectionValueForEntity
//
// for rememberCategory = "rptsel",   returns 3-char code string to search for in report selection table
// for rememberCategory = "person",   returns string to search for gbl_arrayPer
// for rememberCategory = "group",    returns string to search for gbl_arrayGrp
// for rememberCategory = "year",     returns string year
// for rememberCategory = "day",      returns string day
//
- (NSString *) grabLastSelectionValueForEntity: (NSString *) argPersonOrGroup 
                                    havingName: (NSString *) argEntityName
                          fromRememberCategory: (NSString *) argRememberCategory
{
    NSInteger myPSVfldNum = 0;
    NSArray  *myRemArr;
    NSInteger myRemArrIdx = 0;
    NSString *myRemPSV;
    NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"|"]; // separators



    myRemPSV    = nil;
    myRemArrIdx = -1;  // one-based above

    // init by entity type   per or grp
    //
    if ([argPersonOrGroup isEqualToString:@"person"]) {
        myRemArr = gbl_arrayPerRem;
                                                                                  // get element fld num in PSV 
        if      ([argRememberCategory isEqualToString: @"rptsel"]) myPSVfldNum = 2;  // one-based fld number
        else if ([argRememberCategory isEqualToString: @"year"])   myPSVfldNum = 3;
        else if ([argRememberCategory isEqualToString: @"person"]) myPSVfldNum = 4;
        else if ([argRememberCategory isEqualToString: @"group"])  myPSVfldNum = 5;
        else if ([argRememberCategory isEqualToString: @"day"])    myPSVfldNum = 6;
        else  
            return nil; // should not happen
    }

    if ([argPersonOrGroup isEqualToString:@"group"]) {
        myRemArr = gbl_arrayGrpRem;
                                                                                  // get element fld num in PSV 
        if      ([argRememberCategory isEqualToString: @"rptsel"]) myPSVfldNum = 2;  // one-based fld number
        else if ([argRememberCategory isEqualToString: @"year"])   myPSVfldNum = 3;
        else if ([argRememberCategory isEqualToString: @"day"])    myPSVfldNum = 4;
        else  
            return nil; // should not happen
    }


    for (NSString *elt in myRemArr) {  // get PSV of remembered data for this entity
        if ([elt hasPrefix: argEntityName]) {
            myRemPSV = elt;
            break;
        }
        myRemArrIdx =  myRemArrIdx + 1;
    }
    if (myRemPSV) {                           // get remembered value
        myRemArr = [myRemPSV componentsSeparatedByCharactersInSet: myNSCharacterSet];
        return myRemArr[myPSVfldNum -1]; // one-based 
    }

    return nil; // should not happen
} // end of lastSelTblIdxForEntity




- (NSString *) mambMapString: (NSString *) argStringToMap
           usingWhichMapping: (NSInteger ) whichMapping
             doingMapOrUnmap: (NSString *) mapOrUnmap
{
    NSString *returnNSString;
    const char *myStringToMapC_CONST;    
    char        myStringToMapCstring[1024];
    const char *myMapOrUnmapC_CONST;     
    char        myMapOrUnmapCstring[1024];

    myStringToMapC_CONST = [argStringToMap cStringUsingEncoding:NSUTF8StringEncoding];       // convert NSString to c string
    strcpy(myStringToMapCstring, myStringToMapC_CONST);                                      // convert NSString to c string

    myMapOrUnmapC_CONST = [mapOrUnmap cStringUsingEncoding:NSUTF8StringEncoding];        // convert NSString to c string
    strcpy(myMapOrUnmapCstring, myMapOrUnmapC_CONST);                                     // convert NSString to c string

//    trn("mapbefore");ksn(myStringToMapCstring);
    domap(
        myStringToMapCstring, 
        (int)whichMapping,
        myMapOrUnmapCstring
    );                                                   // (2) map  c string in place 
//    trn("mapafter ");ksn(myStringToMapCstring);

    returnNSString = [NSString stringWithUTF8String: myStringToMapCstring];                  // (3) convert c string to NSString 
    //NSLog(@"returnNSString=%@", returnNSString);

    return returnNSString;
} // mambMapString




- (void) mambWriteNSArrayWithDescription:  (NSString *) argEntityDescription  // like "group","person"
{
    NSLog(@"in mambWriteNSArrayWithDescription: %@  ----------", argEntityDescription  );
    NSError *err01;
    NSURL   *myURLtoWriteTo;
    NSArray *myArray;
    NSData  *myArchive;
    NSData  *myWriteable;


    // determine what array to write  and  where to write it
    //                                                           -------------------------------------------------------------------------
    //                                                                              file to write to             array to write           
    //                                                           -------------------------------------------------------------------------
    //
    if ([argEntityDescription isEqualToString:@"group"])         { myURLtoWriteTo = gbl_URLToGroup;    myArray = gbl_arrayGrp;    }
    if ([argEntityDescription isEqualToString:@"person"])        { myURLtoWriteTo = gbl_URLToPerson;   myArray = gbl_arrayPer;    }
    if ([argEntityDescription isEqualToString:@"member"])        { myURLtoWriteTo = gbl_URLToMember;   myArray = gbl_arrayMem;    }

    if ([argEntityDescription isEqualToString:@"grprem"])        { myURLtoWriteTo = gbl_URLToGrpRem;   myArray = gbl_arrayGrpRem; }
    if ([argEntityDescription isEqualToString:@"perrem"])        { myURLtoWriteTo = gbl_URLToPerRem;   myArray = gbl_arrayPerRem; }

    if ([argEntityDescription isEqualToString:@"examplegroup"])  { myURLtoWriteTo = gbl_URLToGroup;    myArray = gbl_arrayExaGrp; }
    if ([argEntityDescription isEqualToString:@"exampleperson"]) { myURLtoWriteTo = gbl_URLToPerson;   myArray = gbl_arrayExaPer; }
    if ([argEntityDescription isEqualToString:@"examplemember"]) { myURLtoWriteTo = gbl_URLToMember;   myArray = gbl_arrayExaMem; }
    //                                                           -------------------------------------------------------------------------


//    NSLog(@"in writensarray myArray=%@",myArray);

    [gbl_sharedFM removeItemAtURL: myURLtoWriteTo  error:&err01];     // remove old (because no overcopy)
    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Error on write %@= %@", argEntityDescription, err01); }

    myArchive   = [NSKeyedArchiver  archivedDataWithRootObject: myArray];
//tn();  NSLog(@"myArchive=\n%@",myArchive);

    //myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myNSData]; 
    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
    myWriteable = [myappDelegate mambKriptOnThisNSData: (NSData *) myArchive];
//tn();  NSLog(@"myWriteable=\n%@",myWriteable );

    BOOL ret01 = [myWriteable writeToURL: myURLtoWriteTo  atomically:YES];
    if (!ret01)  NSLog(@"Error write to %@ \n  %@", argEntityDescription, [err01 localizedFailureReason]);

} // end of mambWriteNSArrayWithDescription



// READ   there are 5  entity/array files to READ
//
- (void) mambReadArrayFileWithDescription: (NSString *) entDesc     // argEntityDescription  // like "group","person"
{
    NSLog(@"in mambReadArrayFileWithDescription: %@  ----------", entDesc  );
    NSURL   *myURLtoReadFrom;
    NSData  *myWritten;
    NSData  *myNSData;
    NSData  *myUnarchived;
    NSMutableArray *my_gbl_array;

    if ([entDesc isEqualToString:@"group"])         { myURLtoReadFrom = gbl_URLToGroup;    my_gbl_array = gbl_arrayGrp;    }
    if ([entDesc isEqualToString:@"person"])        { myURLtoReadFrom = gbl_URLToPerson;   my_gbl_array = gbl_arrayPer;    }
    if ([entDesc isEqualToString:@"member"])        { myURLtoReadFrom = gbl_URLToMember;   my_gbl_array = gbl_arrayMem;    }
    if ([entDesc isEqualToString:@"grprem"])        { myURLtoReadFrom = gbl_URLToGrpRem;   my_gbl_array = gbl_arrayGrpRem; }
    if ([entDesc isEqualToString:@"perrem"])        { myURLtoReadFrom = gbl_URLToPerRem;   my_gbl_array = gbl_arrayPerRem; }

    myWritten = [[NSData alloc] initWithContentsOfURL: myURLtoReadFrom];
    if (myWritten == nil) { NSLog(@"%@", @"Error reading mambd2"); }
//tn();  NSLog(@"myWritten=\n%@",myWritten);

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//NSLog(@"myappDelegate=%@", myappDelegate);
    myNSData = [myappDelegate mambKriptOffThisNSData: (NSData *) myWritten];
//tn();  NSLog(@"myNSData=\n%@",myNSData);

    myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myNSData]; 
//tn();  NSLog(@"myUnarchived=\n%@",myUnarchived );

    //if ([entDesc isEqualToString:@"group"])         { gbl_arrayGrp       = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myLocalArray]; }
    if ([entDesc isEqualToString:@"group"])         { gbl_arrayGrp       = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"person"])        { gbl_arrayPer       = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"member"])        { gbl_arrayMem       = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"grprem"])        { gbl_arrayGrpRem    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
    if ([entDesc isEqualToString:@"perrem"])        { gbl_arrayPerRem    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }

} // end of mambReadArrayFileWithDescription




- (NSData *) mambKriptOnThisNSData:  (NSData *)  argMyArchive   // arg is NSData/archived, returns a file-writeable NSData
{
//tn();trn("in KRIPT ON");
    NSString      *myKeyStr = @"Lorem ipsum calor sit amet, cons"; // len 32
    NSData        *myEncrypted;
    NSData        *myb64Data; 
    NSMutableData *myb64Muta; 

    myEncrypted = [argMyArchive AES256EncryptWithKey: myKeyStr];               // (1) argMyArchive to myEncrypted
//    printf("myEncrypted=     KriptOn\n%s\n", [[myEncrypted description] UTF8String]);

    myb64Data   = [myEncrypted base64EncodedDataWithOptions: 0];              // (2) myEncrypted to myb64Data
//tn();  NSLog(@"myb64Data=     KriptOn\n%@",myb64Data);

    myb64Muta   = [[NSMutableData alloc] initWithData: myb64Data];            // (3) myb64Data to myb64Muta obfuscated (in place)
    uint8_t *bytes = (uint8_t *)[myb64Muta bytes];                            
    uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44}; 
    const int patternLengthInBytes = 8;    // len 64 bit
    for(int index = 0; index < [myb64Data length]; index++) {
         bytes[index] ^= pattern[index % patternLengthInBytes];
    }
//tn();  NSLog(@"myb64MutaOBFUSCATED=     KriptOn\n%@",myb64Muta);

    return myb64Muta;

} // end of mambKriptOnThisNSData


- (NSData *) mambKriptOffThisNSData: (NSData *)  argMyNSData  //  arg is a file-writeable NSData, returns an NSData/archived
{
//tn();trn("in KRIPT OFF");
    NSMutableData *myb64Muta; 
    NSString      *myKeyStr = @"Lorem ipsum calor sit amet, cons"; // len 32
    NSData        *myEncrypted;
    NSData        *myArchive; 

    myb64Muta   = [[NSMutableData alloc] initWithData: argMyNSData];         // (3) myb64Muta obfuscated to myb64Muta (in place)
    uint8_t *bytes = (uint8_t *)[myb64Muta bytes];                       
    uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44};
    const int patternLengthInBytes = 8;
    for(int index = 0; index < [myb64Muta length]; index++) {
        bytes[index] ^= pattern[index % patternLengthInBytes];
    }
//tn();  NSLog(@"myb64Muta=     KriptOff\n%@",myb64Muta);

    myEncrypted = [[NSData alloc] initWithBase64EncodedData: myb64Muta       // (2) myb64Muta to myEncrypted
                                                    options: 0];  
//tn();  NSLog(@"myEncrypted=     KriptOff\n%@",myEncrypted );

    myArchive = [myEncrypted AES256DecryptWithKey: myKeyStr];                // (2) myEncrypted to myArchive
//    NSLog(@"myArchive=     KriptOff\n%@",myArchive);
    //printf("myArchiveSTR=\n%s\n", [[myArchive description] UTF8String]);

    return myArchive;

} // end of mambKriptOffThisNSData



//- (void) mambWriteLastEntityFileIntoDir: (NSString *)      argAppDocDirStr
//                       usingFileManager: (NSFileManager *) argSharedFM
//
- (void) mambWriteLastEntityFile
{
    NSLog(@"in mambWriteLastEntityFile() ----------");

    //NSString *pathToLastEntity = [argAppDocDirStr stringByAppendingPathComponent: @"mambLastEntity.txt"];
    NSString *pathToLastEntity = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd1"];
    NSURL     *URLToLastEntity = [NSURL fileURLWithPath: pathToLastEntity isDirectory:NO];
    NSError *err01;

    NSData     *myLastEntityArchive;    
    NSData     *myLastEntityDataFil;        //  final NSData to write to file

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global method myappDelegate in appDelegate.m

    [gbl_sharedFM removeItemAtURL:URLToLastEntity // remove old (because no overcopy), write out new lastEntity file with current entity
                        error:&err01];
    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"lastEntity %@", err01); }

        // 20150113, 20150121 NEW FORMAT=  exampl "person|~Jim|group|~Family"  which means the following:
        //    1. set "person" on home segemented control  (1st attribute is what to put on home screen)
        //    2. set grey highlight on row for "~Jim"
        //    3. set gbl_lastSelectedGroup = "~Family"
        //NSLog(@"enterBG_gbl_lastSelectedPerson=%@", gbl_lastSelectedPerson);
        //NSLog(@"enterBG_gbl_lastSelectedGroup=%@" , gbl_lastSelectedGroup);
        //NSLog(@"enterBG_gbl_fromHomeCurrentSelectionType=%@", gbl_fromHomeCurrentSelectionType); // determines who goes first attribute
        //
   
    if (gbl_lastSelectedPerson == NULL ||  gbl_lastSelectedGroup == NULL  ||   gbl_fromHomeCurrentSelectionType == NULL ||
        gbl_lastSelectedPerson.length == 0 ||  gbl_lastSelectedGroup.length == 0  ||   gbl_fromHomeCurrentSelectionType.length == 0 ) {

        self.myLastEntityStr =  DEFAULT_LAST_ENTITY  ;  // DEFAULT lastEntity

    } else {  // not empty vars
        if ([gbl_fromHomeCurrentSelectionType isEqualToString:@"person"]) {     // determine if group or person goes first
            self.myLastEntityStr = [NSString stringWithFormat:@"person|%@|group|%@", gbl_lastSelectedPerson, gbl_lastSelectedGroup];
        } else {
            self.myLastEntityStr = [NSString stringWithFormat:@"group|%@|person|%@", gbl_lastSelectedGroup, gbl_lastSelectedPerson];
        }
    }
    NSLog(@"self.myLastEntityStr=%@",self.myLastEntityStr);


//tn();trn("ENCODE HERE :");
       myLastEntityArchive = [NSKeyedArchiver  archivedDataWithRootObject: self.myLastEntityStr];
//tn();  NSLog(@"myLastEntityArchive =\n%@",myLastEntityArchive );

       myLastEntityDataFil = [myappDelegate mambKriptOnThisNSData: (NSData *) myLastEntityArchive];
//tn();  NSLog(@"myLastEntityDataFil =\n%@", myLastEntityDataFil);
       
    // This will ensure that your save operation has a fighting chance to successfully complete,
    // even if the app is interrupted.
    //
    // get background task identifier before you dispatch the save operation to the background
    UIApplication *application = [UIApplication sharedApplication];
    UIBackgroundTaskIdentifier __block task = [application beginBackgroundTaskWithExpirationHandler:^{
        if (task != UIBackgroundTaskInvalid) {
            [application endBackgroundTask:task];
            task = UIBackgroundTaskInvalid;
        }
    }];
    // now dispatch the save operation
    dispatch_async(dispatch_get_main_queue(),  ^{
        // do the save operation here
        [myLastEntityDataFil writeToURL:URLToLastEntity
                             atomically:YES ];

        // now tell the OS that you're done
        if (task != UIBackgroundTaskInvalid) {
            [application endBackgroundTask:task];
            task = UIBackgroundTaskInvalid;
        }
     });



BOOL haveLastEntity        = [gbl_sharedFM fileExistsAtPath: pathToLastEntity];
NSLog(@"haveLastEntity= %d", haveLastEntity);
tn();trn("finished WRITE   lastEntity");

} // end of    mambWriteLastEntityFile()



//- (NSString *) mambReadLastEntityFileFromDir: (NSString *)      argAppDocDirStr
//                            usingFileManager: (NSFileManager *) argSharedFM
//
- (NSString *) mambReadLastEntityFile
{
    NSLog(@"in mambReadLastEntityFile() ----------");
    //NSString *pathToLastEntity = [argAppDocDirStr stringByAppendingPathComponent: @"mambLastEntity.txt"];
    NSString *pathToLastEntity = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd1"];
    NSURL     *URLToLastEntity = [NSURL fileURLWithPath: pathToLastEntity isDirectory:NO];

    NSData     *myLastEntityDataFil;        // NSData in file
    NSData     *myLastEntityArchive;
    NSString   *myLastEntityDecoded;    

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m

    // for test, remove lastEntity file
    //  [argSharedFM removeItemAtURL:URLToLastEntity
    //                      error:&err01];
    //  if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"lastEntity test rm %@", err01); }

    BOOL haveLastEntity        = [gbl_sharedFM fileExistsAtPath: pathToLastEntity];
//    NSLog(@"haveLastEntity= %d", haveLastEntity);

// haveLastEntity = NO; // for test

    if ( ! haveLastEntity ) {
        // the write below, because there is no lastEntity file "mambd1",
        // removes the old lastEntity file and writes out new lastEntity file with DEFAULT entity

        //MAMB09AppDelegate *myappDelegate=[[UIApplication sharedApplication] delegate]; // for global method myappDelegate in appDelegate.m
        [myappDelegate mambWriteLastEntityFile];
        myLastEntityDecoded  =  DEFAULT_LAST_ENTITY;  // DEFAULT lastEntity from mambWriteLastEntityFileIntoDir
    } else {

        // here we have the lastEntity file, so read and decode it
        //
        myLastEntityDataFil = [[NSData alloc] initWithContentsOfURL:URLToLastEntity ];    // READ READ READ READ READ READ READ READ 
//tn();           NSLog(@"myLastEntityDataFil=%@",myLastEntityDataFil);

//        tn();trn("DECODE lastEntity  HERE :");

        myLastEntityArchive = [myappDelegate mambKriptOffThisNSData: (NSData *) myLastEntityDataFil];
//tn();  NSLog(@"myLastEntityArchive =\n%@",myLastEntityArchive );
       
        myLastEntityDecoded = [NSKeyedUnarchiver unarchiveObjectWithData: myLastEntityArchive]; 
//tn();  NSLog(@"myLastEntityDecoded=\n%@",myLastEntityDecoded); // should = gbl_arrayGrp
    }

    return myLastEntityDecoded;

} // end of  mambReadLastEntityFile()




- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state.
    // This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message)
    // or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates.
    // Games should use this method to pause the game.

    NSLog(@"in applicationWillResignActive()  in appdelegate");


    NSLog(@"finished  applicationWillResignActive()  in appdelegate");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources,   *SAVE USER DATA*   , invalidate timers,
    // and store enough application state information to restore your application
    // to its current state in case it is terminated later.
    // If your application supports background execution,
    // this method is called instead of applicationWillTerminate: when the user quits.
    //
    NSLog(@"applicationDidEnterBackground()!  in appdelegate");

    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m


// CHANGE  20150127  Separate out "remember" data from gbl_arrayPer and gbl_arrayGrp into their own file
// CHANGE  20150127  write ONLY "remember" data here at "end of app" not per,grp

    // 1. save person + group in order to remember the last user report parameter selections for each person and for each group
    // 2.   Note: any changes done to per,grp,grpmember  are saved right away in green edit screens
    // 3. also save lastentity.dat to highlight correct entity in seg control at top
    // 
    //BOOL ret01;
    NSError *err01;

    //      remove all regular named files (these cannot exist - no overcopy)
    [gbl_sharedFM removeItemAtURL: gbl_URLToGroup error:&err01];
    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"grp %@", err01); }
    [gbl_sharedFM removeItemAtURL: gbl_URLToPerson error:&err01];
    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"per %@", err01); }
    nb(2);
 
    // write out  data files from internal arrays

    //[myappDelegate mambWriteGroupArray: (NSArray *) gbl_arrayGrp];  // data moved to remember files
    //[myappDelegate mambWritePersonArray: (NSArray *) gbl_arrayPer]; 

    [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"grprem"];  // only remember files (data dealt with at change time)
    [myappDelegate mambWriteNSArrayWithDescription: (NSString *) @"perrem"];
//<.> TODO  done ?


    [myappDelegate mambWriteLastEntityFile];
    

//    NSString *pathToLastEntity = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambd1"];
//BOOL haveLastEntity        = [gbl_sharedFM fileExistsAtPath: pathToLastEntity];
//NSLog(@"haveLastEntity= %d", haveLastEntity);
//

    NSLog(@"finished  did enter BG!");
} // applicationDidEnterBackground



- (void)applicationWillEnterForeground:(UIApplication *)application
{
    NSLog(@"in applicationWillEnterForeground()  in appdelegate");
    // Called as part of the transition from the background to the inactive state;
    // here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application
{
    NSLog(@"in applicationDidBecomeActive()  in appdelegate");
    // Restart any tasks that were paused (or not yet started) while the application was inactive.
    // If the application was previously in the background, OPTIONALLY REFRESH THE USER INTERFACE.
}

//+(BOOL)isJailbroken {
- (BOOL)isJailbroken {
    NSURL* url = [NSURL URLWithString:@"cydia://package/com.example.package"];
    return [[UIApplication sharedApplication] canOpenURL:url];
}


- (void)applicationWillTerminate:(UIApplication *)application
{
    NSLog(@"in applicationWillTerminate()  in appdelegate");
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end



        // - (void)setOutputFormat:(NSPropertyListFormat)format
        // // The format in which the receiver encodesits data.
        // // The available formats are NSPropertyListXMLFormat_v1_0 and NSPropertyListBinaryFormat_v1_0.
        //    NSKeyedUnarchiver *myUnarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:codedData];
        //    [myUnarchiver setOutputFormat: (NSPropertyListFormat)NSPropertyListBinaryFormat_v1_0]
   
            
    // new base64 etc.
    //
    // Convert string to nsdata e.g.
    //   NSData   *dataFromString = [NSKeyedArchiver   archivedDataWithRootObject: aString];
    //   NSString *stringFromData = [NSKeyedUnarchiver unarchiveObjectWithData: dataFromString];
    //
    // Convert NSData to Base64 data
    //   NSData *base64Data = [dataTake2 base64EncodedDataWithOptions:0];
    //   NSLog(@"%@", [NSString stringWithUTF8String:[base64Data bytes]]);
    //
    // Now convert back from Base64
    //   NSData *nsdataDecoded = [base64Data initWithBase64EncodedData:base64Data options:0];
    //   NSString *str = [[NSString alloc] initWithData:nsdataDecoded encoding:NSUTF8StringEncoding];
    //   NSLog(@"%@", str);
    //
    // Convert NSString <---> c string 
    //   NSString *myNameOstr =  [NSString stringWithUTF8String:psvName];  // convert c string to NSStrin
    //
    //   const char *my_psvc;  // psv=pipe-separated values
    //   char my_psv[1024], psvName[32];
    //   my_psvc = [gbl_fromHomeCurrentSelectionPSV cStringUsingEncoding:NSUTF8StringEncoding]; // convert NSString to c string
    //   strcpy(my_psv, my_psvc);


//tn();trn("TEST GROUP ENCODE HERE :");
//
//       NSLog(@"gbl_arrayGrp=%@",gbl_arrayGrp);  // start here
//
//       myGroupArchive   = [NSKeyedArchiver  archivedDataWithRootObject: gbl_arrayGrp]; // (1) gbl_arrayGrp to myGroupArchive
//tn();  NSLog(@"myGroupArchive=\n%@",myGroupArchive);
//
//       myGroupEncrypted = [myGroupArchive AES256EncryptWithKey: myGroupKeyStr];        // (2) myGroupArchive to myGroupEncrypted
//       printf("myGroupEncrypted=\n%s\n", [[myGroupEncrypted description] UTF8String]);
//
//       myGroupb64Data   = [myGroupEncrypted base64EncodedDataWithOptions: 0];          // (3) myGroupEncrypted to myGroupb64Data
//tn();  NSLog(@"myGroupb64Data=\n%@",myGroupb64Data);
//
//       myGroupb64Muta   = [[NSMutableData alloc] initWithData: myGroupb64Data];        // (4) myGroupb64Data to myGroupb64Muta
//
//       uint8_t *bytes = (uint8_t *)[myGroupb64Muta bytes];                             // (5) myGroupb64Muta to myGroupb64Muta obfuscated
//       uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44};
//       const int patternLengthInBytes = 8;
//       for(int index = 0; index < [myGroupb64Data length]; index++) {
//            bytes[index] ^= pattern[index % patternLengthInBytes];
//       }
//tn();  NSLog(@"myGroupb64MutaOBFUSCATED=\n%@",myGroupb64Muta);
//
//
//
//
//tn();trn("TEST GROUP DECODE HERE :");
//
////       uint8_t *bytes = (uint8_t *)[myGroupb64Muta bytes];                             // (5) myGroupb64Muta obfuscated to myGroupb64Muta 
////       uint8_t pattern[] = {0xe8, 0xf4, 0xa8, 0x32, 0x63, 0xab, 0x7e, 0x44}; // or whatever
////       const int patternLengthInBytes = 8;
////
//       for(int index = 0; index < [myGroupb64Data length]; index++) {
//            bytes[index] ^= pattern[index % patternLengthInBytes];
//       }
//tn();  NSLog(@"myGroupb64Muta=\n%@",myGroupb64Muta);
//
//
//       myGroupEncrypted = [[NSData alloc] initWithBase64EncodedData: myGroupb64Muta    // (3) myGroupb64Muta to myGroupEncrypted 
//                                                            options: 0];  
//tn();  NSLog(@"myGroupEncrypted =\n%@",myGroupEncrypted );
//
//       myGroupArchive = [myGroupEncrypted AES256DecryptWithKey: myGroupKeyStr];        // (2) myGroupEncrypted to myGroupArchive
//       NSLog(@"myGroupArchive=\n%@",myGroupArchive);
//       //printf("myGroupArchiveSTR=\n%s\n", [[myGroupArchive description] UTF8String]);
//
//       myGroupDecoded = [NSKeyedUnarchiver unarchiveObjectWithData: myGroupArchive];   // (1) myGroupDecrypted to MyGroupDecoded (gbl_arrayGrp)
//tn();  NSLog(@"myGroupDecoded=\n%@",myGroupDecoded); // should = gbl_arrayGrp
//
//
//

        // for test
        //         //NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"=|"];
        //         NSCharacterSet *myNSCharacterSet = [NSCharacterSet characterSetWithCharactersInString:@"|"];
        //         _arr = [lastEntityStr componentsSeparatedByCharactersInSet: myNSCharacterSet];
        //          NSLog(@"_arr=%@", _arr);


// orig
//             NSData *myLastEntityData       = [NSKeyedArchiver  archivedDataWithRootObject: myLastEntityStr];             // convert string to nsdata/nskeyedarchiver
//             NSLog(@"myLastEntityData=%@",myLastEntityData);
//             NSLog(@"archiv=%@", [NSString stringWithUTF8String:[myLastEntityData       bytes]]);
//             NSData *myLastEntitybase64Data = [myLastEntityData base64EncodedDataWithOptions: 0];                         // Convert NSData/nskeyedarchiver to base64 
//             NSLog(@"base64=%@", [NSString stringWithUTF8String:[myLastEntitybase64Data bytes]]);
//             NSData *nsdataDecoded = [myLastEntitybase64Data initWithBase64EncodedData:myLastEntitybase64Data options:0]; // convert base64 to nsdata/nskeyedarchiver
//             NSString* str1 = [NSKeyedUnarchiver unarchiveObjectWithData: nsdataDecoded ];                                // convert nsdata/nskeyedarchiver to string
//             NSLog(@"decoded string1=%@", str1);
// 

//  OLD OLD tries at Group WRITE
// data is empty with this
//     dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//         __block BOOL ret01 = [myGroupWriteable writeToURL:gbl_URLToGroup atomically:YES];
//         if (!ret01)  NSLog(@"Error write to mambd2 \n  %@", [err01 localizedFailureReason]);
//     });
//
// data is empty with this
//    // This will ensure that your save operation has a fighting chance to successfully complete,
//    // even if the app is interrupted.
//    //
//    // get background task identifier before you dispatch the save operation to the background
//    UIApplication *application = [UIApplication sharedApplication];
//    UIBackgroundTaskIdentifier __block task = [application beginBackgroundTaskWithExpirationHandler:^{
//        if (task != UIBackgroundTaskInvalid) {
//            [application endBackgroundTask:task];
//            task = UIBackgroundTaskInvalid;
//        }
//    }];
//    // now dispatch the save operation
//    dispatch_async(dispatch_get_main_queue(),  ^{
//        // do the save operation here
//         BOOL ret01 = [myGroupWriteable writeToURL: gbl_URLToGroup atomically:YES];
//         if (!ret01)  NSLog(@"Error write to mambd2 \n  %@", [err01 localizedFailureReason]);
//
//        // now tell the OS that you're done
//        if (task != UIBackgroundTaskInvalid) {
//            [application endBackgroundTask:task];
//            task = UIBackgroundTaskInvalid;
//        }
//     });
//

// OLD OLD  WRITE PERSOn   (empty data)
//     dispatch_async(dispatch_get_main_queue(), ^{                                
//         __block BOOL ret01 = [myPersonWriteable writeToURL:URLToPerson atomically:YES];
//         if (!ret01)  NSLog(@"Error write to mambd3 \n  %@", [err01 localizedFailureReason]);
//     });
//
//
//    // This will ensure that your save operation has a fighting chance to successfully complete,
//    // even if the app is interrupted.
//    //
//    // get background task identifier before you dispatch the save operation to the background
//    UIApplication *application = [UIApplication sharedApplication];
//    UIBackgroundTaskIdentifier __block task = [application beginBackgroundTaskWithExpirationHandler:^{
//        if (task != UIBackgroundTaskInvalid) {
//            [application endBackgroundTask:task];
//            task = UIBackgroundTaskInvalid;
//        }
//    }];
//    // now dispatch the save operation
//    dispatch_async(dispatch_get_main_queue(),  ^{
//
//        // do the save operation here
//         BOOL ret01 = [myPersonWriteable writeToURL: gbl_URLToPerson atomically:YES];
//         if (!ret01)  NSLog(@"Error write to mambd3 \n  %@", [err01 localizedFailureReason]);
//
//        // now tell the OS that you're done
//        if (task != UIBackgroundTaskInvalid) {
//            [application endBackgroundTask:task];
//            task = UIBackgroundTaskInvalid;
//        }
//     });
//


//       dispatch_async(dispatch_get_main_queue(), ^{                                // <===  
//          [myLastEntityDataFil writeToURL:URLToLastEntity
//                               atomically:YES ];
//       });
//

//
//    // lastGood are backups if reg files are somehow bad
//    gbl_pathToGroupLastGood  = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambGroupLastGood.txt"];
//    gbl_pathToPersonLastGood = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambPersonLastGood.txt"];
//    gbl_pathToMemberLastGood = [gbl_appDocDirStr stringByAppendingPathComponent: @"mambMemberLastGood.txt"];
//    gbl_URLToGroupLastGood   = [NSURL fileURLWithPath: gbl_pathToGroupLastGood isDirectory:NO];
//    gbl_URLToPersonLastGood  = [NSURL fileURLWithPath: gbl_pathToPersonLastGood isDirectory:NO];
//    gbl_URLToMemberLastGood  = [NSURL fileURLWithPath: gbl_pathToMemberLastGood isDirectory:NO];
//

// used to be at top
//    NSInteger cnt1;  // do a *.count on these arrays to avoid unused variable warning
//    // This is the initial example data in DB when app first starts.
//    // This is NOT the ongoing data, which is in  data files.
//    //
//    //NSArray *arrayMAMBexampleGroup =   // field 1=name-of-group  field 2=locked-or-not
//    NSArray *gbl_arrayExaGrp =   // field 1=name-of-group  field 2=locked-or-not
//    @[
//      @"~Swim Team||",
//      @"~My Family||",
//    ];
//    cnt1 = gbl_arrayExaGrp.count;
//    NSLog(@"cnt1=%ld",(long)cnt1);
//
//
//    //NSArray *arrayMAMBexamplePerson = // field 11= locked or not
//    NSArray *gbl_arrayExaPer = // field 11= locked or not
//    @[
//      @"~Father|7|11|1961|11|8|1|Los Angeles|California|United States||",
//      @"~Mother|3|12|1965|10|45|0|Los Angeles|California|United States||",
//      @"~Sister1|2|31|1988|0|30|1|Los Angeles|California|United States||",
//      @"~Sister2|2|13|1990|3|35|0|Los Angeles|California|United States||",
//      @"~Brother|11|6|1986|8|1|1|Los Angeles|California|United States||",
//      @"~Grandma|8|17|1939|8|5|0|Los Angeles|California|United States||",
//      @"~Mike|4|20|1992|6|30|1|Los Angeles|California|United States||",
//      @"~Anya 789012345|10|19|1990|8|20|0|Los Angeles|California|United States||",
//      @"~Billy 89012345|8|4|1991|10|30|1|Los Angeles|California|United States||",
//      @"~Emma|5|17|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Jacob|10|10|1992|0|1|1|Los Angeles|California|United States||",
//      @"~Grace|8|21|1994|1|20|0|Los Angeles|California|United States||",
//      @"~Ingrid|3|13|1993|4|10|1|Los Angeles|California|United States||",
//      @"~Jen|6|22|1992|4|10|0|Los Angeles|California|United States||",
//      @"~Liz|3|13|1991|4|10|1|Los Angeles|California|United States||",
//      @"~Jim|2|3|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Olivia|4|13|1994|0|53|1|Los Angeles|California|United States||",
//      @"~Dave|4|8|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Noah|12|19|1994|11|4|0|Los Angeles|California|United States||",
//      @"~Sophia|9|20|1991|4|0|0|Los Angeles|California|United States||",
//      @"~Susie|2|3|1992|8|10|0|Los Angeles|California|United States||",
//    ];
//    cnt1 = gbl_arrayExaPer.count;
//
//    //NSArray *arrayMAMBexampleMember =
//    NSArray *gbl_arrayExaMem = // field 11= locked or not
//    @[
//      @"~My Family|~Brother|",
//      @"~My Family|~Father|",
//      @"~My Family|~Grandma|",
//      @"~My Family|~Mother|",
//      @"~My Family|~Sister1|",
//      @"~My Family|~Sister2|",
//      @"~Swim Team|~Anya|",
//      @"~Swim Team|~Billy 89012345|",
//      @"~Swim Team|~Dave|",
//      @"~Swim Team|~Emma|",
//      @"~Swim Team|~Grace|",
//      @"~Swim Team|~Ingrid|",
//      @"~Swim Team|~Jacob|",
//      @"~Swim Team|~Jen|",
//      @"~Swim Team|~Jim|",
//      @"~Swim Team|~Liz|",
//      @"~Swim Team|~Mike|",
//      @"~Swim Team|~Noah|",
//      @"~Swim Team|~Olivia|",
//      @"~Swim Team|~Sophie|",
//      @"~Swim Team|~Susie|",
//    ];
//    cnt1 = gbl_arrayExaMem.count;
//
//    // REMEMBER DATA for each Group 
//    //     field 1  name-of-group
//    //     field 2  last report selected for this Group:
//    //              ="m"  for   "Best Match"
//    //              ="a"  for   "Most Assertive Person"
//    //              ="e"  for   "Most Emotional"
//    //              ="r"  for   "Most Restless"
//    //              ="p"  for   "Most Passionate"
//    //              ="d"  for   "Most Down-to-earth"
//    //              ="u"  for   "Most Ups and Downs"
//    //              ="y"  for   "Best Year ..."
//    //              ="d"  for   "Best Day ..."
//    //     field  3  last year  last selection for this report parameter for this Group
//    //     field  4  day        last selection for this report parameter for this Group
//    //     + extra "|" at end
//    // 
//    //NSArray *arrayMAMBexampleGroupRemember = 
//    NSArray *gbl_arrayExaGrpRem = 
//    @[
//      @"~Family||||",
//      @"~My Family||||",
//    ];
//    cnt1 = gbl_arrayExaGrpRem.count;
//
//    // REMEMBER DATA for each Person
//    //     field 1  name-of-person
//    //     field 2  last report selected for this Person:
//    //              ="m"  for   "Best Match"
//    //              ="y"  for   "Calendar Year ...",
//    //              ="p"  for   "Personality",
//    //              ="c"  for   "Compatibility Paired with ...",
//    //              ="g"  for   "My Best Match in Group ...",
//    //              ="d"  for   "How was your Day? ...",
//    //     field 3  last year
//    //     field 4  person
//    //     field 5  group
//    //     field 6  day
//    //              extra "|" at end
//    //
//    //NSArray *arrayMAMBexamplePersonRemember = 
//    NSArray *gbl_arrayExaPerRem = 
//    @[
//      @"~Father||||||",
//      @"~Mother||||||",
//      @"~Sister1||||||",
//      @"~Sister2||||||",
//      @"~Brother||||||",
//      @"~Grandma||||||",
//      @"~Mike||||||",
//      @"~Anya 789012345||||||",
//      @"~Billy 89012345||||||",
//      @"~Emma||||||",
//      @"~Jacob||||||",
//      @"~Grace||||||",
//      @"~Ingrid||||||",
//      @"~Jen||||||",
//      @"~Liz||||||",
//      @"~Jim||||||",
//      @"~Olivia||||||",
//      @"~Dave||||||",
//      @"~Noah||||||",
//      @"~Sophia||||||",
//      @"~Susie||||||",
//    ];
//    cnt1 = gbl_arrayExaPerRem.count;
//

    //    for (id s in arrayMAMBexampleGroup)       {NSLog(@"eltG: %@",s);}
    //    for (id s in arrayMAMBexampleperson)      {NSLog(@"eltP: %@",s);}
    //    for (id s in arrayMAMBexampleMember)      {NSLog(@"eltGM: %@",s);}
    //
    
// OLD  read/write
//- (void) mambWriteGroupArray: (NSArray *) argGroupArray
//{
//    NSLog(@"in mambWriteGroupArray () ----------");
//    NSError *err01;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//
//    NSData *myGroupArchive;
//    NSData *myGroupWriteable;
//
//    [gbl_sharedFM removeItemAtURL:gbl_URLToGroup // remove old (because no overcopy), write out new Group file with current entity
//                           error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Group %@", err01); }
//
////     NSLog(@"argGroupArray=%@",argGroupArray);
//
//     myGroupArchive   = [NSKeyedArchiver  archivedDataWithRootObject: argGroupArray];
////tn();  NSLog(@"myGroupArchive=\n%@",myGroupArchive);
//
//     myGroupWriteable = [myappDelegate mambKriptOnThisNSData: (NSData *) myGroupArchive];
////tn();  NSLog(@"myGroupWriteable=\n%@",myGroupWriteable );
//     
//
//     BOOL ret01 = [myGroupWriteable writeToURL: gbl_URLToGroup atomically:YES];
//     if (!ret01)  NSLog(@"Error write to mambd2 \n  %@", [err01 localizedFailureReason]);
//
////     NSLog(@"gbl_arrayGrp after =%@",gbl_arrayGrp);  // start here
//} // end of mambWriteGroupArray 
//
//
//- (void) mambWritePersonArray: (NSArray *) argPersonArray
//{
//    NSLog(@"in mambWritePersonArray () ----------");
//    NSError *err01;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global method in appDelegate.m
//
//    NSData *myPersonArchive;
//    NSData *myPersonWriteable;
//
//    [gbl_sharedFM removeItemAtURL:gbl_URLToPerson // remove old (because no overcopy), write out new Person file with current entity
//                            error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Person %@", err01); }
//
////    NSLog(@"argPersonArray=%@",argPersonArray);
//
//    myPersonArchive   = [NSKeyedArchiver  archivedDataWithRootObject: argPersonArray];
////tn();  NSLog(@"myPersonArchive=\n%@",myPersonArchive);
//
//    myPersonWriteable = [myappDelegate mambKriptOnThisNSData: (NSData *) myPersonArchive];
////tn();  NSLog(@"myPersonWriteable=\n%@",myPersonWriteable );
//     
//
//     BOOL ret01 = [myPersonWriteable writeToURL: gbl_URLToPerson atomically:YES];
//     if (!ret01)  NSLog(@"Error write to mambd3 \n  %@", [err01 localizedFailureReason]);
//
////     NSLog(@"gbl_arrayPer after personwrite=%@",gbl_arrayPer);  // start here
//} // end of mambWritePersonArray 
//
//
//- (void) mambWriteMemberArray: (NSArray *) argMemberArray
//{
//    NSLog(@"in mambWriteMemberArray () ----------");
//    NSError *err01;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global method in appDelegate.m
//
//    NSData *myMemberArchive;
//    NSData *myMemberWriteable;
//
//    [gbl_sharedFM removeItemAtURL:gbl_URLToMember // remove old (because no overcopy), write out new Member file with current entity
//                            error:&err01];
//    if (err01 && (long)[err01 code] != NSFileNoSuchFileError) { NSLog(@"Member %@", err01); }
//
//    NSLog(@"argMemberArray=%@",argMemberArray);
//
//    myMemberArchive   = [NSKeyedArchiver  archivedDataWithRootObject: argMemberArray];
//tn();  NSLog(@"myMemberArchive=\n%@",myMemberArchive);
//
//    myMemberWriteable = [myappDelegate mambKriptOnThisNSData: (NSData *) myMemberArchive];
//tn();  NSLog(@"myMemberWriteable=\n%@",myMemberWriteable );
//     
//
//     BOOL ret01 = [myMemberWriteable writeToURL: gbl_URLToMember atomically:YES];
//     if (!ret01)  NSLog(@"Error write to mambd3 \n  %@", [err01 localizedFailureReason]);
//
//     NSLog(@"gbl_arrayPer after Memberwrite=%@",gbl_arrayPer);  // start here
//} // end of mambWriteMemberArray 
//
// end of OLD  read/write

// old from read file   mambReadArrayFileWithDescription
//    if ([entDesc isEqualToString:@"group"])        { myURLtoReadFrom = gbl_URLToGroup;    my_gbl_array = gbl_arrayGrp;    }
//    if ([entDesc isEqualToString:@"person"])       { myURLtoReadFrom = gbl_URLToPerson;   my_gbl_array = gbl_arrayPer;    }
//    if ([entDesc isEqualToString:@"member"])       { myURLtoReadFrom = gbl_URLToMember;   my_gbl_array = gbl_arrayMem;    }
//    if ([entDesc isEqualToString:@"grpexample"])   { myURLtoReadFrom = gbl_URLToGroup;    my_gbl_array = gbl_arrayGrpExa; }
//    if ([entDesc isEqualToString:@"perexample"])   { myURLtoReadFrom = gbl_URLToPerson;   my_gbl_array = gbl_arrayPerExa; }
//    if ([entDesc isEqualToString:@"memexample"])   { myURLtoReadFrom = gbl_URLToMember;   my_gbl_array = gbl_arrayMemExa; }
//    if ([entDesc isEqualToString:@"grpremember"])  { myURLtoReadFrom = gbl_URLToGrpRem;   my_gbl_array = gbl_arrayGrpRem; }
//    if ([entDesc isEqualToString:@"perremember"])  { myURLtoReadFrom = gbl_URLToPerRem;   my_gbl_array = gbl_arrayPerRem; }
//
//NSMutableArray *myMutArr = (NSMutableArray *) myNSData;
//    NSLog(@"myMutArr =%@",myMutArr );
//
//NSArray *myArr = (NSArray *) myNSData;
//    NSLog(@"myArr =%@",myArr );
//

    //myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myNSData]; 
    //myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myMutArr]; 
//    myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: myArr]; 
    //myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: (NSMutableData *) myNSData]; 
//    myUnarchived = [NSKeyedUnarchiver unarchiveObjectWithData: (NSMutableArray *) myNSData]; 
//
//    if ([entDesc isEqualToString:@"examplegroup"])  { gbl_arrayExaGrp    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//    if ([entDesc isEqualToString:@"exampleperson"]) { gbl_arrayExaPer    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//    if ([entDesc isEqualToString:@"examplemember"]) { gbl_arrayExaMem    = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//    if ([entDesc isEqualToString:@"examplegrprem"]) { gbl_arrayExaGrpRem = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//    if ([entDesc isEqualToString:@"exampleperrem"]) { gbl_arrayExaPerRem = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myUnarchived]; }
//

// OLD   read fns
//- (void) mambReadGroupFile
//{
//    NSLog(@"in mambReadGroupFile() ----------");
//    
//    NSData *myGroupWritten;
//    NSData *myGroupNSData;
//    NSData *myGroupArray;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global method in appDelegate.m
//
//    myGroupWritten = [[NSData alloc] initWithContentsOfURL: gbl_URLToGroup];
//    if (myGroupWritten == nil) { NSLog(@"%@", @"Error reading mambd2"); }
////tn();  NSLog(@"myGroupWritten=\n%@",myGroupWritten);
//
//    myGroupNSData = [myappDelegate mambKriptOffThisNSData: (NSData *) myGroupWritten];
////tn();  NSLog(@"myGroupNSData=\n%@",myGroupNSData);
//
//    myGroupArray = [NSKeyedUnarchiver unarchiveObjectWithData: myGroupNSData]; 
////tn();  NSLog(@"myGroupArray=\n%@",myGroupArray );
//
//    gbl_arrayGrp =  [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myGroupArray];
////tn();  NSLog(@"gbl_arrayGrp=\n%@", gbl_arrayGrp);
//} // end of mambReadGroupFile()
//
//
//- (void) mambReadPersonFile
//{
//    NSLog(@"in mambReadPersonFile() ----------");
//    
//    NSData *myPersonWritten;
//    NSData *myPersonNSData;
//    NSMutableData *myPersonArray;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//
//    myPersonWritten = [[NSData alloc] initWithContentsOfURL: gbl_URLToPerson];
//    if (myPersonWritten == nil) { NSLog(@"%@", @"Error reading mambd3"); }
////tn();  NSLog(@"myPersonWritten=\n%@", myPersonWritten);
//
//    myPersonNSData = [myappDelegate mambKriptOffThisNSData: (NSData *) myPersonWritten];
////tn();  NSLog(@"myPersonNSData=\n%@", myPersonNSData);
//
//    myPersonArray  = [NSKeyedUnarchiver unarchiveObjectWithData: myPersonNSData]; 
////tn();  NSLog(@"myPersonArray=\n%@", myPersonArray );
//
//    gbl_arrayPer   = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myPersonArray];
////tn();  NSLog(@"gbl_arrayPer=\n%@", gbl_arrayPer);
//} // end of mambReadPersonFile()
//
//
//- (void) mambReadMemberFile
//{
//    NSLog(@"in mambReadMemberFile() ----------");
//    
//    NSData *myMemberWritten;
//    NSData *myMemberNSData;
//    NSMutableData *myMemberArray;
//
//    MAMB09AppDelegate *myappDelegate = (MAMB09AppDelegate *)[[UIApplication sharedApplication] delegate]; // for global methods in appDelegate.m
//
//    myMemberWritten = [[NSData alloc] initWithContentsOfURL: gbl_URLToMember];
//    if (myMemberWritten == nil) { NSLog(@"%@", @"Error reading mambd3"); }
////tn();  NSLog(@"myMemberWritten=\n%@", myMemberWritten);
//
//    myMemberNSData = [myappDelegate mambKriptOffThisNSData: (NSData *) myMemberWritten];
////tn();  NSLog(@"myMemberNSData=\n%@", myMemberNSData);
//
//    myMemberArray  = [NSKeyedUnarchiver unarchiveObjectWithData: myMemberNSData]; 
////tn();  NSLog(@"myMemberArray=\n%@", myMemberArray );
//
//    gbl_arrayMem   = [[NSMutableArray alloc]initWithArray: (NSMutableArray*) myMemberArray];
////tn();  NSLog(@"gbl_arrayMem=\n%@", gbl_arrayMem);
//} // end of mambReadMemberFile()
//
// end of OLD   read fns


// from    - (void)applicationDidBecomeActive:(UIApplication *)application
// used  applicationDidBecomeActive  notification instead
//     // http://stackoverflow.com/questions/15864364/viewdidappear-is-not-called-when-opening-app-from-background
//     //
//     // I think registering for the UIApplicationWillEnterForegroundNotification is risky
//     // as you may end up with more than one controller reacting to that notification.
//     // Nothing garanties that these controllers are still visible when the notification is received.
//     // 
//     // Here is what I do: I force call viewDidAppear on the active controller directly from the App's delegate didBecomeActive method:
//     // 
//     // Add the code below to - (void)applicationDidBecomeActive:(UIApplication *)application
//     // 
//     UIViewController *activeController = window.rootViewController;
//     if ([activeController isKindOfClass:[UINavigationController class]]) {
//         activeController = [(UINavigationController*)window.rootViewController topViewController];
//     }
//     //[activeController viewDidAppear:NO];
//     [activeController viewDidAppear:NO];
//

// never used
//#pragma mark -
//#pragma mark NSCoding Methods
//
//// - (void)encodeWithCoder:(NSCoder *)aCoder  // ENCODE
//// {
//// NSLog(@"in encodeWithCoder() ENCODE");
//// tn();trn("in encodeWithCoder() ENCODE");
////     NSLog(@"KEY_LAST_ENTITY_STR=%@",KEY_LAST_ENTITY_STR);
////     [aCoder encodeObject: self.myLastEntityStr
////                   forKey: KEY_LAST_ENTITY_STR  ];
//// }
//// 
//// - (id)initWithCoder:(NSCoder *)aDecoder    // DECODE         // NS_DESIGNATED_INITIALIZER
//// {
//// NSLog(@"in initWithCoder() DECODE");
//// tn();trn("in initWithCoder() DECODE");
////     self = [super init];
//// nb(1);
////     if (self) {
//// nb(2);
////         self.myLastEntityStr = [aDecoder decodeObjectForKey: KEY_LAST_ENTITY_STR];
////     } 
//// nb(3);
////     return self;
//// }
//
//#pragma mark -
//

//
//    // This is the initial example data in DB when app first starts.
//    // This is NOT the ongoing data, which is in  data files.
//    //
//    //NSArray *arrayMAMBexampleGroup =   // field 1=name-of-group  field 2=locked-or-not
//    NSArray *arrayExaGrp =   // field 1=name-of-group  field 2=locked-or-not
//    @[
//      @"~Swim Team||",
//      @"~My Family||",
//    ];
//
//    //NSArray *arrayMAMBexamplePerson = // field 11= locked or not
//    NSArray *arrayExaPer = // field 11= locked or not
//    @[
//      @"~Father|7|11|1961|11|8|1|Los Angeles|California|United States||",
//      @"~Mother|3|12|1965|10|45|0|Los Angeles|California|United States||",
//      @"~Sister1|2|31|1988|0|30|1|Los Angeles|California|United States||",
//      @"~Sister2|2|13|1990|3|35|0|Los Angeles|California|United States||",
//      @"~Brother|11|6|1986|8|1|1|Los Angeles|California|United States||",
//      @"~Grandma|8|17|1939|8|5|0|Los Angeles|California|United States||",
//      @"~Mike|4|20|1992|6|30|1|Los Angeles|California|United States||",
//      @"~Anya 789012345|10|19|1990|8|20|0|Los Angeles|California|United States||",
//      @"~Billy 89012345|8|4|1991|10|30|1|Los Angeles|California|United States||",
//      @"~Emma|5|17|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Jacob|10|10|1992|0|1|1|Los Angeles|California|United States||",
//      @"~Grace|8|21|1994|1|20|0|Los Angeles|California|United States||",
//      @"~Ingrid|3|13|1993|4|10|1|Los Angeles|California|United States||",
//      @"~Jen|6|22|1992|4|10|0|Los Angeles|California|United States||",
//      @"~Liz|3|13|1991|4|10|1|Los Angeles|California|United States||",
//      @"~Jim|2|3|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Olivia|4|13|1994|0|53|1|Los Angeles|California|United States||",
//      @"~Dave|4|8|1993|0|1|1|Los Angeles|California|United States||",
//      @"~Noah|12|19|1994|11|4|0|Los Angeles|California|United States||",
//      @"~Sophia|9|20|1991|4|0|0|Los Angeles|California|United States||",
//      @"~Susie|2|3|1992|8|10|0|Los Angeles|California|United States||",
//    ];
//
//    //NSArray *arrayMAMBexampleMember =
//    NSArray *arrayExaMem = // field 11= locked or not
//    @[
//      @"~My Family|~Brother|",
//      @"~My Family|~Father|",
//      @"~My Family|~Grandma|",
//      @"~My Family|~Mother|",
//      @"~My Family|~Sister1|",
//      @"~My Family|~Sister2|",
//      @"~Swim Team|~Anya|",
//      @"~Swim Team|~Billy 89012345|",
//      @"~Swim Team|~Dave|",
//      @"~Swim Team|~Emma|",
//      @"~Swim Team|~Grace|",
//      @"~Swim Team|~Ingrid|",
//      @"~Swim Team|~Jacob|",
//      @"~Swim Team|~Jen|",
//      @"~Swim Team|~Jim|",
//      @"~Swim Team|~Liz|",
//      @"~Swim Team|~Mike|",
//      @"~Swim Team|~Noah|",
//      @"~Swim Team|~Olivia|",
//      @"~Swim Team|~Sophie|",
//      @"~Swim Team|~Susie|",
//    ];
//
//    // REMEMBER DATA for each Group 
//    //     field 1  name-of-group
//    //     field 2  last report selected for this Group:
//    //              ="gbm"  for   "Best Match"
//    //              ="gma"  for   "Most Assertive Person"
//    //              ="gme"  for   "Most Emotional"
//    //              ="gmr"  for   "Most Restless"
//    //              ="gmp"  for   "Most Passionate"
//    //              ="gmd"  for   "Most Down-to-earth"
//    //              ="gmu"  for   "Most Ups and Downs"
//    //              ="gby"  for   "Best Year ..."
//    //              ="gbd"  for   "Best Day ..."
//    //     field  3  last year  last selection for this report parameter for this Group
//    //     field  4  day        last selection for this report parameter for this Group
//    //     + extra "|" at end
//    // 
//    //NSArray *arrayMAMBexampleGroupRemember = 
//    NSArray *arrayExaGrpRem = 
//    @[
//      @"~Family||||",
//      @"~My Family||||",
//    ];
//
//    // REMEMBER DATA for each Person
//    //     field 1  name-of-person
//    //     field 2  last report selected for this Person:
//    //              ="pbm"  for   "Best Match"
//    //              ="pcy"  for   "Calendar Year ...",
//    //              ="ppe"  for   "Personality",
//    //              ="pco"  for   "Compatibility Paired with ...",
//    //              ="pbg"  for   "My Best Match in Group ...",
//    //              ="pwc"  for   "What color is today? ...",
//    //     field 3  last year
//    //     field 4  person
//    //     field 5  group
//    //     field 6  day
//    //              extra "|" at end
//    //
//    //NSArray *arrayMAMBexamplePersonRemember = 
//    NSArray *arrayExaPerRem = 
//    @[
//      @"~Father||||||",
//      @"~Mother||||||",
//      @"~Sister1||||||",
//      @"~Sister2||||||",
//      @"~Brother||||||",
//      @"~Grandma||||||",
//      @"~Mike||||||",
//      @"~Anya 789012345||||||",
//      @"~Billy 89012345||||||",
//      @"~Emma||||||",
//      @"~Jacob||||||",
//      @"~Grace||||||",
//      @"~Ingrid||||||",
//      @"~Jen||||||",
//      @"~Liz||||||",
//      @"~Jim||||||",
//      @"~Olivia||||||",
//      @"~Dave||||||",
//      @"~Noah||||||",
//      @"~Sophia||||||",
//      @"~Susie||||||",
//    ];
//
//

