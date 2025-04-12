# Tree Node 문제 / 이전에도 풀어봤음
# 이해 O / 직풀 O
WITH key_table AS
(
SELECT 
    A.id,
    A.p_id,
    B.id AS leaf_id,
    B.p_id AS leaf_p_id
FROM Tree AS A
LEFT JOIN Tree AS B ON A.id = B.p_id
)
SELECT
    DISTINCT id,
    CASE WHEN p_id IS NULL THEN 'Root'
         WHEN leaf_id IS NULL THEN 'Leaf'
         WHEN p_id IS NOT NULL AND leaf_id IS NOT NULL THEN 'Inner'
    END AS 'type'
FROM key_table
