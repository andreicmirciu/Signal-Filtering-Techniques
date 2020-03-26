% Mirciu Andrei-Constantin 323CD
function [person_id ] = ecg_function(input_signal, israw)
    numfiles = 90;
    minimum = [-1 0];
    matrix = zeros(numfiles, 5000);
    matrix2 = zeros(numfiles, 200);
    x = zeros(1,100);
    puls = zeros(1,100);
    VectCaract = zeros(1,200);
    VectCaract2 = zeros(1,200);
    name1 = 'ECG-DB\';
    name2 = 'Person_%02d';
    name3 = '\rec_1m.mat';
    for k = 1:numfiles
        filename1 = sprintf(name2,k);
        filename2 = strcat(name1,filename1,name3);
        val = importdata(filename2);
        matrix(k,:) = val(2,:); % matrice in care stochez semnalul filtrat al fiecarei persoane
    end  
    Fs = 500; % frecventa semnalului
    T = 1 / Fs; % perioada semnalului
    L = length(matrix(1,:)); % lungimea semnalului
    f = Fs * (0:(L/2))/L; % pulsatia semnalului
    for k = 1:numfiles
        Y = fft(matrix(k,:));
        P2 = 2 * abs(Y/L);
        P1 = P2(1:L/2+1); % vector de amplitudini
        [B, I]= maxk(P1,100); % extrag primele 100 cele mai mari amplitudini
        for a = 1:100
            puls(1,a) = f(1,I(1,a)); % extrag pulsatiile corespunzatoare amplitudinilor
        end
        i = 1;
        j = 1;
        % construiesc vectorul de caracterizare pentru fiecare persoana
        for b = 1:200
            if (mod(b,2) ~= 0)
                VectCaract(1,b) = [B(1,i)];
                i = i + 1;
            else
                VectCaract(1,b) = [puls(1,j)];
                j = j + 1;
            end
        end
        matrix2(k,:) = VectCaract; % matrice in care stochez vectorul de caracterizare al fiecarei persoane
    end
%------------------------------------------------------------------------
    if (israw == 0) 
        Yis = fft(input_signal);
        P2is = 2 * abs(Yis/L);
        P1is = P2is(1:L/2+1);
        [Bis, Iis] = maxk(P1is, 100);
        for k = 1:100
            x(1,k) = f(1,Iis(1,k)); % vector cu pulsatiile specifice amplitudinilor
        end
        i = 1;
        j = 1;
        for k = 1:200
            if (mod(k,2) ~= 0)
                VectCaract2(1,k) = [Bis(1,i)];
                i = i + 1;
            else
                VectCaract2(1,k) = [x(1,j)];
                j = j + 1;
            end
        end   
        for k = 1:numfiles
            result = norm(VectCaract2 - matrix2(k,:));
            if (result == 0) 
                person_id = k;
            end
        end
    end
%------------------------------------------------------------------------
    if (israw == 1)
        t = 0:0.01:1.4;
        filtru = 0.51*exp(-100.9*t);
        signal = conv(input_signal,filtru,'same');
        Yis = fft(signal);
        P2is = 2 * abs(Yis/L);
        P1is = P2is(1:L/2+1);
        [Bis, Iis] = maxk(P1is, 100);
        for k = 1:100
            x(1,k) = f(1,Iis(1,k)); % vector cu pulsatiile specifice amplitudinilor
        end
        i = 1;
        j = 1;
        for k = 1:200
            if (mod(k,2) ~= 0)
                VectCaract2(1,k) = [Bis(1,i)];
                i = i + 1;
            else
                VectCaract2(1,k) = [x(1,j)];
                j = j + 1;
            end
        end
        minimum(1) = norm(VectCaract2 - matrix2(1,:));
        % calculez distanta euclidiana minima
        for k = 2:numfiles
            result = norm(VectCaract2 - matrix2(k,:));
            if (min(result,minimum(1)) == result)
                minimum(1) = result;
                minimum(2) = k;
            end      
        end
        person_id = minimum(2);
    end
end  