{License, info, etc
 ------------------
This implementation is made by me, Walied Othman, to contact me
mail to rainwolf@submanifold.be or triade@submanifold.be ,
always mention wether it 's about the FGInt or about the 6xs, 
preferably in the subject line.
This source code is free, but only to other free software, 
it's a two-way street, if you use this code in an application from which 
you won't make any money of (e.g. software for the good of mankind) 
then go right ahead, I won't stop you, I do demand acknowledgement for 
my work.  However, if you're using this code in a commercial application, 
an application from which you'll make money, then yes, I charge a 
license-fee, as described in the license agreement for commercial use, see 
the textfile in this zip-file.
If you 're going to use these implementations, let me know, so I ca, put a link 
on my page if desired, I 'm always curious as to see where the spawn of my 
mind ends up in.  If any algorithm is patented in your country, you should
acquire a license before using this software.  Modified versions of this
software must contain an acknowledgement of the original author (=me).

This implementation is available at 
http://www.submanifold.be

copyright 2000, Walied Othman
This header may not be removed.}

Unit FGIntPrimeGeneration;

Interface

Uses SysUtils, FGInt;

Procedure PrimeSearch(Var GInt : TFGInt);

Implementation


{$H+}


// Does an incremental search for primes starting from GInt,
// when one is found, it is stored in GInt

Procedure PrimeSearch(Var GInt : TFGInt);
Var
   two : TFGInt;
   ok : Boolean;
Begin
   If (GInt.Number[1] Mod 2) = 0 Then GInt.Number[1] := GInt.Number[1] + 1;
   Base10StringToFGInt('2', two);
   ok := false;
   While Not ok Do
   Begin
      FGIntAddbis(GInt, two);
      FGIntPrimeTest(GInt, 4, ok);
   End;
   FGIntDestroy(two);
End;

End.
