#TextPerformance

BUG BOUNTY - $50 (NEGOTIABLE, DEPENDING ON DIFFICULTY) TO IMPROVE PERFORMANCE WITH OPENFL TEXTFIELDS.

For the bounty, performance should not noticeably decline for each subsequent append operation in a textfield, with realistic sizes of text (a few thousand words).

Included in this repo is a simple test case that illustrates the issue. Source code can be found in src/Main.hx or you can try it out at http://tamarcurry.com/openFLTextPerformance/

In HTML5 builds of OpenFL projects, there is significant overhead when using the appendText(...) function in openfl.text.TextField when displaying large amounts of text.

As far as I can tell, this is due to hefty looping and inline functions within the getLayoutGroups() function in openFL._internals.text.TextEngine.

I've managed to implement some performance improvements (see the document and classes in the "test" folder) but they don't address the issue entirely.

We're willing to pay for a solution for this issue assuming the pull request for the fix is successfully merged into the OpenFL Github project (found at https://github.com/openfl/openfl).

Not sure what the best solution to the issue is, but caching previously rendered lines of text *should* be sufficient.