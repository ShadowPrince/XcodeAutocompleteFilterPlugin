#import "DVTTextCompletionSession+AutocompleteFilter.h"
#import "JRSwizzle.h"

@implementation DVTTextCompletionSession (AutocompleteFilter)

+ (void) fa_swizzleMethods {
    [self jr_swizzleMethod:@selector(setAllCompletions:) withMethod:@selector(_fa_setaAllCompletions:) error:nil];
}
- (void)_fa_setaAllCompletions:(NSArray *)all {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF.description BEGINSWITH %@)", @"accessibility"];
    [self _fa_setaAllCompletions:[all filteredArrayUsingPredicate:predicate]];
}

@end
