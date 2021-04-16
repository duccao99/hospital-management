SET SERVEROUTPUT ON SIZE 30000;

DECLARE
    INPUT_STRING VARCHAR2(200):='DUCCAO-LEARNING-EN/DECRIPT';
    RAW_INPUT RAW(128):= 
    UTL_RAW.CAST_TO_RAW(CONVERT(INPUT_STRING,'AL32UTF8','US7ASCII'));
    
    KEY_STRING VARCHAR2(200) := 'KEY-USING-TO-Encrypt-&-Decrypt';
    RAW_KEY RAW(128):=
    UTL_RAW.CAST_TO_RAW(CONVERT(KEY_STRING,'AL32UTF8','US7ASCII'));
    
    ENCRYPTED_RAW RAW(2048);
    ENCRYPTED_STRING VARCHAR2(2048);
    
    DECRYPTED_RAW RAW(2048);
    DECRYPTED_STRING VARCHAR2(2048);
    
BEGIN
-- using hash SHA-1 algorithm

-- Encrypt
DBMS_OUTPUT.PUT_LINE ('Input string: '||INPUT_STRING);
DBMS_OUTPUT.PUT_LINE ('Hashing ....');



ENCRYPTED_RAW :=dbms_crypto.hash(
    src => raw_input,
    typ => dbms_crypto.hash_sh1
);


DBMS_OUTPUT.PUT_LINE ('Hashed ret: '||ENCRYPTED_RAW);
DBMS_OUTPUT.PUT_LINE ('Hashed raw ret: '||utl_raw.cast_to_raw(ENCRYPTED_RAW));
DBMS_OUTPUT.PUT_LINE ('Hashed hex ret: '||rawtohex(utl_raw.cast_to_raw(ENCRYPTED_RAW)));

END;
/
