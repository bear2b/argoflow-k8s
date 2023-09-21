DROP DICTIONARY IF EXISTS wizeflow.dict_smartlinks;

CREATE DICTIONARY wizeflow.dict_smartlinks (`_id` String IS_OBJECT_ID, `title` String) 
PRIMARY KEY _id 
SOURCE(MONGODB(HOST 'mongo-service' PORT 27017 USER '' PASSWORD '' DB 'creator' COLLECTION 'documents' OPTIONS 'connectTimeoutMS=10000')) 
LIFETIME(MIN 60 MAX 60) 
LAYOUT(COMPLEX_KEY_HASHED());