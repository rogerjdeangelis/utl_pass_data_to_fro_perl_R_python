SAS-L Using the win 7 clipboard to pass data to and from  R, Python and Perl

   Perl is the most flexible with many options


   WORKING CODE
   ============

     PYTHON factoring 'x**2 -4'
     ==========================

       SAS 'x**2 - 4' to clipboard  (send x**2 -4
           filename clp clipbrd ;
           file clp;
           equ='x**2 - 4';
           put equ;

       PYTHON read clipboard 'x**2 -4' (factoring 'x**2 - 4' )
          equ = pyperclip.paste();
          sol = str(solve(equ, x));
          roots = "roots are " + sol;

          * write roots to clipboard;
          pyperclip.copy(roots);

       SAS read result from Python (note you can just cntl v)
           filename clp clipbrd ;
              infile clp;
              input;
              put _infile_;

     R   (same as Python above)
     ==========================

       SAS 'x**2 - 4' to clipboard  (send x**2 -4
           filename clp clipbrd ;
           file clp;
           equ='x**2 - 4';
           put equ;

       R   (evaluate fa(4) = x**2 - 4 ==> 12)
           str<-readClipboard();
           x=4;
           fx<-eval(parse(text=str));
           strfx<-as.character(fx);
           fof4<-paste("f(4) =",strfx);
           writeClipboard(fof4);

       SAS read result from Python (note you can just cntl v)
           filename clp clipbrd ;
              infile clp;
              input;
              put _infile_;

     PERL (same as Python above)
     ===========================

       SAS 'x**2 - 4' to clipboard  (send x**2 -4
           filename clp clipbrd ;
           file clp;
           equ='x**2 - 4';
           put equ;

       PERL

         use Win32::Clipboard;`
         $CLIP = Win32::Clipboard();`
         print "Clipboard contains: ", $CLIP->Get(), "\n";`
         $CLIP->Set("xxsome text to copy into the clipboardxx");`
         $CLIP->WaitForChange();`
         print "Clipboard has changed!\n";`

       SAS read result from Python (note you can just cntl v)
           filename clp clipbrd ;
              infile clp;
              input;
              put _infile_;



HAVE
=====

     Text in the SAS clipboard (paste buffewr)

         x**2 - 4

WANT (operate on text and return changed clipboard to SAS )
===========================================================

     Python

         roots of x**2-4 are [2, -2]

     R
         f(x) = x**2 - 4  so f(4)=12

     Perl

       got x**2 - 2

       returned  some text from Perl in the clipboard

*            _   _
 _ __  _   _| |_| |__   ___  _ __
| '_ \| | | | __| '_ \ / _ \| '_ \
| |_) | |_| | |_| | | | (_) | | | |
| .__/ \__, |\__|_| |_|\___/|_| |_|
|_|    |___/
;

* always rerun this then python;
filename clp clipbrd ;
data _null_;
 file clp;
 equ='x**2 - 4';
 put equ;
run;quit;

%utl_submit_py64('
import pyperclip;
from sympy import *;
x = symbols("x");
equ = pyperclip.paste();
print(equ);
sol = str(solve(equ, x));
roots = "roots are " + sol;
print(roots);
pyperclip.copy(roots);
');

*____
|  _ \
| |_) |
|  _ <
|_| \_\

;

* always rerun this then python;
filename clp clipbrd ;
data _null_;
 file clp;
 equ='x**2 - 4';
 put equ;
run;quit;


%utl_submit_r64('
str<-readClipboard();
x=4;
fx<-eval(parse(text=str));
strfx<-as.character(fx);
fof4<-paste("f(4) =",strfx);
writeClipboard(fof4);
fof4;
');

* retrieve from R;
filename clp clipbrd ;
data _null_;
 infile clp;
 input;
 put _infile_;
run;quit;

*                _
 _ __   ___ _ __| |
| '_ \ / _ \ '__| |
| |_) |  __/ |  | |
| .__/ \___|_|  |_|
|_|
;

* always rerun this then python;
filename clp clipbrd ;
data _null_;
 file clp;
 equ='x**2 - 4';
 put equ;
run;quit;

* not 64 bit it is 32 bit;
%utl_submit_pl64('
   #!c:/perl/bin/perl -w
    use strict;`
    use warnings;`
    use Win32::Clipboard;`
    $CLIP = Win32::Clipboard();`
    print "Clipboard contains: ", $CLIP->Get(), "\n";`
    $CLIP->Set("xxsome text to copy into the clipboardxx");`
    $CLIP->WaitForChange();`
    print "Clipboard has changed!\n";`
');

* retrieve from perl;
filename clp clipbrd ;
data _null_;
 infile clp;
 input;
 put _infile_;
run;quit;


HOW TO INSTALL PACKAGES
========================

/* T005585 install R, perl and python packages and modules */


* Get Perl
http://strawberryperl.com/releases.html
strawberry-perl-5.10.1.1.msi
just follow the steps

* installing a module;
> perl -MCPAN -e shell
cpan> install CAM::DBF

R

c:/R
>install.packages('meta')

Python

cd c:/python/scripts
pip install Win32::Clipboard


