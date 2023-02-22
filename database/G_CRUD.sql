-- 이름 포인트 잔액 뽑아내기
SELECT USER_NAME, POINT
FROM USERS
WHERE EMAIL IN ('user1@gmail.com')
;

-- 회원에 맞는 order uid 뽑아내기
SELECT ORDERS.ORDER_UID
FROM ORDERS
INNER JOIN USERS
ON ORDERS.USER_UID = USERS.USER_UID
WHERE USERS.EMAIL IN ('user1@gmail.com')

;
-- order uid에 맞는  order uid, 주문 날짜, 가격, 주문 상태, 상품명 뽑아내기
(SELECT ORDERS.ORDER_UID, ORDERS.ORDER_DATE, ORDER_DETAILS.PRICE, ORDER_CONDITIONS.CONDITION_NAME,PRODUCTS.PRODUCT_NAME
FROM ORDER_DETAILS
INNER JOIN ORDERS
ON ORDER_DETAILS.ORDER_UID = ORDERS.ORDER_UID
INNER JOIN PRODUCTS
ON ORDER_DETAILS.PRODUCT_UID = PRODUCTS.PRODUCT_UID
INNER JOIN ORDER_CONDITIONS
ON ORDER_DETAILS.ORDER_CONDITION_UID = ORDER_CONDITIONS.ORDER_CONDITION_UID
WHERE ORDERS.ORDER_UID IN ('O1'))
;




SELECT ORDERS.ORDER_DATE, ORDERS.ORDER_UID, PRODUCTS.PRODUCT_NAME, PRODUCTS.PRICE, ORDER_DETAILS.QUANTITY, ORDER_CONDITIONS.CONDITION_NAME, WAYBILLS.WAYBILL_CODE, LOGISTICS.LOGISTICS_NAME
FROM ORDERS
INNER JOIN ORDER_DETAILS ON ORDERS.ORDER_UID = ORDER_DETAILS.ORDER_UID
INNER JOIN PRODUCTS ON PRODUCTS.PRODUCT_UID = ORDER_DETAILS.PRODUCT_UID
INNER JOIN ORDER_CONDITIONS ON ORDER_CONDITIONS.ORDER_CONDITION_UID = ORDER_DETAILS.ORDER_CONDITION_UID
INNER JOIN WAYBILLS ON WAYBILLS.WAYBILL_UID = ORDER_DETAILS.WAYBILL_UID
INNER JOIN LOGISTICS ON LOGISTICS.LOGISTICS_UID = WAYBILLS.LOGISTICS_UID
;


(SELECT ORDERS.ORDER_UID, ORDERS.ORDER_DATE, ORDER_DETAILS.PRICE, ORDER_CONDITIONS.ORDER_CONDITION_UID,ORDER_DETAILS.QUANTITY,PRODUCTS.PRODUCT_NAME
FROM ORDER_DETAILS
INNER JOIN ORDERS
ON ORDER_DETAILS.ORDER_UID = ORDERS.ORDER_UID
INNER JOIN PRODUCTS
ON ORDER_DETAILS.PRODUCT_UID = PRODUCTS.PRODUCT_UID
INNER JOIN ORDER_CONDITIONS
ON ORDER_DETAILS.ORDER_CONDITION_UID = ORDER_CONDITIONS.ORDER_CONDITION_UID
WHERE ORDERS.ORDER_UID IN ('O1'))
;

-- 회원의 주문자 정보 뽑아내기
SELECT USER_NAME, EMAIL, TEL
FROM USERS
WHERE USER_UID = 'U1'
;

-- 주문 고유 아이디에 따른 주소 고유아이디 뽑아내기
SELECT ADDRESS_UID
FROM ORDERS
WHERE ORDER_UID = "O1"
;

-- 배송지 주소 뽑아내기
SELECT 	ORDERS.RECIPIENT_NAME, 
		ORDERS.RECIPIENT_TEL, 
		ADDRESSES.ADDRESS_NAME, 
		ADDRESSES.ZIP_CODE, 
		ADDRESSES.ADDRESS, 
		ADDRESSES.DETAIL
FROM ORDERS
INNER JOIN ADDRESSES
ON ORDERS.ADDRESS_UID = ADDRESSES.ADDRESS_UID
WHERE  ORDERS.ADDRESS_UID IN ('A1')
;

-- 배송지 수정할 값 불러오기
SELECT ORDER_UID
FROM ORDERS
WHERE USER_UID = "U1"
;

SELECT ADDRESS_UID
FROM ORDERS
WHERE ORDER_UID = "O1"
;
-- 배송지 수정
UPDATE ADDRESSES
SET ADDRESS_NAME = '회사', ZIP_CODE="11222",ADDRESS="서울시 강남",DETAIL="11가길",EXPOSURE="YES"
WHERE ADDRESS_UID = "A1"
;

-- 취소 반품 교환  할수 있는내역 출력
SELECT 	ORDERS.ORDER_DATE, 
		ORDER_DETAILS.QUANTITY,
		ORDER_DETAILS.PRICE,
		PRODUCTS.PRODUCT_NAME,
		ORDER_CONDITIONS.CONDITION_NAME
FROM ORDER_DETAILS
INNER JOIN ORDERS
ON ORDERS.ORDER_UID = ORDER_DETAILS.ORDER_UID
INNER JOIN PRODUCTS
ON PRODUCTS.PRODUCT_UID = ORDER_DETAILS.PRODUCT_UID
INNER JOIN ORDER_CONDITIONS
ON ORDER_CONDITIONS.ORDER_CONDITION_UID = ORDER_DETAILS.ORDER_CONDITION_UID
WHERE ORDERS.USER_UID='U1'
;

-- 취소 내역 출력

SELECT CANCELLED_ORDERS.APPLICATION_DATE,PRODUCTS.PRODUCT_NAME,ORDER_CONDITIONS.CONDITION_NAME
FROM ORDER_DETAILS
INNER JOIN CANCELLED_ORDERS
ON CANCELLED_ORDERS.ORDER_DETAIL_UID = ORDER_DETAILS.ORDER_DETAIL_UID
INNER JOIN PRODUCTS
ON PRODUCTS.PRODUCT_UID = ORDER_DETAILS.PRODUCT_UID
INNER JOIN ORDER_CONDITIONS
ON ORDER_CONDITIONS.ORDER_CONDITION_UID = ORDER_DETAILS.ORDER_CONDITION_UID
WHERE ORDER_DETAILS.ORDER_UID IN ('O1')
;


-- 반품(환불) 내역출력
SELECT REFUND_ORDERS.APPLICATION_DATE,PRODUCTS.PRODUCT_NAME,ORDER_CONDITIONS.CONDITION_NAME
FROM ORDER_DETAILS
INNER JOIN REFUND_ORDERS
ON REFUND_ORDERS.ORDER_DETAIL_UID = ORDER_DETAILS.ORDER_DETAIL_UID
INNER JOIN PRODUCTS
ON PRODUCTS.PRODUCT_UID = ORDER_DETAILS.PRODUCT_UID
INNER JOIN ORDER_CONDITIONS
ON ORDER_CONDITIONS.ORDER_CONDITION_UID = ORDER_DETAILS.ORDER_CONDITION_UID
WHERE ORDER_DETAILS.ORDER_UID IN ('O1')
;

-- 교환 내역출력
SELECT EXCHANGE_ORDERS.APPLICATION_DATE,PRODUCTS.PRODUCT_NAME,ORDER_CONDITIONS.CONDITION_NAME
FROM ORDER_DETAILS
INNER JOIN EXCHANGE_ORDERS
ON EXCHANGE_ORDERS.ORDER_DETAIL_UID = ORDER_DETAILS.ORDER_DETAIL_UID
INNER JOIN PRODUCTS
ON PRODUCTS.PRODUCT_UID = ORDER_DETAILS.PRODUCT_UID
INNER JOIN ORDER_CONDITIONS
ON ORDER_CONDITIONS.ORDER_CONDITION_UID = ORDER_DETAILS.ORDER_CONDITION_UID
WHERE ORDER_DETAILS.ORDER_UID IN ('O1')
;

-- 리뷰 쓰지 않은 목록 / 쓴 목록 출력
SELECT COUNT(REVIEWS.REVIEW_UID) AS REVIEW_COUNT
FROM ORDER_DETAILS
INNER JOIN REVIEWS
ON REVIEWS.ORDER_DETAIL_UID=ORDER_DETAILS.ORDER_DETAIL_UID
WHERE ORDER_DETAILS.ORDER_UID IN ('O1')
;

SELECT ORDERS.ORDER_DATE, PRODUCTS.PRODUCT_NAME
FROM ORDER_DETAILS
INNER JOIN PRODUCTS
ON PRODUCTS.PRODUCT_UID = ORDER_DETAILS.PRODUCT_UID
INNER JOIN ORDERS
ON ORDERS.ORDER_UID = ORDER_DETAILS.ORDER_UID
WHERE ORDER_DETAILS.ORDER_UID IN ('O1')
;

-- 리뷰 작성
INSERT INTO REVIEWS (REVIEW_UID, PRODUCT_UID, RATING, CONTENT,CREATE_DATE,ORDER_DETAIL_UID)
VALUE ('R1','P1',5,'가방이 튼튼하고 좋아요',sysdate(),'OD1')
;

-- 리뷰 수정
SELECT PRODUCTS.PRODUCT_NAME, REVIEWS.RATING,REVIEWS.CONTENT, REVIEWS.CREATE_DATE,REVIEWS.ORDER_DETAIL_UID
FROM REVIEWS
INNER JOIN PRODUCTS
ON PRODUCTS.PRODUCT_UID = REVIEWS.PRODUCT_UID
WHERE REVIEWS.REVIEW_UID IN ('R1')
;
 
UPDATE REVIEWS
SET RATING='5', 
	CONTENT='좋아용', 
	CREATE_DATE = sysdate()
WHERE REVIEWS.REVIEW_UID IN ('R1')
;

-- 리뷰 삭제
DELETE FROM REVIEWS
WHERE REVIEW_UID IN ("R1")
;


-- 1:1 문의 등록
INSERT INTO PRIVATE_INQUIRIES (PRIVATE_INQUIRY_UID,USER_UID,INQUIRY_CATEGORY_UID,TITLE,CONTENT,CREATE_DATE)
VALUE ("PI1","U1","IC1", "배송이 늦어요","배송이 너무 늦습니다",sysdate())
;

-- 1:1 문의 수정
UPDATE PRIVATE_INQUIRIES 
SET INQUIRY_CATEGORY_UID = "IC2",  TITLE="배송", CONTENT="배송이..늦어요...",CREATE_DATE=sysdate()
;

-- 1:1 문의 삭제
DELETE FROM PRIVATE_INQUIRIES
WHERE PRIVATE_INQUIRY_UID IN ("PI1")
;

-- 1:1 문의 리스트 출력
SELECT 	PRIVATE_INQUIRIES.TITLE, 
		PRIVATE_INQUIRIES.CREATE_DATE, 
        INQUIRY_CATEGORIES.CATEGORY_NAME, 
        PRIVATE_INQUIRY_ANSWERS.CREATE_DATE
FROM PRIVATE_INQUIRIES
INNER JOIN INQUIRY_CATEGORIES
ON INQUIRY_CATEGORIES.INQUIRY_CATEGORY_UID = PRIVATE_INQUIRIES.INQUIRY_CATEGORY_UID
INNER JOIN PRIVATE_INQUIRY_ANSWERS
ON PRIVATE_INQUIRY_ANSWERS.PRIVATE_INQUIRY_UID= PRIVATE_INQUIRIES.PRIVATE_INQUIRY_UID
WHERE PRIVATE_INQUIRIES.USER_UID IN ("U1")
;

-- 1:1 답변 등록
INSERT INTO PRIVATE_INQUIRY_ANSWERS (PRIVATE_INQUIRY_ANSWER_UID,PRIVATE_INQUIRY_UID,ADMIN_UID,CONTENT,CREATE_DATE)
VALUE ('PIA1','PI1','AD1','늦어서 죄송합니다 곧 발송될 예정입니다',sysdate())
;

-- 1:1 답변 수정 

UPDATE PRIVATE_INQUIRY_ANSWERS
SET CONTENT="답변 수정",CREATE_DATE= sysdate()
WHERE PRIVATE_INQUIRY_ANSWER_UID IN ("PIA1")
;

-- 1:1 답변 출력
SELECT 	PRIVATE_INQUIRIES.TITLE,
		PRIVATE_INQUIRIES.CONTENT,
        PRIVATE_INQUIRIES.CREATE_DATE,
        PRIVATE_INQUIRY_ANSWERS.CONTENT,
        PRIVATE_INQUIRY_ANSWERS.CREATE_DATE
FROM PRIVATE_INQUIRY_ANSWERS
INNER JOIN PRIVATE_INQUIRIES
ON PRIVATE_INQUIRY_ANSWERS.PRIVATE_INQUIRY_UID = PRIVATE_INQUIRIES.PRIVATE_INQUIRY_UID
WHERE PRIVATE_INQUIRIES.PRIVATE_INQUIRY_UID IN ('PI1')
;


-- 회원 정보 수정 시 값 출력
SELECT 	EMAIL,
		USER_NAME,
		TEL
FROM USERS
INNER JOIN ADDRESSES
ON ADDRESSES.USER_UID = USERS.USER_UID
WHERE USERS.USER_UID = "U1"
;


SELECT  ADDRESS_UID,
		ADDRESS_NAME,
        ZIP_CODE,
		ADDRESS
        DETAIL,
		EXPOSURE
FROM ADDRESSES
WHERE 	USER_UID IN ("U1")
AND		ADDRESS_NAME IN ("BASIC")
;

-- 회원 정보 수정
UPDATE USERS, ADDRESSES
	SET USERS.TEL="01012341234",
		ADDRESSES.ADDRESS_NAME="기본",
		ADDRESSES.ZIP_CODE = "11234",
		ADDRESSES.ADDRESS = "서울시",
		ADDRESSES.DETAIL="강남",
		ADDRESSES.EXPOSURE="YES"
	WHERE USERS.USER_UID IN ("U1")
    AND ADDRESSES.ADDRESS_UID IN ("A1")
;


-- 회원 비밀번호 변경시 비밀번호 추출 / 변경
SELECT PASSWORD
FROM USERS
WHERE USER_UID="U1"
;
UPDATE USERS
SET PASSWORD = "password1233"
;

-- 회원 탈퇴
DELETE FROM USERS
WHERE USER_UID IN ("U1")
;

UPDATE USERS 
SET USER_UID = "U1",
	USER_CONDITION_UID = 'UC2' 
WHERE USER_UID IN ("U1")
;

-- 유저 로그인
SELECT *
FROM USERS 
WHERE 1 = 1
AND	EMAIL IN ("user10@gmail.com")
AND USER_CONDITION_UID IN ("UC1")
; 





