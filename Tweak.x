#import <UIKit/UIKit.h>

@interface UIActivityContentViewController
- (void) updateContentWithPeopleProxies:(id)arg1 shareProxies:(id)arg2 actionProxies:(id)arg3 activitiesByUUID:(id)arg4 nearbyCountSlotID:(id)arg5 animated:(BOOL)arg6;
@end

@interface _UIActivityUserDefaultsViewController
@property NSArray * favoritesProxies;
@property NSArray * suggestionProxies;
- (void) setFavoritesProxies:(NSArray*)arg1;
- (void) setSuggestionProxies:(NSArray*)arg1;
- (void) makeEditable:(NSArray*)arg1;
@end

@interface UserAP
@property BOOL canEdit;
@property BOOL canMove;
@end


%hook UIActivityContentViewController
- (void) updateContentWithPeopleProxies:(NSArray*)arg1 shareProxies:(NSArray*)arg2 actionProxies:(NSArray*)arg3 activitiesByUUID:(NSMutableDictionary*)arg4 nearbyCountSlotID:(id)arg5 animated:(BOOL)arg6 {
	%orig([NSMutableArray new], arg2, arg3, arg4, arg5, arg6);
}
- (void) updateContentWithPeopleProxies:(NSArray*)arg1 shareProxies:(NSArray*)arg2 actionProxies:(NSArray*)arg3 activitiesByUUID:(NSMutableDictionary*)arg4 nearbyCountSlotID:(id)arg5 animated:(BOOL)arg6 reloadData:(BOOL)arg7 {
	%orig([NSMutableArray new], arg2, arg3, arg4, arg5, arg6, arg7);
}
%end

%hook _UIActivityUserDefaultsViewController
- (void) setFavoritesProxies:(NSArray*)arg1 {
	%orig;
	[self makeEditable:self.favoritesProxies];
}

- (void) setSuggestionProxies:(NSArray*)arg1 {
	%orig;
	[self makeEditable:self.suggestionProxies];
}

%new
- (void) makeEditable:(NSArray*)arg1 {
	for (UserAP * ap in arg1) {
		ap.canEdit = YES;
		ap.canMove = YES;
	}
}

%end