-- Use Case: Actualizare Date Client
-- Scop: Actualizarea informațiilor unui client existent în tabelul Clienti.
-- Testare: Scriptul verifică existența clientului și validează noile informații înainte de actualizare.

-- activarea afisarii cu DBMS_OUTPUT.PUT_LINE
SET SERVEROUTPUT ON;

DECLARE
    v_client_id NUMBER; -- Variabilă pentru identificarea clientului
    x_client_id NUMERIC(5);
BEGIN
    x_client_id:=3023;
    SAVEPOINT before;

    -- Verificare existență client
    SELECT COUNT(*) INTO v_client_id
    FROM Clienti 
    WHERE client_id = x_client_id; -- ID-ul clientului ce trebuie actualizat

    IF v_client_id = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Eroare: Clientul nu există în sistem.');
    END IF;

    -- Actualizare date client
    UPDATE Clienti
    SET nume = 'Calin',
        prenume = 'Calinescu',
        telefon = '0767456722',
        email = 'calin.calinescu@example.com'
    WHERE client_id = x_client_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Eroare: Actualizarea datelor clientului a eșuat.');
    END IF;

    -- Commit dacă toate operațiunile au fost efectuate cu succes
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('TOTUL A FUNCTIONAT CU SUCCES!');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK TO before;
        RAISE_APPLICATION_ERROR(-20003, 'A apărut o eroare: ' || SQLERRM);
END;

-- Verificare
/*
SELECT * FROM Clienti
WHERE client_id = 3023;
*/

