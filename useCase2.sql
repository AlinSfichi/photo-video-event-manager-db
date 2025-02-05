-- Use Case: Adăugare Eveniment
-- Scop: Adăugarea unui eveniment nou în tabelul Evenimente, asociat unui client existent.
-- Testare: Scriptul verifică existența clientului și a unui eveniment similar înainte de inserare.
--          Testează constrângerile referențiale și unicitatea datelor.

-- activarea afisarii cu DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

DECLARE
    v_client_id NUMBER; -- Variabilă pentru identificarea clientului
    v_exista_eveniment NUMBER; -- Verificare existență eveniment
BEGIN
    SAVEPOINT before;

    -- Verificare existență client
    SELECT client_id INTO v_client_id
    FROM Clienti 
    WHERE email = 'andrei.ionescu@example.com';

    -- Verificare existență eveniment pentru acest client
    SELECT COUNT(*) INTO v_exista_eveniment
    FROM Evenimente 
    WHERE client_id = v_client_id 
    AND data_eveniment = TO_DATE('2025-03-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS');

    IF v_exista_eveniment > 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Eroare: Evenimentul pentru clientul cu ID-ul ' || v_client_id || ' există deja.');
    END IF;

    -- Adăugare eveniment
    INSERT INTO Evenimente (client_id, data_eveniment, tip_eveniment, pret_eveniment, avans, durata)
    VALUES (
        v_client_id,
        TO_DATE('2025-03-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS'),
        'Petrecere aniversară',
        3000,
        1000,
        4
    );

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20004, 'Eroare: Adăugarea evenimentului a eșuat.');
    END IF;

    -- Commit dacă toate operațiunile au fost efectuate cu succes
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('TOTUL A FUNCTIONAT CU SUCCES!');

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20005, 'Eroare: Clientul nu există în sistem.');
    WHEN OTHERS THEN
        ROLLBACK TO before;
        RAISE_APPLICATION_ERROR(-20006, 'A apărut o eroare: ' || SQLERRM);
END;


--Verificare
/*
SELECT * FROM Evenimente
WHERE client_id = (
    SELECT client_id 
    FROM Clienti 
    WHERE email = 'andrei.ionescu@example.com'
)
AND data_eveniment = TO_DATE('2025-03-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS');

*/

--Stergere eveniment pentru test/debug
/*
DELETE FROM Evenimente
WHERE client_id = (
    SELECT client_id 
    FROM Clienti 
    WHERE email = 'andrei.ionescu@example.com'
)
AND data_eveniment = TO_DATE('2025-03-20 14:00:00', 'YYYY-MM-DD HH24:MI:SS');

*/
