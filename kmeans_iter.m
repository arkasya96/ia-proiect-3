function [C, etichetare] = kmeans_iter(X, K, iterMax)
% implementeaza algoritmul k-means
%
% Input:  
%        X - N x d, X contine pe fiecare linie un vector de caracteristici, N puncte d-dimensionale
%        K - numarul de clusteri
%  iterMax - numarul maxim de iteratii
% Output: 
%        C - contine clusterii, o matrice K x d, fiecare linie contine un cluster
%        etichetare - vector coloana N x 1, care specifica carui cluster
%                     apartine fiecare punct din X

X = double(X);
[N, d] = size(X);

%Initializam centri clusterilor = puncte din X alese aleator diferite
permutare = randperm(N);
C = X(permutare(1:K),:);

%etichetare initiala
etichetare = zeros(N, 1);

%algoritmul iterativ propriu-zis
iter = 0;
while true
    iter = iter + 1;
    disp(['iteratia = ' num2str(iter)]);
    % determina apartenenta fiecarui punct din X la un cluster
    etichetareOptima = zeros(N, 1);
    distantaMinima = Inf*ones(N, 1);
    for k = 1:K
        for n = 1:N
            %distanta Euclidiana
            distanta = sum((X(n, :)-C(k, :)).^2);
            if distanta < distantaMinima(n)
                distantaMinima(n) = distanta;
                etichetareOptima(n) = k;
            end
        end
    end
    
    % iesi din while daca nu s-au schimbat centri
    if all(etichetareOptima==etichetare) || (iter == iterMax)
        break;
    end;
    
    etichetare = etichetareOptima;
    
    
    %determina centri noilor clusteri pe baza punctelor
    for k = 1:K
        C(k, :) = mean(X(etichetareOptima==k, :));
    end
    
end