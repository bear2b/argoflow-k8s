CREATE DICTIONARY dict_smartlinks
(
    _id String IS_OBJECT_ID,
    title String
)
PRIMARY KEY _id
SOURCE(MONGODB(
    host 'mongo-service'
    port 27017
    user ''
    password ''
    db 'creator'
    collection 'documents'
))
LIFETIME(MIN 60 MAX 60)
LAYOUT(COMPLEX_KEY_HASHED());