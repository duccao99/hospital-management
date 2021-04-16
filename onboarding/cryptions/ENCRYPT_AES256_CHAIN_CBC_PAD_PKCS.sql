SET SERVEROUTPUT ON SIZE 30000;

DECLARE 
    input_string VARCHAR(200):='Secret message';
    output_string VARCHAR(200);
    
    encrypted_raw RAW(2000);
    decrypted_raw RAW(2000);
    
    num_key_bytes NUMBER:=256/8;
    key_bytes_raw RAW(32);
    
    encryption_type PLS_INTEGER:=
    DBMS_CRYPTO.ENCRYPT_AES256+
    DBMS_CRYPTO.CHAIN_CBC+
    DBMS_CRYPTO.PAD_PKCS5;
BEGIN
    DBMS_OUTPUT.PUT_LINE('> Original string: '||input_string);
    key_bytes_raw:=DBMS_CRYPTO.RANDOMBYTES(num_key_bytes);
    
    encrypted_raw:=DBMS_CRYPTO.ENCRYPT(
        src => UTL_I18N.STRING_TO_RAW (input_string,'AL32UTF8'),
        typ =>  encryption_type,
        key =>  key_bytes_raw
    );
    
    dbms_output.put_line('> Encrypted ret: '||encrypted_raw);
    
     -- The encrypted value in the encrypted_raw variable can be used here
    decrypted_raw   :=DBMS_CRYPTO.DECRYPT(
        src => encrypted_raw,
        typ =>  encryption_type,
        key =>key_bytes_raw
    );

    dbms_output.put_line('> Decrypted ret: '||decrypted_raw);
    
    output_string:=UTL_I18N.RAW_TO_CHAR(decrypted_raw,'AL32UTF8');
    
    dbms_output.put_line('> Decrypted string ret: '||output_string);

END;
/