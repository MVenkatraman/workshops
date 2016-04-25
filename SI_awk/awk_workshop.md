# Command Line Data Manipulation
### Intro to grep, awk, etc.
#### Smithsonian CCEG
April 26th, 2016

*In this workshop we are focusing unix systems*

## Basic Command Line Data Manipulation

Before we get into more complicated and specific tools for data manipulation we will go over some tools available in the unix command line.

Download all the data:

`wget https://github.com/MVenkatraman/workshops/tree/master/SI_awk/data`

*We will be using a VCF file in this portion called sample.vcf*

This is what a vcf file looks like:
![picture alt](https://bioinf.comav.upv.es/courses/sequence_analysis/_images/vcf_format.png "from bioinf.comav.upv.es")

## 1. cutting, sorting and all that jazz

These are a few simple and useful tools for data visualization and manipulation

### cut
This tool helps you 'cut out' certain parts of your data, depending on the flag you give it.

-d: delimiter: tells cut what delimiter you want to use. The default is tab.
-f: fields: what you're trying to extract

We want to extract the alternative alleles from our vcf files:

`cut -f 5 sample.vcf | tail`
* we don't have to specify the delimiter b/c its by column or by tabs
* the alternative alleles are in column 5
* we are piping into tail b/c the first few lines are comment headers and we don't want to see that

**what if we want multiple columns:**

`cut -f 4,5 sample.vcf | tail`

or

`cut -f 3-5 sample.vcf | tail`

#### Exercise 1

Extract the ref alleles and alt alleles separately and save them as alt.txt and ref.txt   
Use the file noheader.vcf. It is sample.vcf without the header  

### paste

Now that we have cut up the file, lets put it back together.

`paste ref.txt alt.txt > alleles.txt`

Check out the new file:  

`head alleles.txt`

### sort

Sorting files can be useful, so let's do that. Sort has **a lot** of options. I'm just going to show you how to do some basic sorting. But check out unix documentation for all your sorting needs.  

Let's just sort by ID first:

`sort -k 3 noheader.vcf | head`  
*k or key value indicates the position to start sorting at*

**What if we want to sort by two columns?**

`sort -k3,3 -k2,2 noheader.vcf`  
*this will sort by column 3 first and column 2 second. This syntax is important*

**Let's sort in reverse now**

`sort -k 3 -r noheader.vcf`

#### Exercise 2

Sort noheader.vcf by format first and then by ID and name it sorted.vcf.

_____________
## 2. grep

grep is an **amazing** search tool in unix systems. Learning to use grep can save you a lot of time and headaches. Simply put, grep searches for patterns and then extracts the line association with that pattern. I've tried to include some useful grep flags in this tutorial but there is much more! So, checkout the documentation if you don't see what you need here.

grep works with regular expressions. regexs are extremely useful and worth checking out if you are not familiar.  

Let's start with the simplest grep, finding a line with something. Let's say we want all the sites with alt alleles A and T:  

`grep "A,T" sample.vcf`

We want to make sure we didnt miss anything in lowercase so we add the following flag to ignore case:

`grep -i "A,T" sample.vcf`

Now, i just want to know how many lines match this pattern:

`grep -c "A,T" sample.vcf`

**Now, I want all the lines that don't match this pattern**

`grep -v "A,T" sample.vcf | tail`

#### Exercise 3

How many lines in sample.vcf do not have IDs that start with rs18?  

#### Exercise 4

How many lines in sample.vcf have the reference allele A?

_____________
## 3. awk

*We will be using a bed file in this workshop.
Download t_guttata.bed*

A bed file has the following format (without the headings):

Chromosome  | Start  | End  | Label  | Score  | Strand
----------- | ------ | ---- | ------ | ------ | -------
chr1        | 16298  | 28310| g1.t1  |   0    |+
chr1        | 31486  | 32971| g2.t1  |   0    |+

### What is awk?
awk is a interpreted programming language used primarily for processing text and data extraction.
*awk is pre-installed on your computer*

### Why use awk?
1. Our data is generally in string form and awk is great for string manipulation!
2. We work with a lot of tabular data which awk is great with too!
  * Especially for data extraction
3. It loads data line by line
  * so you don't load your entire file into memory

### What are we going to do today?
1. Learn basic awk syntax
2. Filter a data file
3. Summarize data within the file

###  Basic awk

We will be using the bed file again.

#### basic awk syntax:

`awk 'condition {action}' file.extension`

Try this out see what you get:
`awk '$6 == "+" {print $4}' t_guttata.bed`

To select a column in awk you just need to use its column number:
* $1 = column 1
* $2 = column 2
* $NF = last column
* $0 = all columns

The simplest thing to do in awk is to print a selection of your file. Let's try that.

Here we are printing the end position (column 3) of each line. We are going to pipe it into head to make it easier to visualize.

`awk '{print $3}' t_guttata.bed | head`

If you want to add some text along with the lines being printed you can use double quotes within the print statement

`awk '{print $4, "starts at", $2}' t_guttata.bed | head`

You can also do math in awk:  

`awk '{print $4, "is", $3-$2, "bps long"}' t_guttata.bed | head`

Okay, so that's all well and good but awk can do much more than just print things for you.  

For example you can filter for all the +ve strand entries in two ways:

`awk '$6 == "+" {print $0}' t_guttata.bed | head`
`awk '$6 != "-" {print $0}' t_guttata.bed | head`

or you want to extract only the header from a vcf file:  

`awk '$1 ~ "#" {print $0}' sample.vcf`

**Notice how the condition vs the action is important. The condition can act upon one column but the action can be on another**

You can multiple conditions as well:  

Where both need to be fulfilled:

`awk '$6 == "+" && $2 < 52538597 {print $4}' t_guttata.bed`

Or only one needs to be fulfilled:

`awk '$6 == "+" || $2 < 52538597 {print $4}' t_guttata.bed`

Pipe those into wc to see the difference.

#### Exercise 5
Count the number of variant sites in sample.vcf

#### Exercise 6
