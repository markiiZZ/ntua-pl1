# Programming Languages I 
Programming Languages assignments for ECE NTUA course Programming Languages I (2018-2019)

Contains the solution to the lottery problem written in `SML` and `Prolog`. 

## Lottery Problem 

`N` tickets are given as an input, each one represented by a positive integer <code>X<sub>i</sub></code> with exactly `K` decimal digits. There are `Q` possible winning lottery tickets <code>Y<sub>j</sub></code>. For each <code>Y<sub>j</sub></code> we have to calculate how many <code>X<sub>i</sub></code> tickets win a non-zero amount of money and this total exact amount. Note that each ticket <code>X<sub>i</sub></code> whose <code>M</code> last digits are the same with the <code>M</code> last digits of <code>Y<sub>j</sub></code> wins <code>2<sup>M</sup> - 1 </code> points (amount of money).

This problem is solved in [Standard ML](https://github.com/markiiZZ/ntua_pl1/blob/main/lottery.sml) and [Prolog](https://github.com/markiiZZ/ntua_pl1/blob/main/lottery.pl)

[Assignment in Greek](https://github.com/markiiZZ/ntua_pl1/blob/main/exerc19-2.pdf)

[Testcases](https://github.com/markiiZZ/ntua_pl1/tree/main/testcases)
