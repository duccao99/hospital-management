---- BLOB : Binary large object
--
--
-- create a table for BLOB column
 -- drop TABLE table_lob;

CREATE TABLE table_lob(id number, loc blob);

-- insert 3 empty lobs for src/enc/dec
insert into table_lob values (1,EMPTY_BLOB());
insert into table_lob values (2,EMPTY_BLOB());
insert into table_lob values (3,EMPTY_BLOB());

set echo on;
SET SERVEROUTPUT ON SIZE 30000;

DECLARE 
    src_data RAW(1000);
    
    src_blob BLOB;
    encryp_blob BLOB;
    
    encryp_raw RAW(1000);
    encryp_raw_len BINARY_INTEGER;
    
    decryp_blob BLOB;
    decryp_raw RAW(1000);
    decryp_raw_len BINARY_INTEGER;
    
    leng  INTEGER;    
BEGIN 
    -- RAW input data 16 bytes
    src_data:=hextoraw('6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D6D');
    
    dbms_output.put_line('-----');
    dbms_output.put_line('Input is: '||src_data);
    dbms_output.put_line('-----');

     -- select empty lob locators for src/enc/dec
     select loc into src_blob from table_lob where id=1;
     select loc into encryp_blob from table_lob where id=2;
     select loc into decryp_blob from table_lob where id=3;
     
     
    dbms_output.put_line('Created Empty LOBS');
    dbms_output.put_line('----');

    
    leng:=DBMS_LOB.GETLENGTH(src_blob);
     
     IF leng IS NULL THEN
        dbms_output.put_line('Source BLOB Len NULL ');       
     ELSE
        dbms_output.put_line('Source BLOB Len ' || leng);
     END IF;
     
     leng:=DBMS_LOB.GETLENGTH(encryp_blob);
     IF leng IS NULL THEN
        dbms_output.put_line('Encrypt BLOB Len is NULL');
    ELSE
                dbms_output.put_line('Encrypt BLOB Len is '||leng);

     END IF;
     
     leng:=DBMS_LOB.GETLENGTH(decryp_blob);
     
     IF leng IS NULL THEN
    dbms_output.put_line('Decrypt BLOB Len is NULL');
    ELSE
        dbms_output.put_line('Decrypt BLOB Len is '||leng);
    END IF;
-- write source raw data into blob
    
    DBMS_LOB.OPEN(src_blob,dbms_lob.lob_readwrite);
    DBMS_LOB.WRITEAPPEND(src_blob,16,src_data);
    DBMS_LOB.CLOSE(src_blob);    
    
     dbms_output.put_line('Source raw data written to source blob');
 dbms_output.put_line('---');
 
    leng:=dbms_lob.getlength(src_blob);
    IF leng IS NULL THEN
    dbms_output.put_line('Src BLOB Len is NULL');
    ELSE
        dbms_output.put_line('Src BLOB Len is '||leng);
    END IF;
    


     
     
     /*
 * Procedure Encrypt
 * Arguments: srcblob -> Source BLOB
 * encrypblob -> Output BLOB for encrypted data
 * DBMS_CRYPTO.AES_CBC_PKCS5 -> Algo : AES
 * Chaining : CBC
 * Padding : PKCS5
 * 256 bit key for AES passed as RAW
 * ->

hextoraw('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F')
 * IV (Initialization Vector) for AES algo passed as RAW
 * -> hextoraw('00000000000000000000000000000000')
 */
     dbms_crypto.encrypt(
        encryp_blob,
         src_blob   ,
        dbms_crypto.AES_CBC_PKCS5,
        hextoraw('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F'),
        hextoraw('00000000000000000000000000000000')
     );
     dbms_output.put_line('Encryption Done');
 dbms_output.put_line('---');

    leng := DBMS_LOB.GETLENGTH(encryp_blob); 
 IF leng IS NULL THEN
 dbms_output.put_line('Encrypt BLOB Len NULL');
 ELSE
 dbms_output.put_line('Encrypt BLOB Len ' || leng);
 END IF;

-- Read encrypblob to a raw
encryp_raw_len := 999;

dbms_lob.open(encryp_blob,dbms_lob.lob_readwrite);
dbms_lob.read(encryp_blob,encryp_raw_len,1,encryp_raw);
dbms_lob.close(encryp_blob);



dbms_output.put_line('Read encrypt blob to a raw');
 dbms_output.put_line('---');
 
 dbms_output.put_line('Encrypted data is (256 bit key) ' || encryp_raw);
 dbms_output.put_line('---');
 
 
 /*
 * Procedure Decrypt
 * Arguments: encrypblob -> Encrypted BLOB to decrypt
  * decrypblob -> Output BLOB for decrypted data in RAW
 * DBMS_CRYPTO.AES_CBC_PKCS5 -> Algo : AES
 * Chaining : CBC
 * Padding : PKCS5
 * 256 bit key for AES passed as RAW (same as used during
Encrypt)
 * ->

hextoraw('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F')
 * IV (Initialization Vector) for AES algo passed as RAW (same
as
 used during Encrypt)
 * -> hextoraw('00000000000000000000000000000000')
 */
 
 dbms_crypto.decrypt(decryp_blob,encryp_blob,dbms_crypto.AES_CBC_PKCS5,
 ('000102030405060708090A0B0C0D0E0F101112131415161718191A1B1C1D1E1F'),
 hextoraw('00000000000000000000000000000000'));


leng:=dbms_lob.getlength(decryp_blob);
IF leng IS NULL THEN
 dbms_output.put_line('Decrypt BLOB Len NULL');
 ELSE
 dbms_output.put_line('Decrypt BLOB Len ' || leng);
 END IF;
-- Read decrypblob to a raw
 decryp_raw_len := 999;
 
 dbms_lob.open(decryp_blob,dbms_lob.lob_readwrite);
  dbms_lob.read(decryp_blob,decryp_raw_len,1,decryp_raw);
 dbms_lob.close(decryp_blob);
 
 dbms_output.put_line('Decrypted data is (256 bit key) ' || decryp_raw);
 dbms_output.put_line('---');


 dbms_lob.open(src_blob,dbms_lob.lob_readwrite);
 dbms_lob.trim(src_blob,0);
 dbms_lob.close(src_blob);
 
dbms_lob.open(encryp_blob,dbms_lob.lob_readwrite);
 dbms_lob.trim(encryp_blob,0);
 dbms_lob.close(encryp_blob);
 
 
 dbms_lob.open(decryp_blob,dbms_lob.lob_readwrite);
 dbms_lob.trim(decryp_blob,0);
 dbms_lob.close(decryp_blob);

END;
/






