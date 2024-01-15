db = connect('mongodb://localhost/creator');
db.member.updateMany({created: null}, {$set:{created: ISODate("2021-01-01T00:00:00.270Z")}});
db.organization.updateMany({created: null}, {$set:{created: ISODate("2021-01-01T00:00:00.270Z")}});