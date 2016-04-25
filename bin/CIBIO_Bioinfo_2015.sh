#####################################################
#		 NextGen Analysis Workshop - Day 1
# 		 			CIBIO
# 		 		   9/28/15
#####################################################

# Let's get acquainted with the command line interface!

####################
# 1) Basic Commands 
####################

# 1.0 Navigating in the command line 
####################################

# First lets figure out where we are using the ls command
# The ls command lists on the subfolders and files in the directory you are in
# Your terminal window generally boots into your home directory

ls 

# You should see a list of folders in your home directory: Desktop, Downloads, etc.

# Now, you want to go into one of those subfolders
# You can use the change directory (cd) command to do this

cd Desktop

# You should see the end of your terminal prompt change to include ~/Desktop/:
# Let us confirm you are there

ls

# you should now see a list of all the subfolders and files on your desktop

# What if you want to go back to your home folder? 
# You still use the cd command

cd ..
ls 

# You are back in the home folder and should see Desktop, Downloads, etc.

# Changing directories one step at a time is tedious
# If you know where your folder is, you can change your directory in one step

cd desktop/peptide_seqs/seqs_for_aligment

# You just got an error saying that there is no such directory - why?
# Capitalization matters!! 
# Try this now:

cd Desktop/peptide_seqs/seqs_for_aligment

# Typing out folder names is tedious as well, luckily this is a solvable problem
# You can tab and it will autocomplete the name

cd /home/manager/De
# Now hit tab -> it will change to

cd /home/manager/Desktop
# This will only work if there no other folder or file that starts with De


# 1.1 Downloading the data
############################

# Before we move on to more complex things, we need some practice data
# We can download data from external servers using the wget command

# We are going to connect to courtney's website using SFTP (secure file transfer protocol)

sftp u72768223-CIBIOWS@courtneyhofman.com

# You may get a yes/no security prompt. type yes
# You will be prompted to enter a password: CIBIOWorkshop1!
# Type this in, hit enter. it will not show up as you type
# If it accepts the password: you will see the command prompt change to this >sftp

ls

# You should see a folder called to_download

cd to_download
ls

# You will see a folders named Day1 and Day2

get -r *

# This will download everything in the folder to_download

exit

# To exit the sftp site

# 1.2 Manipulating Directory Structure
#######################################

# So, all our data was downloaded to the home folder
# But we want our data to be in a folder on the desktop

# first let us make that folder: mkdir command

cd Desktop

mkdir Workshop

# A folder named Workshop should appear on the Desktop

cd Workshop

##### Exercise A #####

# Make a directory named Day1
# inside Day 1 make two folders test1 and test2
# Use the appropriate command to view the folders within Workhop to see if you were successful
# Paste your commands below:





# Now let's delete the folders

rmdir test2
ls 

# Workshop should only contain test1 now

cd ..
rmdir Day1

# You should get an error saying Day1 is not empty

rm -r Day1 
ls

# Day1 should be gone

# Now let's move our downloaded folders to Workshop

mv /home/manager/Day1 /home/manager/Desktop/Workshop/

##### Exercise B #####

# Move Day2 to Workshop
# Go to the folder Workshop
# Check if Day1 and Day2 are there
# Paste your commands here:





# 1.2 Visualizing & Manipulating Files
#######################################

cd /home/manager/Desktop/Workshop/Day1
cd ExampleFastas
ls

# You should see two example fasta files 
# Let's visualize one of them using the less command

less HSBGP.fasta

# You should see a short fasta file
# To exit this screen hit q
# This is a good way to get a quick idea of what your data looks like
# Now, lets play with it

# I accidently named one file HSGLTH instead of HSGLTH1
# I want to be more specific, so let's change its name
# We can do this by using the mv command
# Think about what we have used this command before for

mv HSGLTH.fasta HSGLTH1.fasta

# You have renamed your first file!

# Now, what if we want to combine the two fastas into one?
# We can do this by using the cat command

cat HSBGP.fasta HSGLTH1.fasta

# You just a concated file in your terminal output
# But we want it as an actual file

cat HSBGP.fasta HSGLTH1.fasta > combined.fasta 
ls

# You should see combined.fasta 

##### Exercise C #####

# Combine HSBGP.fasta and combined.fasta and name it combined2.fasta
# Rename combined.fasta to combined1.fasta
# Paste your commands here:





#########################
# 2) Less Basic Commands 
#########################


# 2.0 Searching files using grep
#################################

# Now that you can manipulate files, lets try to searching within them
# The grep command is used for this task

cd /home/manager/Desktop/Workshop/Day1/grep

# In this folder you have been provided with a blast output for some sequences (blast.txt)
# Use the appropriate command to take a look at the file
# Close the file

# So, what if we wanted to know what sequences blasted to zebra finch 

grep 'zebra finch' blast.txt

# you should see a list of all the rows that have zebra finch in it
# Let's subset this output into a new file

grep 'zebra finch' blast.txt > zeb_blast.txt
ls

# you can search for multiple words as well

egrep -w 'zebra finch|common carp' blast.txt 

# what if we wanted to count the number of sequences that blasted to zebra finch
# guess what, we can! 

grep -c 'zebra finch' blast.txt

# Now, you want all to extract all the sequences that do now blast to zebra finch

grep -v 'zebra finch' blast.txt

##### Exercise D #####

# Extract all the sequences that did and did not blast to common carp
# Put them into two separate files
# How many blasted to common carp?
# Write your commands below






# 2.1 Downloading programs from the interwebs
##############################################

# If you have the url to a site, you can download files in the command line
# This is called the wget command
# Here we are going to download the program prinseq

cd /home/manager

wget http://sourceforge.net/projects/prinseq/files/standalone/prinseq-lite-0.20.4.tar.gz/download

# This program is zipped in a specific way - called a tarball
# Unpack it

tar -xzf download

# Bioinformatics involves many standalone programs that are not installed using usual methods
# In order to be organized and to not go bonkers you put all your programs into a single folder
# Generally, usr/local/bin

mv prinseq-lite-0.20.4 /usr/local/bin

# You just got an error: permission denied
# Somethings in linux require admin permission, and your user is not a root user
# It is best not to work as a root user so if you mess something up, its fixable
# sudo lets you access root user priviledges, without all the risk 
# With great power user comes great responsibility 

sudo mv prinseq-lite-0.20.4 /usr/local/bin

# You will be prompted to enter a password: workshop

# So, when running a command line program the computer needs to know where to search for it
# In this case you put the program in bin where it already searches, but for future reference
# To tell it you update the path in which it searches
# you do this by updating the path variable

export PATH=$PATH:/usr/local/bin

# We will discuss quality filtering in detail tomorrow
# Here we are using this program to elucidate some other cool functions 
# Briefly, however, it uses the phred score of a sequence to sort good and bad sequences 

###############################
# 3) Intermediate-ish Commands 
###############################

# 3.1 Simple Loops
####################

# With NGS data you are often working with multiple files
# So, loops become useful
# You dont have to execute the same command a thousand times 
# Less frustrating 

# Let's first run prinseq without a loop 

cd uce

perl prinseq-lite.pl -verbose -fastq A-u-concolor-347729_S5_L001_R1_001.fastq.gz \
 -min_qual_mean 10 -derep 1 -derep_min 6 \
 -out_format 3 -log concolor_347729_log

#### Description of commands
# -verbose = Prints status and info messages during processing
# -min_qual_mean = Filter sequence with quality score mean below min_qual_mean
# -derep = Type of duplicates to filter. 1 = exact duplicates
# -derep_min = to remove sequences that occur more than 5 times, specify -derep_min 6
# -out_format = 3 is fastq

# So, that was a pretty long set of commands
# No one wants to type that in 30 times
# Therefore loops!

# The standard loop format:
# for e in example
# 	do the macarena;
# 	done;

for file in *.fastq; 
	do perl prinseq-lite.pl -verbose -fastq "$file" -min_qual_mean 10 -derep 1 -derep_min 6 -out_format 3 -log "$file.log"; 
	done;

# the word you use after for is an arbitrary variable name
# it can be for hotpinkcake in *.txt

# $file tells the program to use the * as the file name in the loop

##### Exercise E #####

# Move the output from above to new subfolder named output
# Use the command line!!! We're watching you. 
# Go to http://prinseq.sourceforge.net/manual.html
# Read the filter options
# Write a loop to remove sequences with Ns in it (ambiguous bases)
# Write your commands below







##############################
# 4) Fun with Shell Scripts 
##############################

# If we have time for this
# You must have noticed that this document ends in .sh and all the #'s preceeding the comments
# This is because this is written as a shell script 

# If you know what you are doing and you dont want to run each portion of your pipeline 
# You write a shell script that will run your whole pipeline for you
# You can go home, sleep and come back and its done!

# Let's make a small shell script

# 4.1 Write a Shell Script
############################

# Open your text editor
# Copy the following text into it 

echo "I'm tired"
# This is a comment. It will be ignored by the bash
echo "When is coffee time?"

# Save this document on your Desktop as test.sh

sh test.sh

# You should see I'm tired. When is coffee time? 
# You will not see the comment. This is only for your benefit.

##### Exercise F #####

# Take your commands from Exercise E
# Save it as a .sh file in the folder that contains the sequence data
# Delete your old output from Exercise E, using the command line!
# Run the shell script
# Paste commands here:









#################################
# You survived Day 1: Congrats!!
#################################
