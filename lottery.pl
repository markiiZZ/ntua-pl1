%1 [(Hc,Num,A)|T]

lottery(File,Answer):-
  read_input(File, _, N, Q, List),
  insert(N,List,[],NList,Trie),
  resolve(Q,NList,Trie,Answer).

insert(0,A,B,A,B).
insert(N,[H|T],Trie,NList,TRes):-
    atom_chars(H,Cs),
    reverse(Cs,RCs),
    inserthelp(RCs,Trie,NTrie),
    NN is N-1,
    insert(NN,T,NTrie,NList,TRes),!.

resolve(0,_,_,[]).
resolve(N,[H|T],Trie,[[Cc,Ff]|An]):-
    atom_chars(H,Cs),
    reverse(Cs,[Hs|Ts]),
    count(Hs,Trie,Cc),
    find([Hs|Ts],Trie,0,1,Ff),
    NN is N-1,
    resolve(NN,T,Trie,An),!.

%oi kanones gia to diavasma apo arxeio parthikan apo to site tou mathimatos
read_input(File, K, N, Q, Lines) :-
    open(File, read, Str),
    read_line(Str, [K, N, Q]),
    read_file(Str,Lines).

read_line(Stream, L) :-
      read_line_to_codes(Stream, Line),
      atom_codes(Atom, Line),
      atomic_list_concat(Atoms, ' ', Atom),
      maplist(atom_number, Atoms, L).

read_file(Stream,[]) :-
    at_end_of_stream(Stream).

%https://stackoverflow.com/questions/23411139/prolog-unexpected-end-of-file
read_file(Stream,[X|L]) :-
\+ at_end_of_stream(Stream),
read_line_to_codes(Stream,Codes),
atom_chars(X, Codes),
read_file(Stream,L), !.


inserthelp([Hs|Ts], [(Hs,Num,W)|Tc],[(Hs,NNum,NW)|Tc]):-
  NNum is Num+1,
  inserthelp(Ts,W,NW),!.
inserthelp([Hs|Ts],[(Hc,Num,W)|Tc],[(Hc,Num,W)|A]):-
  inserthelp([Hs|Ts],Tc,A),!.
inserthelp([Hs|Ts],[],[(Hs,1,A)]):- inserthelp(Ts, [],A).
inserthelp([],_,[]).


count(Hs,[(Hs,Num,_)|_],Num).
count(Hs,[_|Tc],Num):-count(Hs,Tc,Num).
count(_,[],0).


find([Hs|Ts],[(Hs,Num,W)|_],Sum,Counter,Final):-
  Nsum is (Sum +(Num*Counter) mod 1000000007) mod 1000000007,
  Ncounter is 2*Counter mod 1000000007,
  find(Ts,W,Nsum,Ncounter,Final),!.
find([Hs|Ts],[_|Tc],Sum,Counter,Final):-
  find([Hs|Ts],Tc,Sum, Counter, Final),!.
find([],_,Sum,_,Sum).
find(_,[],Sum,_,Sum).

mycheck(In,Out):-
  lottery(In,Answer),
  open(Out,read,Str),
  read_file(Str,Lines),
  recmy(Answer,Lines).

recmy([],[]).
recmy([[C,D]|T],[Hl|Tl]):-
  atom_string(Hl,L),
  split_string(L," ","",[A,B]),
  string_to_atom(A,Aa),
  atom_number(Aa,C),
  string_to_atom(B,Bb),
  atom_number(Bb,D),
  recmy(T,Tl).
