//  weibo: http://weibo.com/xiaoqing28
//  blog:  http://www.alonemonkey.com
//
//  LJWhatsAppPod.m
//  LJWhatsAppPod
//
//  Created by ray on 2018/7/21.
//  Copyright (c) 2018年 rj. All rights reserved.
//

#import "LJWhatsAppPod.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>

CHDeclareClass(WAChatViewController)

CHOptimizedMethod1(self, void, WAChatViewController, transactionDidProcessMessages, NSNotification*, notify) {
    CHSuper1(WAChatViewController, transactionDidProcessMessages, notify);

    NSArray *msgs = notify.userInfo[@"added"];
    if (msgs.firstObject) {
        WAMessage *msg = (WAMessage *)msgs.firstObject;
        if (!msg.isFromMe) {
            NSString *text = [NSString stringWithFormat:@"you send: %@", msg.text];

            [self chatMessageInputView:self.chatMessageInputView userDidSubmitText:text metadata:nil completion:^(BOOL result) {
                if (result) {
                    [self.chatMessageInputView didSendMessage];
                    WAWebPageFromTextLoader *loader = CHIvar(self.chatMessageInputView, _webPageLoader, __strong WAWebPageFromTextLoader*);
                    loader.text = nil;
                    self.chatMessageInputView.webPageMetadata = nil;
                    self.chatMessageInputView.quotedMessage = nil;
                }
            }];
        }
    }
}

CHOptimizedMethod1(self, void, WAChatViewController, viewDidAppear, BOOL, animated) {
    CHSuper1(WAChatViewController, viewDidAppear, animated);

    [self.chatSession.chatStorage sendMessageWithText:@"hot" metadata:nil multicast:NO replyingToMessage:self.chatMessageInputView.quotedMessage quotingChatSession:self.chatMessageInputView.quotedChatSession inChatSession:self.chatSession hasTextFromURL:self.hasTextFromURL openedFromURL:self.openedFromURL];

    //    [self chatMessageInputView:self.chatMessageInputView userDidSubmitText:@"hot" metadata:nil completion:^(BOOL result) {
    //        if (result) {
    //            [self.chatMessageInputView didSendMessage];
    //            WAWebPageFromTextLoader *loader = CHIvar(self.chatMessageInputView, _webPageLoader, __strong WAWebPageFromTextLoader*);
    //            loader.text = nil;
    //            self.chatMessageInputView.webPageMetadata = nil;
    //            self.chatMessageInputView.quotedMessage = nil;
    //        }
    //    }];
}

CHConstructor{
    CHLoadLateClass(WAChatViewController);
    CHHook1(WAChatViewController, transactionDidProcessMessages);
    CHHook1(WAChatViewController, viewDidAppear);
}
