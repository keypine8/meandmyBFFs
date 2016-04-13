//
//  MAMB09_UITextField_noCopyPaste.m
//  Me&myBFFs
//
//  Created by Richard Koskela on 2016-04-10.
//  Copyright © 2016 Richard Koskela. All rights reserved.
//

#import "MAMB09_UITextField_noCopyPaste.h"
#import "mamblib.h"

@implementation MAMB09_UITextField_noCopyPaste

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (BOOL)canPerformAction: (SEL)action
              withSender: (id)sender
{
//  NSLog(@"canPerformAction ! in MAMB09_UITextField_noCopyPaste.m");
  NSLog(@"canPerformAction !  action=[%@]", NSStringFromSelector(action) );
//  NSLog(@"action =[%@]",(SEL _Nonnull) action);
//  NSLog(@"action =[%@]",(id) action);


//    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
////        [[UIMenuController sharedMenuController] setMenuVisible:NO animated:NO];
//        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
//    }];
//    return [super canPerformAction:action withSender:sender];
//

    if (   action == @selector(copy:) ) return YES;

//
//    if (   action == @selector(paste:    )
//        || action == @selector(cut:      )
//        || action == @selector(copy:     )
//        || action == @selector(select:   )
//        || action == @selector(selectAll:)
//        || action == @selector(delete:   )
////        action == @selector(promptForReplace:) ||
////        action == @selector(makeTextWritingDirectionLeftToRight:  ) ||
////        action == @selector(makeTextWritingDirectionRightToLeft:  ) ||
////        action == @selector(toggleBoldface:                       ) ||
////        action == @selector(toggleItalics:                        ) ||
////        action == @selector(toggleUnderline:                      )
////        action == @selector(_promptForReplace:)   ||
////        action == @selector(_transliterateChinese:)   ||
////        action == @selector(_showTextStyleOptions:)   ||
////        action == @selector(_addShortcut:)   ||
////        action == @selector(_accessibilitySpeak:)   ||
////        action == @selector(_accessibilitySpeakLanguageSelection:)   ||
////        action == @selector(_accessibilityPauseSpeaking:)   ||
//
//        ) {
//  NSLog(@"return  NO !");
////tn();        
//        return NO;
//    }
//
//  NSLog(@"return YES !");
////tn();        
//        return YES;
//

  NSLog(@"return [super canPerformAction:action withSender:sender]; ");
tn();        
    return [super canPerformAction:action withSender:sender];



} // end of canPerformAction  in MAMB09_UITextField_noCopyPaste.m


@end
