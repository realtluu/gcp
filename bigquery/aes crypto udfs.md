```python
from Crypto.Cipher import AES
import base64
from datetime import datetime

BLOCK_SIZE = 16
KEY = '0000000000000000'
IV = '0000000000000000'
ENCODE = 'utf-8'

pad = lambda s: bytes(s + (BLOCK_SIZE - len(s) % BLOCK_SIZE) * chr(BLOCK_SIZE - len(s) % BLOCK_SIZE), 'utf-8')
unpad = lambda s : s[:-ord(s[-1:])]

def create_encrypt(text):
    cipher = AES.new(bytes(KEY, ENCODE), AES.MODE_CBC, bytes(IV, ENCODE))
    encrypted_text = base64.standard_b64encode(cipher.encrypt(pad(text))).decode(ENCODE)
    return encrypted_text


def create_decrypt(text):
    cipher = AES.new(bytes(KEY, ENCODE), AES.MODE_CBC, bytes(IV, ENCODE))
    decrypted_text = unpad(cipher.decrypt(base64.standard_b64decode(text.encode(ENCODE)))).decode(ENCODE)
    return decrypted_text
```


```python
text = 'Hello world'
encrypted_text = create_encrypt(text)
decrypted_text = create_decrypt(encrypted_text)


print('Source: {}'.format(text))
print('Encrypted_text: {}'.format(encrypted_text))
print('Eecrypted_text: {}'.format(decrypted_text))
```

    Source: Hello world
    Encrypted_text: JybEV1ddAKM+LdejJ6bAGQ==
    Eecrypted_text: Hello world
    

## Bigquery UDFs

```javascript
create temporary function create_encrypt(text string) returns string language js as
"""
const key = '0000000000000000';
const iv = '0000000000000000';

var encrypted = CryptoJS.AES.encrypt(text, 
    CryptoJS.enc.Utf8.parse(key), 
    {
        iv: CryptoJS.enc.Utf8.parse(iv),
        padding: CryptoJS.pad.Pkcs7,
        mode: CryptoJS.mode.CBC
    }
);

return encrypted.toString();
""";

create temporary function create_decrypt(text string) returns string language js as
"""
const key = '0000000000000000';
const iv = '0000000000000000';

var decrypted = CryptoJS.AES.decrypt(text, 
    CryptoJS.enc.Utf8.parse(key), 
    {
        iv: CryptoJS.enc.Utf8.parse(iv),
        padding: CryptoJS.pad.Pkcs7,
        mode: CryptoJS.mode.CBC
    }
);

return decrypted.toString(CryptoJS.enc.Utf8);
"""
options (library="gs://bq_liblary/crypto-js.js");

select
  'Hello world' as text
  , create_encrypt('Hello world') as encrypted_text
  , create_decrypt(create_encrypt('Hello world')) as decrypted_text
```

## Return:

|Row|text|encrypted_text|decrypted_text|
|-|-|-|-|
|1|Hello|ZkeNEgsUXi1J7ps6kCQxdQ==|Hello world|


```python

```
