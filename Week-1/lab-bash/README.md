# Bash Lab

## Intro

Let's practice with `bash`, a programming language that runs on the command line!


## Deliverable

Open the jupyter notebook in this folder named solutions.ipynb and type in the exercise titles in one cell, and in another cell the command you used to solve the exercises. 

## Setup

1. Go to the folder where you are running in the terminal. When you run `ls` 
```console
$ ls
```

2. You should see: 
```console
README.md lorem solutions.ipynb
```
3. Try to do all the exercises without changing directories. 

## Exercises

* Print `Hello World` on console.

* Create a new directory named `new_dir`.

* Delete that directory.

* Copy the `sed.txt` file inside the lorem folder to the lorem-copy folder. TIP: It may be necessary to create the lorem-copy folder first. 

* Copy the other two files from the lorem folder to the lorem-copy folder in a single line. 

* Displays the contents of the `sed.txt` file inside the lorem folder. 

* Displays the contents of the `at.txt` and `lorem.txt` files inside the lorem folder. 

* Displays the first 3 lines of the `sed.txt` file inside the lorem-copy folder. 

* Display the last 3 lines of the file `sed.txt` inside the lorem-copy folder. 

* Adds `Homo homini lupus.` to the end of file `sed.txt` inside the lorem-copy folder. 

* Display the last 3 lines of the `sed.txt` file inside the lorem-copy folder. You should now see `Homo homini lupus.`. 

* Replace all occurrences of `et` with `ET` from the `at.txt` file inside the lorem-copy folder. You must use `sed`. 

* Find the active user on the system.

* Find where you are on your file system.

* List the files ending with `.txt` in the lorem folder.

* Count the number of lines that the file `sed.txt` has inside the lorem folder. 

* Counts the number of **files** beginning with `lorem` that are in this directory and in internal directories.

* Find all occurrences of `et` in `at.txt` inside the lorem folder.

* Count the number of occurrences of the string `et` in `at.txt` inside the lorem folder. 

* Count the number of occurrences of the string `et` in all files in the lorem-copy directory. 

## bash files

Any bash command or commands can be stored in a file and executed whenever you want. 
Obviously you can use your favorite editor. We create the file: 
```
$ touch list_files.sh
```

And we include the content we want. In this case list files:
```bash
#!/bin/bash
ls
```

Run the script:
```
$ bash list_files.sh
```

And we will see by console the following output. 
```console
README.md lorem solutions.ipynb
```

## Bonus

* Store in a variable `name` your name.

* Print that variable.

* Create a new directory named after the contents of the `name` variable.

* Delete that directory. 

* Displays the processes in hierarchical form that are running on your computer:
    1. using the top or htop command.
    2. Using the ps command with arguments

* Display information about your processor on the screen

* Create 3 aliases and make them available every time you log in.

* Compress the lorem and lorem-copy folders into a file called lorem-compressed.tar.gz

* Unzip the file lorem-compressed.tar.gz into the folder lorem-uncompressed

* Create a bash script to print the numbers from 1 to 100.
