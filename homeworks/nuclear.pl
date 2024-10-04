react('Adtina V').
react('Comati DX5').
react('Dynotis X1').
react('Tamura BX12').

principe('TP').
principe('fusor').
principe('DD').
principe('POLY').

country('France').
country('Zambia').
country('Ecuador').
country('Qatar').

month('January').
month('April').
month('March').
month('February').

%1. Реактор, запущенный в Марте - это либо 'DD' реактор, либо реактор, построенный во Франции.
first('March'-Principe-Country) :- 
    (Country = 'France', dif(Principe, 'DD')); 
    (dif(Country, 'France'), Principe = 'DD').
% Чтобы выполнялось для всех, что не в Марте
first(Mon-Principe-Country) :- dif('March', Mon). 
%2. Реактор 'Comati DX5' DX5 был запущен НЕ в Январе.
second(Mon-React) :- 
    dif(Mon, 'January'); 
    dif(React, 'Comati DX5').
%3. Реактор, запущенный в Марте, 'TP' реактор и реактор в Замбии - это три разных реактора.
third(Mon-Principe-Country) :- 
    (Mon = 'March', dif(Principe, 'TP'), dif(Country, 'Zambia')); 
    (Principe = 'TP', dif(Country, 'Zambia'), dif(Mon, 'March')); 
    (Country = 'Zambia', dif(Mon, 'March'), dif(Principe, 'TP'));
    (dif(Mon, 'March'), dif(Principe, 'TP'), dif(Country, 'Zambia')). 
%4. Реактор, запущенный в Январе - это либо 'TP' реактор, либо реактор из Катара.
four(Mon-Principe-Country) :- 
    Mon = "January", (
        (Country = 'Qatar', dif(Principe, 'TP')); 
        (dif(Country, 'Qatar'), Principe = 'TP')
    );
    dif(Mon, "January"). 
%5. Из двух реакторов, 'TP' реактор и реактор, запущенный в Феврале, один - это 'Comati DX5' DX5, а другой из Эквадора.
five(Mon-React-Principe-Country) :- 
    (((Principe = 'TP', dif(Mon, 'February')); (Mon = 'February', dif(Principe, 'TP'))) ,
    ((React = 'Comati DX5', dif(Country, 'Ecuador')); (Country = 'Ecuador', dif(React, 'Comati DX5'))));
    (dif(Principe, 'TP'), dif(Mon, 'February')).
%6. Реактор 'Tamura BX12' BX12 построен в Замбии.
six(React-Country) :- 
    (React = 'Tamura BX12', Country = 'Zambia');
    (dif(React, 'Tamura BX12'), dif(Country, 'Zambia')). 
%7. Реактор, запущенный в Апреле, 'Adtina V' V и 'fusor'-реактор - это три разных реактора.
seven(Mon-Principe-React) :- 
    (Mon = 'April', dif(Principe, 'fusor'), dif(React, 'Adtina V')) ; 
    (Principe = 'fusor', dif(React, 'Adtina V'), dif(Mon, 'April')) ; 
    (React = 'Adtina V', dif(Mon, 'April'), dif(Principe, 'fusor'));
    (dif(Mon, 'April'), dif(Principe, 'fusor'), dif(React, 'Adtina V')).
%8. Реактор из Катара - это либо реактор, запущенный в Марте, либо 'Dynotis X1' X1.
eight(Mon-React-Country) :- 
    (
        Country = 'Qatar', 
    ((Mon = 'March', dif(React, 'Dynotis X1')); 
    (dif(Mon, 'March'), React = 'Dynotis X1'))
    );
    dif(Country, 'Qatar').        

% Пересечение (объединяем все подсказки)
hints(Mon-React-Principe-Country) :- 
    month(Mon),
    country(Country),
    react(React),
    principe(Principe),
    first(Mon-Principe-Country),
    second(Mon-React),
    third(Mon-Principe-Country),
    four(Mon-Principe-Country),
    five(Mon-React-Principe-Country),
    six(React-Country),
    seven(Mon-Principe-React),
    eight(Mon-React-Country).

difBtwReactorsInfo(M-R-P-C, Mi-Ri-Pi-Ci) :- 
    dif(R, Ri), 
    dif(P, Pi),
    dif(C, Ci).
    dif(M, Mi), 
 
solution([X, Y, Z, U]) :- 
    findall(T, hints(T), L), 
    difBtwReactorsInfo(X, Y), 
    difBtwReactorsInfo(Z, Y), 
    difBtwReactorsInfo(Z, U), 
    difBtwReactorsInfo(X, U), 
    difBtwReactorsInfo(X, Z), 
    difBtwReactorsInfo(Y, U), 

    member(X, L), 
    member(Y, L), 
    member(Z, L), 
    member(U, L).