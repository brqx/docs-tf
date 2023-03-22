aws dynamodb scan \
    --table-name mitabla \
    --region eu-west-1 \
    --filter-expression "id = :id" \
    --expression-attribute-values file://expression-attribute-values.json

#    --projection-expression "#AA, #BB" \
#    --expression-attribute-names file://expression-attribute-names.json \
