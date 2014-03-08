FCPageControl
=============

Lightweight, high customizable replacement for UIPageControl

Compatibility
------------
FCPageControl is tested against iOS versions greater or equal than 6.0.  
The base SDK has to be 7.0 or greater because of the new obj-c syntax.


Installation
------------
Just drop the header and implementation file to you proyect and you're good to go.

Enhancements over UIPageControl
-------------------------------

#### Fill options ####
There are four possible types:

*	<code>FCPageControlTypeActiveFillInactiveFill</code>
*	<code>FCPageControlTypeActiveFillInactiveEmpty</code>
*	<code>FCPageControlTypeActiveEmptyInactiveFill</code>
*	<code>FCPageControlTypeActiveEmptyInactiveEmpty</code>

#### Dots color ####
It allows to set colors for the active and inactive elements, no more hacks to switch the dots for images.

*	<code>activeColor:(UIColor *)</code>
*	<code>inactiveColor:(UIColor *)</code>

#### Dots diameter and spacing ####
Now you can set the diameter of the dots, as well as the space between them.

*	<code>dotDiameter:(CGFloat)</code>
*	<code>dotMargin:(CGFloat)</code>

Also it inmplements all the common funcionality of the UIPageControl, check the header file for more info.

Delegate
--------

FCPageControl provides a delate with optional methods:  

*	<code>pageControl:Clicked:</code>
	*	It retuns the index of the dot clicked.

