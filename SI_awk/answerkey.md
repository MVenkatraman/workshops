# SI awk workshop answer key

### Exercise 1
Extract the ref alleles and alt alleles separately and save them as alt.txt and ref.txt  
Use the file noheader.vcf. It is sample.vcf without the header

`cut -f 4 noheader.vcf > ref.txt`  
`cut -f 5 noheader.vcf > alt.txt`

### Exercise 2
Sort noheader.vcf by ID first and then by reference allele and name it sorted.vcf.

`sort -k3,3 -k4,4 sample.vcf > sorted.vcf`

### Exercise 3
How many lines in sample.vcf do not have IDs that start with rs18?    
**905**

`grep -v "#" sample.vcf | grep -v "rs18" | wc -l`


### Exercise 4
How many lines in sample.vcf have the reference allele A?  
**228**  

`grep -v "#" sample.vcf | cut -f 4 | grep "A" | wc -l`

### Exercise 5
Count the number of variant sites in sample.vcf   
**944**    

`awk '$1 !~ "#" {print $1}' sample.vcf | wc -l`

### Exercise 6
Extract all the data for sites that start after 4899444 and are on the negative strand from t_gutatta.bed  

`awk '$6 == "-" && $2 > 4899444 {print $0}' t_guttata.bed`  

### Exercise 7  

Extract all the sequences that blasted to Eukaryota. Print their names, evalue and score.

`awk '$2 == "Eukaryota" {print $3,$4,$5}' blast.txt`

Count the number of hits that have a score of less that 80  
**321**

`awk '$5 < 80 {print $1}' blast.txt | wc -l `  

What is the highest score of the sequences that map to zebra finch?  
**99.7**

`awk '$3 == "zebrafinch" {print $5}' blast.txt | sort | tail -1`  

### Exercise 8
Replace zebrafinch with t.guttata in blast.txt. Save it as zebchange.txt and then print every other line.  

`sed 's/zebrafinch/t.guttata/g' blast.txt > zebchange.txt`  

`sed -n 'n;p' blast.txt`
