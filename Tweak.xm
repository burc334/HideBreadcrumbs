#import <Foundation/Foundation.h>
#import <objc/runtime.h>

// The system's own "SBNeverBreadcrumb" switch is implemented by
// SBWorkspaceDefaults.breadcrumbDisabled, which this method checks before
// creating the status-bar breadcrumb context. Returning NO here is the same
// decision the system makes when breadcrumbs are disabled.
%hook SBDeviceApplicationSceneStatusBarBreadcrumbProvider
+ (_Bool)_shouldAddBreadcrumbToActivatingSceneEntity:(id)entity
                                          sceneHandle:(id)handle
                                withTransitionContext:(id)context {
    (void)entity;
    (void)handle;
    (void)context;
    return NO;
}
%end

%ctor {
    if (objc_getClass("SBDeviceApplicationSceneStatusBarBreadcrumbProvider")) {
        %init;
    }
}
