# Signal-Filtering-Techniques
Realised a Shazam like type application, in order to analyze the spectrum of any signal. Used a database with EKG records.
Pentru implementarea functiei ecg_function am procedat in felul urmator:
	
-> am citit din fisierul rec_1m.mat al fiecarei persoane valorile vectorului
corespunzator semnalului filtrat (folosind importdata) si le introduc intr-o
matrice (matrix) cu 90 linii si 5000 coloane (lungimea semnalului);

-> descompun semnalul filtrat al persoanelor intr-o suma de armonice pentru
a putea obtine valorile amplitudinilor;

-> selectez primele 100 cele mai mari amplitudini, iar pe baza indicilor lor 
aflu pulsatia corespunzatoare fiecarei amplitudini;

-> realizez vectorul de caracterizare al fiecarei persoane si il salvez
intr-o noua matrice (matrix2);

-> in continuare, in functie de variabila israw (0, daca input_signal este 
filtrat sau 1, daca este nefiltrat), construiesc vectorul de caracterizare al
lui input_signal (daca israw = 1, filtrez semnalul prin intermediul produsului
de convolutie cu o functie de tipul filtru = A*exp(-a*t), coeficientii 
alegandu-i dupa mai multe incercari);

-> compar vectorul de caracterizare de la input_signal cu vectorii de 
caracterizare de la toate persoanele cu ajutorul distantei euclidiene 
(folosesc functia norm), iar pentru distanta cu cea mai mica valoare, 
returnez indicele liniei din matricea matrix2, adica person_id.
