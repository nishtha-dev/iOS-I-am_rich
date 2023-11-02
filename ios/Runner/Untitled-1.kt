{
    act=android.intent.action.SEND 
    typ=image/jpeg flg=0x1 
    pkg=org.telegram.messenger 
    cmp=org.telegram.messenger/org.telegram.ui.LaunchActivity 
    clip={image/jpeg {U(content)}} (has extras)} from uid 10394



     ActivityTaskManager: START u0 {
        act=android.intent.action.VIEW 
        dat=http://www.twitter.com/... 
        cmp=com.twitter.android/com.twitter.deeplink.implementation.UrlInterpreterActivity} from uid 10395


 START u0 {
    act=android.intent.action.VIEW 
    dat=http://www.twitter.com/... 
    cmp=com.twitter.android/com.twitter.deeplink.implementation.UrlInterpreterActivity (has extras)} from uid 10395


Received SERVICE intent 0x5af6458 Key{startService 
    pkg=com.twitter.android 
    intent=act=com.twitter.android.notif.dismiss 
    dat=content://com.twitter.android.provider.TwitterProvider/... 
    pkg=com.twitter.android 
    cmp=com.twitter.android/com.twitter.notification.push.NotificationService flags=0x4000000 u=0} requestCode=0 from uid 1000

    ctivityManager: Received SERVICE intent 0x5c0157e Key{
        startService pkg=com.twitter.android 
        intent=act=com.twitter.android.notif.dismiss 
        dat=content://com.twitter.android.provider.TwitterProvider/... 
        pkg=com.twitter.android cmp=com.twitter.android/com.twitter.notification.push.NotificationService 
        flags=0x4000000 u=0} requestCode=0 from uid 1000
