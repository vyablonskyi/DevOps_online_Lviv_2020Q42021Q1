**Report of Task 1.1**

Git was installed on my personal computer.
Then I created account on GitHuband and private repository DevOps_online_Lviv_2020Q42021Q1 with described structure 
After that there were performed steps 6-18 from instruction by running the following commands:
```
$ git config --global user.name "Volodymyr Yablonskyi"
$ git config --global user.email vyablonsky@gmail.com
$ git clone https://github.com/vyablonskyi/DevOps_online_Lviv_2020Q42021Q1
$ cd m1/task1.1/
$ git add readme.txt
$ git commit
$ git checkout -b develop
$ git add index.html
$ git commit
$ git checkout -b images
$ git add images
$ git add images/git.png
$ git commit
$ git add index.html
$ git commit
$ git checkout develop
$ git checkout -b styles
$ git add css
$ git add css/style.css
$ git commit
$ git add css/style.css
$ git add index.html
$ git commit
$ git checkout develop
```

At that moment there were four branches. Below you may see files/folders in each branch and views of index.html files

>(main)

- readme.txt

>(images)

- images/git.png 
- index.html
- readme.txt

[index.html](screenshots/001.JPG)

>(styles)

- css/style.css
- index.html
- readme.txt

[index.html](screenshots/002.JPG)

>(develop)

- index.html
- readme.txt

After performing steps 19-21 there were the following files/folders in "main" branch:

- css/style.css
- images/git.png
- index.html
- readme.txt

and how was index.html file shown after conflict was solved:

[view](screenshots/003.JPG)

All local branches were pushed into GitHub

After checking git logs there was created the "task1.1_GIT.txt" file with git reflog results, AndriiKostromytskyi was invited, and "task1.1_GIT.txt" was added to local and origin repositories. 


**A few words about what DevOps is**

DevOps is a bunch of mechanisms that mixes Development and Operations. It bases on a Agile development method.
DevOps goals are automating and integrating processes, they give possibility to build, test, release software faster and more quality.  
DevOps engineer should  combine knowledges about system architecture  and administration, and also be familiar with using source control, giving and receiving code reviews, writing tests, and interpretating of reports results on each step of working with software development.
