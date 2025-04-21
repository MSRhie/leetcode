# contract 테이블은 각 고객 신용에 대한 정보가 포함됨. 이 정보는 Customers 테이블에 있을수도, 없을수도 있음
# 1) invoice와 관련된고객 이름 출력
# 2) invoice 가격 출력
# 3) 고객과 관련된 연락 정보 수 출력
# 4) customers 테이블에 이메일이 존재해야 함.(고객과 그들이 샵의 고객임과 관련있는 연락 수)
# 5) invoice_id로 오름차순 정렬

WITH data AS
(
SELECT
    A.user_id,
    A.invoice_id,
    A.price,
    COUNT(B.contact_name) AS contacts_cnt,
    COUNT(C.customer_name) AS trusted_contacts_cnt
FROM Invoices AS A
LEFT JOIN Contacts AS B ON A.user_id = B.user_id
LEFT JOIN Customers AS C ON B.contact_name = C.customer_name
GROUP BY invoice_id
ORDER BY invoice_id
)
SELECT
    DISTINCT
    invoice_id,
    customer_name,
    price,
    contacts_cnt,
    trusted_contacts_cnt
FROM data AS A
LEFT JOIN Customers AS B ON A.user_id = B.customer_id



