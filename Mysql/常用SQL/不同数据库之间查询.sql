
#查询数据库中所有表名
SELECT table_name FROM information_schema.tables WHERE table_schema = '数据库名' AND table_type = 'base table' ;

#查询指定数据库中指定表的所有字段名column_name
SELECT column_name FROM information_schema.columns WHERE table_schema='数据库名' AND table_name='表名';

#查询A数据库中比B多的数据表
SELECT table_name AS need_table  FROM information_schema.tables WHERE table_schema='A' AND table_type='base table' AND table_name NOT IN
(
   SELECT table_name FROM information_schema.tables WHERE table_schema='B' AND table_type='base table' 
);

#缺失表查询
#查询z_testocean数据库中比z_testocean_copy多的数据表
SELECT table_name FROM information_schema.tables WHERE table_schema='z_testocean' AND table_type='base table' AND table_name NOT IN
(
   SELECT table_name FROM information_schema.tables WHERE table_schema='z_testocean_copy' AND table_type='base table' 
);

#查询不同数据库相同表名的描述不同
SELECT * FROM 
        (
        SELECT TABLE_NAME, TABLE_COMMENT FROM information_schema.tables WHERE table_schema='A' AND table_type='base table'
        ) a
	INNER JOIN
	(
	SELECT TABLE_NAME, TABLE_COMMENT FROM information_schema.tables WHERE table_schema='B' AND table_type='base table'
	) b ON a.TABLE_NAME=b.TABLE_NAME
	WHERE a.TABLE_COMMENT!=b.TABLE_COMMENT;
	
	
#查询具体表缺失字段语句：
#查询A下table_1中比B下table_1多的字段
SELECT column_name FROM information_schema.columns WHERE table_schema='A' AND table_name='table_1' 
    AND column_name NOT IN (
      SELECT column_name FROM information_schema.columns WHERE table_schema='B' AND table_name='table_1' 
    ) ;
    
#查询A、B不同数据库下相同表中不同的字段长度不相等的
#查询不同数据库下相同表中不同的字段()
SELECT * FROM 
        (
        SELECT TABLE_NAME, COUNT(*) AS num FROM information_schema.COLUMNS WHERE table_schema='A'  GROUP BY  TABLE_NAME
        ) a
	INNER JOIN
	(
	SELECT TABLE_NAME, COUNT(*) AS num  FROM information_schema.COLUMNS WHERE table_schema='B'  GROUP BY  TABLE_NAME
	) b ON a.TABLE_NAME=b.TABLE_NAME
	WHERE a.num!=b.num;

    
#添加A数据库比B数据库多的表
# 改为存储过程实现 ，查询A数据库中比B多的数据表 
 