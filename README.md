air-icon-badge
==============

Have you ever built an air application where you wanted to inform the user about new events (e.g. unread messages or news)? OS X provides an consistent way for this by using the applications dock icon. If you receive for example 3 new mails, a red badge will be displayed at the Mail.app dock icon. Every OS X application can use this functionality as it is part of the Cocoa framework.

So far, air has no built in way to use this native badge. This is where the icon-badge-library comes in handy. It provides a simple API for displaying a badge label for your air application. All you need to do is assigning the string that should be displayed.

Furthermore the API allows you to create your own badge or to use it for the Windows tray icon. Until now, there is no default windows tray icon support implemented, as the tray icon is very small and Windows has no standard graphics for such a badge label. But a system tray example implementation can be seen here.

Get started: [Introduction with example and preview](http://blog.mattes-groeger.de/category/libraries/air-icon-badge/)

If you use this library for your air application, please let me know. I will add your project to a list of examples.