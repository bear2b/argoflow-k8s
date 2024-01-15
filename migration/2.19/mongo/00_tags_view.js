db = connect('mongodb://localhost/creator');
db.runCommand({
  "create": "tag_by_rating_view",
  "viewOn": "project",
  "pipeline": [
    {
      "$unwind": {
        "path": "$tags",
        "preserveNullAndEmptyArrays": false
      }
    },
    {
      "$project": {
        "_id": 0,
        "_project_id": "$_id",
        "_tag_id": {
          "$toObjectId": "$tags"
        }
      }
    },
    {
      "$group": {
        "_id": "$_tag_id",
        "_project_ids": {
          "$push": "$_project_id"
        }
      }
    },
    {
      "$project": {
        "_id": "$_id",
        "project_count": {
          "$size": "$_project_ids"
        }
      }
    },
    {
      "$lookup": {
        "from": "tag",
        "localField": "_id",
        "foreignField": "_id",
        "as": "tag_data"
      }
    },
    {
      "$unwind": {
        "path": "$tag_data",
        "preserveNullAndEmptyArrays": false
      }
    },
    {
      "$project": {
        "_id": "$_id",
        "name": "$tag_data.name",
        "organizationId": "$tag_data.organizationId",
        "insertedAt": "$tag_data.insertedAt",
        "specialSortField": "$project_count"
      }
    }
  ]
});