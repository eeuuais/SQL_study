-- JOIN 방식 : 최대값 동일 시 다수 상품 반환 가능
SELECT P.CATEGORY CATEGORY, max_price.MAX_PRICE MAX_PRICE, P.PRODUCT_NAME PRODUCT_NAME
FROM FOOD_PRODUCT P
JOIN (
    SELECT CATEGORY, MAX(PRICE) AS MAX_PRICE
    FROM FOOD_PRODUCT
    GROUP BY CATEGORY
) max_price ON P.CATEGORY = max_price.CATEGORY 
AND P.PRICE = max_price.MAX_PRICE
WHERE P.CATEGORY IN ('과자','국','김치','식용유')
GROUP BY P.CATEGORY
ORDER BY MAX_PRICE DESC;


-- 서브쿼리 방식 : 최대값 동일 시 최대 1개 상품만 반환. 그룹이 많아질수록 서브쿼리가 반복 실행돼 성능 저하 가능성
SELECT P.CATEGORY,
       MAX(P.PRICE) AS MAX_PRICE,
       (SELECT PRODUCT_NAME 
        FROM FOOD_PRODUCT 
        WHERE CATEGORY = P.CATEGORY 
        ORDER BY PRICE DESC LIMIT 1) AS PRODUCT_NAME
FROM FOOD_PRODUCT P
WHERE CATEGORY IN ('과자', '국', '김치', '식용유')
GROUP BY CATEGORY
ORDER BY MAX_PRICE DESC;