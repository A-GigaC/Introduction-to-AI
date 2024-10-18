:- use_module("/usr/local/WordNet-3.0/wnload/prolog/wn").
:- use_module(library(clpfd)).

listLength([], 0).
listLength([_|Ls], N) :- N #> 0, N1 #= N - 1, listLength(Ls, N1).

relate(Syn1, Syn2, memberMeronym) :- wn_mm(Syn1, Syn2).
relate(Syn1, Syn2, partmMeronym) :- wn_mp(Syn1, Syn2).
relate(Syn1, Syn2, hyperonym) :- wn_hyp(Syn1, Syn2).

relate_all(Word1/PoS1/Sense1/Syn1, Word2/PoS2/Sense2/Syn2, r(Word1/PoS1/Sense1, Rel, Word2/PoS2/Sense2)) :-
    wn_s(Syn1, _, Word1, PoS1, Sense1, _),
    wn_s(Syn2, _, Word2, PoS2, Sense2, _),
    relate(Syn1, Syn2, Rel).

relate_all(Word1/PoS1/Sense1/Syn1, Word2/PoS2/Sense2/Syn2, r(Word2/PoS2/Sense2, Rel, Word1/PoS1/Sense1)) :-
    wn_s(Syn1, _, Word1, PoS1, Sense1, _),
    wn_s(Syn2, _, Word2, PoS2, Sense2, _),
    relate(Syn2, Syn1, Rel).

% Search by synset
related_path_synset(Word1/PoS1/Sense1/Syn1, Word2/PoS2/Sense2/Syn2, [Step]) :- 
    relate_all(Word1/PoS1/Sense1/Syn1, Word2/PoS2/Sense2/Syn2, Step).

% Using length limit
related_path_synset(Word1/PoS1/Sense1/Syn1, Word2/PoS2/Sense2/Syn2, [Step|Path]) :-
    relate_all(Word1/PoS1/Sense1/Syn1, _/_/_/SynNext, Step),
    related_path_synset(_/_/_/SynNext, Word2/PoS2/Sense2/Syn2, Path).

related_words(Word1/PoS1/Sense1/Syn1, Word2/PoS2/Sense2/Syn2, MaxDist, Connected) :-
    N #> 0, N #=< MaxDist,
    listLength(Connected, N),
    related_path_synset(Word1/PoS1/Sense1/Syn1, Word2/PoS2/Sense2/Syn2, Connected).