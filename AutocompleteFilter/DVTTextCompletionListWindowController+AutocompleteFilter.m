#import "DVTTextCompletionListWindowController+AutocompleteFilter.h"

#import <objc/runtime.h>
#import <QuartzCore/QuartzCore.h>

#import "JRSwizzle.h"
#import "DVTTextCompletionSession.h"
#import "IDESourceKitCompletionItem.h"
#import "DVTSourceCodeSymbolKind.h"

@implementation DVTTextCompletionListWindowController (AutocompleteFilter)

+ (void) fa_swizzleMethods {
    [self jr_swizzleMethod: @selector(windowDidLoad)
                withMethod: @selector(_fa_windowDidLoad)
                     error: NULL];
}

- (void)_fa_windowDidLoad {
    [self _fa_windowDidLoad];
    id token = [NSEvent addLocalMonitorForEventsMatchingMask:NSEventMaskFlagsChanged
                                                     handler:^NSEvent * _Nullable(NSEvent *e) {
                                                         [self _fa_filterCompletionsBasedOnModifierFlags:e.modifierFlags];
                                                         objc_setAssociatedObject(self, (void*)1, @(e.modifierFlags), OBJC_ASSOCIATION_ASSIGN);
                                                         return e;
                                                     }];
    
    objc_setAssociatedObject(self, 0, token, OBJC_ASSOCIATION_RETAIN);
}

- (void)_fa_filterCompletionsToSymbolKind:(DVTSourceCodeSymbolKind *)filterKind {
    NSTableView *table = [self valueForKey:@"_completionsTableView"];
    NSMutableArray *filteredArray = self.session.filteredCompletionsAlpha.mutableCopy;

    for (NSInteger i = (NSInteger)filteredArray.count - 1; i >= 0; i--) {
        id item = filteredArray[(NSUInteger)i];
        if (![item isKindOfClass:[IDESourceKitCompletionItem class]]) {
            continue;
        }

        DVTSourceCodeSymbolKind *itemKind = ((IDESourceKitCompletionItem *) item).symbolKind;
        if (itemKind != filterKind) {
            [filteredArray removeObjectAtIndex:i];
        }
    }

    if (filteredArray.count) {
        self.session.filteredCompletionsAlpha = filteredArray;
        [table reloadData];
    } else {
        [self dismissController:nil];
    }
}

- (void)_fa_filterCompletionsBasedOnModifierFlags:(NSEventModifierFlags)flags {
    if ([self _fa_wasModifierJustPressed:NSEventModifierFlagOption in:flags]) {
        [self _fa_filterCompletionsToSymbolKind:[DVTSourceCodeSymbolKind enumConstantSymbolKind]];
        return;
    }

    if ([self _fa_wasModifierJustPressed:NSEventModifierFlagCommand in:flags]) {
        [self _fa_filterCompletionsToSymbolKind:[DVTSourceCodeSymbolKind typedefSymbolKind]];
        return;
    }
}

- (BOOL)_fa_wasModifierJustPressed:(NSEventModifierFlags)flag in:(NSEventModifierFlags)flags {
    NSEventModifierFlags previousFlags = [objc_getAssociatedObject(self, (void*)1) unsignedIntegerValue];
    return flags & flag && !(previousFlags & flag);
}

@end
