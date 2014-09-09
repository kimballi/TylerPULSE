---Pulls a list of courses and the date the teacher last updated.

SELECT Course
      ,section
      ,School
      ,title
      ,Teacher
      ,SUM(Students) AS Students
      ,MAX(schoolid) AS schoolid
      ,MAX(Period) AS Period
      ,MAX(GradeChange) AS GradeChange
      ,MAX(Diff14) AS Diff14
      ,MAX(Diff7) AS Diff7
        
FROM
  (

SELECT ZZ_TEST_SISRosters.course AS Course
,ZZ_TEST_SISRosters.coursesection AS section
,ZZ_TEST_SISRosters.site AS School
,zz_test_sisclasses.title AS Title
,ZZ_TEST_SISTeachers.TeacherLastName+', '+ZZ_TEST_SISTeachers.TeacherFirstName AS Teacher
,Students=1
,CASE WHEN ZZ_TEST_sisclasses.site='RH' THEN 1050 ELSE --I wanted to have the DESE ID instead
 CASE WHEN ZZ_TEST_sisclasses.site='SA' THEN 1020 ELSE 
 CASE WHEN ZZ_TEST_sisclasses.site='RM' THEN 3000 ELSE 
 CASE WHEN ZZ_TEST_sisclasses.site='CM' THEN 3020 ELSE 
 CASE WHEN ZZ_TEST_sisclasses.site='SM' THEN 3010 ELSE 
 CASE WHEN ZZ_TEST_sisclasses.site='SH' THEN 1075 ELSE NULL END END END END END END as schoolid
,ZZ_TEST_SISRosters.Period AS Period
,ZZ_TEST_GRGradesLastUpdated.GradeChange AS GradeChange
,CASE WHEN ZZ_TEST_GRGradesLastUpdated.Diff14 IS NULL THEN 'Not Updated' ELSE '' END AS Diff14
,CASE WHEN ZZ_TEST_GRGradesLastUpdated.Diff7 IS NULL THEN 'Not Updated' ELSE '' END AS Diff7

FROM ZZ_TEST_SISRosters     
LEFT OUTER JOIN ZZ_TEST_SISClasses ON ZZ_TEST_SISClasses.courseSECTION=ZZ_TEST_SISRosters.courseSECTION AND ZZ_TEST_SISClasses.SITE=ZZ_TEST_SISRosters.SITE 
JOIN ZZ_TEST_SISTeachers ON ZZ_TEST_SISTeachers.TeacherID=ZZ_TEST_SISClasses.TeacherID
Left JOIN ZZ_TEST_GRGradesLastUpdated ON ZZ_TEST_GRGradesLastUpdated.Subject+ZZ_TEST_GRGradesLastUpdated.Section=ZZ_TEST_SISRosters.courseSECTION AND ZZ_TEST_GRGradesLastUpdated.TeacherID=ZZ_TEST_SISTeachers.TeacherID
WHERE ZZ_TEST_SISRosters.course NOT LIKE '%S' and ZZ_TEST_SISRosters.course NOT LIKE '%C' --We don't want to include these courses since they are not graded

 
) AS SQ1
  
  GROUP BY Course, section,School, Title,Teacher
  ORDER BY Teacher, period