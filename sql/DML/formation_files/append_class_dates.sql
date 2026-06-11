INSERT INTO
    classdates (ClassRecNum, ClassDate)
SELECT TRIM(REClassDate.ClassRecNum), TRIM(REClassDate.ClassDate)
FROM REClassDate
WHERE
    REClassDate.ClassMeets = 'TRUE';