EQVersionCompare
================

Simple Objective-C Class to Compare Version Number (X.X.X)

Motivation
----------

I needed to compare version strings to determine whether data needs to be manually migrated. Most references I found suggested to use `[NSString compare:optionsNSNumericSearch]`. This is not accurate when comparing between strings like "2.4.06" and "2.4.4", which will return "2.4.06" as the more recent version, when "2.4.4" should be instead.

I found a better comparator at https://github.com/nicolasembleton/NEVersionCompare, but to me, it seemed to be a little heavy, with a wrapper class around each version string, and several object creations (`[NSString subStringWithRange:]`, `[NSString stringByAppendingString:]`, etc). It also assumed that versions are made of four groups, and memory is assigned to hold their values.

As an exercise to myself, I created this class with the goal of improving ease of use (No wrapper class, just one class method), increasing performance and reducing memory footprint by parsing strings directly. I have not done a performance comparison as this is not a project to discredit other people's work, and I feel the differences will be negligible. Theoretically this should perform slightly faster.

Comparison
----------

Non-numerical characters are ignored. First character of a string must begin with a number, or 0 will be assumed. Here are some comparison results:

`1.3.0 is equal to 1.3.0`

`1.3.0 is smaller than 1.3.1`

`1.3.0 is greater than 1.2.9`

`1.3.0 is smaller than 1.3.0.1` *(1.3.0 is treated as 1.3.0.0)*

`1.3.0.0 is equal to 1.3.0`

`1.3.0A is equal to 1.3.0B` *(non-numeric is ignored)*

`1.3.100 is greater than 1.3.1`

`..3.100 is smaller than 1..3.` *(first group of ..3.100 is assumed to be 0)*

`.a.3.100 is greater than b.1.3.` *(0.3.100.0 is greater than 0.1.3.0)*

I've also included the EQVersionCompareTests test class which produced this output.

If your version string contains non-numeric, then this class may not produce the right results for your use case. Version strings for iOS should only include numbers *(ref: https://developer.apple.com/library/ios/documentation/IDEs/Conceptual/AppDistributionGuide/ConfiguringYourApp/ConfiguringYourApp.html)*.

Usage
-----

Import EQVersionCompare.h & EQVersionCompare.m into your project.

Compare two version strings with `[EQVersionCompare compareVersion:with:]`. First version string is greater than second one if it returns `NSOrderedAscending` or `EQVersionCompareSmaller`.

License
-------

MIT License. Use in your projects and change it as desired.
