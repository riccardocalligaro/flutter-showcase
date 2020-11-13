#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "AdharaSocketIoPlugin.h"

FOUNDATION_EXPORT double adhara_socket_ioVersionNumber;
FOUNDATION_EXPORT const unsigned char adhara_socket_ioVersionString[];

