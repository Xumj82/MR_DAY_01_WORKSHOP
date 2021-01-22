/* write your SQL and answers */
/* Execution of various SQL commands based on Autism dataset: */

/*     How many middle eastern children show ASD traits ? */
SELECT count(*) FROM Toddler_Autism_dataset where Ethnicity = 'middle eastern' AND [Class/ASDTraits]='Yes';
/*  result: 96 */  

/*     How many children who have Jaundice show ASD traits ? */
SELECT count(*) FROM Toddler_Autism_dataset where Jaundice = 'yes' AND [Class/ASDTraits]='Yes';
/*  reslut: 215 */

/*     Are ASD traits dependent on hereditary ? Justify . */
SELECT (SELECT (SELECT count(*) FROM Toddler_Autism_dataset 
WHERE Family_mem_with_ASD='no' AND [Class/ASDTraits]='Yes')*1.0/(
SELECT count(*) from Toddler_Autism_dataset WHERE Family_mem_with_ASD='no')) 
AS 'ASD proportion in family member without ASD',
(SELECT (SELECT count(*) FROM Toddler_Autism_dataset 
WHERE Family_mem_with_ASD='yes' AND [Class/ASDTraits]='Yes')*1.0/(
SELECT count(*) from Toddler_Autism_dataset WHERE Family_mem_with_ASD='yes'))
AS 'ASD proportion in family member with ASD';
/*  both are around 0.7, so the answer is ASD traits is NOT dependent on hereditary */

/*     People of which ethnicity are most likely to exhibit ASD traits ? */
SELECT  
A.Ethnicity,A.Amount as ASD_Amount, 
B.Amount AS Total_Amount, 
A.Amount*1.0/B.Amount AS  Proportion 
FROM(SELECT Ethnicity,count(*) As Amount
FROM Toddler_Autism_dataset  WHERE [Class/ASDTraits]='Yes'
GROUP by Ethnicity
) as A
LEFT JOIN (
SELECT Ethnicity,count(*) As Amount
FROM Toddler_Autism_dataset 
GROUP by Ethnicity
) as B 
on A.Ethnicity = B.Ethnicity
ORDER BY Proportion  DESC;
/*  based on the result, Native Indian will be the ethnicity are most likely to exhibit ASD traits,  */
/*  but if considerring the sample size, White European should be the ethnicity are most likely to exhibit ASD traits    */

/*     What is the proportion of a white European girls (female) exhibit ASD traits among all white European girls? */
SELECT  
A.Ethnicity,A.Amount as ASD_Amount, 
B.Amount AS Total_Amount, 
A.Amount*1.0/B.Amount AS  Proportion 
FROM(SELECT Ethnicity,count(*) As Amount
FROM Toddler_Autism_dataset  WHERE [Class/ASDTraits]='Yes' 
AND Ethnicity = 'White European' 
AND Sex = 'f'
GROUP by Ethnicity
) as A
LEFT JOIN (
SELECT Ethnicity,count(*) As Amount
FROM Toddler_Autism_dataset  WHERE  Ethnicity = 'White European' 
AND Sex = 'f'
GROUP by Ethnicity
) as B 
on A.Ethnicity = B.Ethnicity;
/*  result : 0.691489361702128  */


