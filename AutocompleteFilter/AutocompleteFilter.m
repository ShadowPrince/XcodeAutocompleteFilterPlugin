#import "AutocompleteFilter.h"

#import <objc/runtime.h>
#import "DVTTextCompletionListWindowController+AutocompleteFilter.h"
#import "DVTTextCompletionSession+AutocompleteFilter.h"

@implementation AutocompleteFilter

+ (void)pluginDidLoad:(NSBundle *)plugin {
    NSString *currentApplicationName = [NSBundle mainBundle].lsl_bundleName;
    
    static dispatch_once_t onceToken;
    if ([currentApplicationName isEqual:@"Xcode"]) {
        dispatch_once(&onceToken, ^{
            [[NSNotificationCenter defaultCenter] addObserver: self
                                                     selector: @selector(applicationDidFinishLaunching:)
                                                         name: NSApplicationDidFinishLaunchingNotification
                                                       object: nil];
        });
    }
}

+ (void) applicationDidFinishLaunching: (NSNotification *) notification {
    [[NSNotificationCenter defaultCenter] removeObserver: self name: NSApplicationDidFinishLaunchingNotification object: nil];
    [self swizzleMethods];
}

+ (void) swizzleMethods {
    [DVTTextCompletionListWindowController fa_swizzleMethods];
    [DVTTextCompletionSession fa_swizzleMethods];
}

@end
