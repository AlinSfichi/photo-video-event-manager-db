-- Use Case: Adăugare Client
-- Scop: Adăugarea unui client nou în tabelul Clienti.
-- Testare: Scriptul verifică unicitatea email-ului și existența clientului înainte de inserare.
--          Testează constrângerile UNIQUE și integritatea datelor.

-- activarea afisarii cu DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

DECLARE
    v_client_id NUMBER; -- Variabilă pentru stocarea client_id
    v_exista_client NUMBER; -- Verificare existență client
BEGIN
    SAVEPOINT before;

    -- Verificare existență client
    SELECT COUNT(*) INTO v_exista_client
    FROM Clienti 
    WHERE email = 'andrei.ionescu@example.com';

    IF v_exista_client > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Eroare: Clientul există deja în sistem.');
    END IF;

    -- Adăugare client
    INSERT INTO Clienti (nume, prenume, telefon, email)
    VALUES ('Ionescu', 'Andrei', '0733456789', 'andrei.ionescu@example.com')
    RETURNING client_id INTO v_client_id;

    IF v_client_id IS NULL THEN
        RAISE_APPLICATION_ERROR(-20002, 'Eroare: Adăugarea clientului a eșuat.');
    END IF;

    -- Commit dacă toate operațiunile au fost efectuate cu succes
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('TOTUL A FUNCTIONAT CU SUCCES!');

EXCEPTION
    WHEN OTHERS THEN
        -- Rollback în caz de eroare
        ROLLBACK TO before;
        RAISE_APPLICATION_ERROR(-20003, 'A apărut o eroare: ' || SQLERRM);
END;

--Verificare
/*
SELECT * FROM Clienti
WHERE nume = 'Ionescu'
AND prenume = 'Andrei'
AND telefon = '0733456789'
AND email = 'andrei.ionescu@example.com';
*/

--Stergere client pentru test/debug
/*
DELETE FROM Clienti
WHERE email = 'andrei.ionescu@example.com';
*/
