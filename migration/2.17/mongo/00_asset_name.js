db = connect('mongodb://localhost/creator');
db.auras.aggregate([
  { 
    "$addFields": { 
      "name": "$aura.name"
    }
  },
  { "$out": "auras" }
]);