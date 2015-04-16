possible_birthday('May', 15).
possible_birthday('May', 16).
possible_birthday('May', 19).
possible_birthday('June', 17).
possible_birthday('June', 18).
possible_birthday('July', 14).
possible_birthday('July', 16).
possible_birthday('August', 14).
possible_birthday('August', 15).
possible_birthday('August', 17).

/* A helper predicate. Check if the month contains any day 
   that uniquely decides Month */
month_with_deciding_day(Month):- 
    possible_birthday(Month,Day), 
    findall(M, possible_birthday(M,Day), [_]).

/* Albert says "I don't know and Bernard doesn't know either"  */
albert1(Month, Day):- possible_birthday(Month, Day),
	/* albert doesn't know, so there are at least 2 different possible 
	   birthdays in that month*/
   findall(D, possible_birthday(Month,D), [_,_|_]),
   /*  Bernard doesn't know, so the month doesn't contains any possible birthday 
       that uniquely decides the month, e.g. Day=19 decides Month=May */
   \+month_with_deciding_day(Month). 

/* Now bernard knows. That means the Day uniquely decide Month */
bernard1(Month, Day):- 
  possible_birthday(Month, Day), 
  findall(M, albert1(M, Day), [Month]). /* the day uniquely decides month */

/* Now albert knows */
albert2(Month, Day):-
  possible_birthday(Month, Day),   
  findall(D, bernard1(Month, D), [Day]). /* the month uniquely decides day */

cheryls_birthday(Month, Day):- albert2(Month, Day).

