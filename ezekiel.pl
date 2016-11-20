% eliza.Pl

% Reads a line of input, removes all punctuation characters, and converts
% it into a list of atomic terms
:- [readline].

eli_start :- write('This is Ezekiel. It is a simple chatbot that will converse with you'), nl, 
			 write('The bot is not a personal assistant, rather just a companion'), nl,
			 write('You can talk about your feelings, day, or ask some questions'), nl,
			 write('type in <hi_ezekiel.> in the prompt. To end your session simply type <bye>. Enjoy!').
hi_ezekiel :- 
	   write('Hi, my name is Ezekiel. How are you?'), nl,
       %read(Input),
	   readline(Input),
	   eliza(Input),!.

eliza(['bye']) :-
	reply(['Bye, Enjoy the rest of your day!']). 
	
% recursive algorithm to conduct the conversation with the user
eliza(Input) :-
	pattern(Stim, Response), 
	match(Stim, Dict, Input), 
	match(Response, Dict, Output), 
	reply(Output), 
	readline(Input1), 
	!, eliza(Input1). 

% matching the input to the Stimulus pair
match([N|Pattern], Dict, Target) :-
	integer(N), lookup(N,Dict,Lt),
	append(Lt,Rt, Target), 
	match(Pattern, Dict, Rt).

match([Word|Pattern], Dictionary, [Word|Target]) :-
	atom(Word), match(Pattern, Dictionary, Target).

match([], _,[]).

% lookup dictionary
lookup(Key, [(Key, Value)|_], Value).
lookup(Key, [(Key1, _)|Dictionary], Value) :-
    \=(Key, Key1), lookup(Key, Dictionary, Value).

% adding_memory
%add_mem(X,Predicate, Y) :-
%	print(X), nl, print(Predicate), nl, print(Y), 
%	Fact =.. [Predicate,X,Y],
%	asserta(Fact).

% pattern matching
%pattern([i,am,1], ['How', long, have, you, been, 1,'?']) :-
%	add_mem(i,am,X).

:- dynamic(pattern/1).

pattern([_, you, B, me], ['What', makes, you, think, 'I', B, you, '?']).
pattern([i, like, A], ['Does', anyone, else, in, your, family, like, A, '?']).
pattern([i, feel, A], ['Do', you, often, feel, A, '?']).

%% asking about how the bot is doing
pattern([_,how, are, you,_|_],['Swell! Thanks for asking. What about you?']).
pattern([how, are, you,_|_],['I was bored until you came into my life! How are you?']).
pattern([how, are, you],['I\'m doing great. What about you?']).
pattern([i, am, in, X|_], ['Why', are, you, in, X, ?]).
pattern([i, am, in, X], ['Why', are, you, in, X, ?]).
pattern([i, am, X|_], ['Why', are, you, X, ?]).

%% similar adjectives that a user can describe
pattern([good,_|_], ['I',am, glad]).
pattern([good], ['I',am, glad]).
pattern([not,good], ['why?']).
pattern([bad,_|_],['Would you like to talk about it?']).
pattern([bad],['Would you like to talk about it?']).
pattern([shit],['Oh wow, why?']).

%% User asking about what the chatbot can do.
pattern([what,_,you,do,_|_],['Im here to converse']).
pattern([what,_,you,do],['Im here to converse']).
pattern([what,_,you,doing],['talking to someone that doesn\'t know how to carry a conversation']).
pattern([my, X, _|_], ['Please', tell, me, more, about, your, X,'.']).
pattern([_, sorry, _|_], ['Apologies are not necessary']).
pattern([_, is, the, weather, _|_], ['Ask Google']).
pattern([X, reminds, me, of,Y|_], ['Why does',X,'remind you of',Y]).
pattern([can, you, _|_], ['Probably']).
%pattern([do, _|_], ['No thanks!']).
pattern([what, are, you], ['Its Who, not what!']).
pattern([who, are, you], ['I\'m Ezekiel. I thought we already discussed this.']).
pattern([remind, me, _|_], ['Sorry, I am not your assistant!']).
pattern([_, remind, _|_], ['You have a calender for that!']).
pattern([i, feel, _|_], ['Do', you, often, feel, that, way, '?']).
pattern([you, are, _|_], ['I know I am, but what are you?']).
pattern([you, _|_], ['Yeah, I get that alot']).
pattern([am, i, _|_], ['Yeah, you are']).
pattern([remember,_|_], ['No, I do not remember. Please elaborate.']).
pattern([_,you, remember, _|_], ['Yeah, I remember. Good times.']).
pattern([if,_|_], ['Yeah, I would think so']).
pattern([hello], ['Hi','I',am,'Ezekiel.','How can I help?']).
pattern([hi], ['Hi, I am Ezekiel. How can I help?']).
pattern([hey], ['Hi, I am Ezekiel. How can I help?']).
pattern([hello,_|_], ['Hi, I am Ezekiel. How can I help?']).
pattern([_, you, interested, _|_], ['No, I have already told you that I am not interested']).
pattern([will, you, _|_], ['I dont want to.']).
pattern([please], ['stop']).
pattern([please, _|_], ['I dont think I can help you.']).
pattern([_, dreamt, _|_], ['What does that dream suggest to you?']).
pattern([perhaps, _|_], ['Why the uncertain tone?']).
pattern([why, is, _|_], ['I honestly couldn\'t tell you']).
pattern([why, doesnt, _|_], ['I don\'t know.']).
pattern([_, is, _|_], ['Yeah, I\'d have to agree.']).
pattern([i, love, you], ['I can\'t say I feel the same way']).
pattern([everyone, _|_], ['I think you\'re over-exaggerating']).
pattern([no], ['so....']).
pattern([yes], ['yes, indeed']).
pattern([i, once, _|_], ['cool story bro']).
pattern([im, _|_], ['I\'m not jealous.']).
pattern([what, are, your, thoughts, _|_], ['I couldn\'t care really. What do you think?']).
pattern([i, dont, _|_], ['Me neither']).
pattern([youre, _|_], ['And you\'re not?']).
pattern([because, _|_], ['Oh that makes sense. Please tell me more.']).

pattern([1], ['Please', go , on, '.']).

% reply
reply([Head|Tail]) :- write(Head), write(' '), reply(Tail). 
reply([]) :- nl.

:- eli_start.