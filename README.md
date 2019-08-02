# TextPerformance

BUG BOUNTY - $25 TO IMPROVE PERFORMANCE WITH OPENFL TEXTFIELDS

Included in this repo is a simple test case that illustrates the issue. Source code can be found in src/Main.hx.

In HTML5 builds of OpenFL projects, there is significant slowdown when using the appendText(...) function in openfl.text.TextField when displaying large amounts of text.

As far as I can tell, this is due to hefty looping and inline functions within the getLayoutGroups() function in openFL._internals.text.TextEngine.

I've managed to implement some performance improvements (see the document and classes in the "test" folder) but they don't address the issue entirely.

We're willing to pay for a solution for this issue assuming the pull request for the fix is successfully merged into the OpenFL Github project.