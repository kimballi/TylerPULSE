SELECT Teacher, title, period, gradechange, schoolid
FROM ZZ_TEST_C2_GradeLastUpdated
WHERE diff14='Not Updated'
      AND Schoolid = *SchoolNbr*      --Match on School
      AND title NOT LIKE '%Advisory%' --Remove Subjects with this title
      AND title NOT LIKE '%Teacher Aide%'
      AND title NOT LIKE '%Nova%'
      AND title NOT LIKE '%Summit%'
      AND title NOT LIKE '%A+ Seminar%'
      AND Course NOT LIKE '%S'        --Remove Subjects that end in S
      AND Course NOT LIKE '%C'
ORDER BY Teacher, period