datatype 'a trie = empty | node of 'a  * 'a trie list;

fun merge [] a = a
| merge (hs::ts) a = merge ts (hs::a)

fun inserthelp [] _ _ = [empty]
| inserthelp ((hs:IntInf.int)::ts) (node ((hc,(num:IntInf.int)),a)::tc) rest = if hs=hc then (node ((hc,num+1),inserthelp ts a []))::(merge tc rest) else inserthelp (hs::ts) tc (node ((hc,num),a)::rest)
| inserthelp (hs::ts) [] rest = (node ((hs,1),inserthelp ts [] []))::rest
| inserthelp (hs::ts) [empty] rest = (node ((hs,1),inserthelp ts [] []))::rest
| inserthelp (hs::ts) (empty::tc) rest = inserthelp (hs::ts) tc rest

fun find [] _ sum _ = sum
| find _ [] sum _ = sum
| find _ [empty] sum _ = sum
| find ((hs:IntInf.int)::ts) (node ((hc,(num:IntInf.int)),a)::tc) (sum:IntInf.int) (counter:IntInf.int) = if hs=hc then find ts a ((sum+(num*counter)mod 1000000007)mod 1000000007) (2*counter mod 1000000007) else find (hs::ts) tc sum counter
| find (hs::ts) (empty::tc) sum counter = find (hs::ts) tc sum counter

fun count (hs:IntInf.int) (empty::tc) = count hs tc
| count hs [] = 0
| count hs (node ((hc,(num:IntInf.int)),a)::tc) = if hs=hc then num else count hs tc

(* o kwdikas pou uparxei kai se prohgoumenh askhsh einai apo to stackoverflow*)
fun filelist inputf =
let
fun loop inputf =
case TextIO.inputLine inputf of
SOME line => line :: loop inputf
|NONE => [];
in
loop inputf
end

fun charint a = IntInf.fromString(str a)

fun mapint a =
case charint a of
SOME b => b
| NONE => 0


fun reversein a =
let
val _::ret = merge a []
in
map mapint ret
end

fun insert 0 (a,b) = (a,b)
| insert (n:IntInf.int) (a,hs::ts) = insert (n-1) (inserthelp hs a [] ,ts)

fun resolve _ [] = ()
| resolve trie (hs::ts) =
let
val a = find hs trie 0 1
val myh::_=hs
val b = count myh trie
val c = print ((IntInf.toString(b))^" ")
val d = print(IntInf.toString(a) ^ "\n")
in resolve trie ts
end

fun lottery file=
let
(*o kwdikas gia tin anagnwsi parthike apo to site tou mathimatos*)
  fun readInt input =
  Option.valOf (TextIO.scanStream (IntInf.scan StringCvt.DEC) input)

  val inStream = TextIO.openIn file
  val K = readInt inStream
  val N = readInt inStream
  val Q = readInt inStream
  val _::arxeio = filelist inStream
  val arxeio2 = map explode arxeio
  val arxeio3 = map reversein arxeio2
  val (trie,queries) = insert N ([empty], arxeio3)
  (*val trash = printtrie trie*)
in
resolve trie queries
end
