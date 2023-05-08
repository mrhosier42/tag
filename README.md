# README

# About
This app is a continuation of the development of the previous capstone team and GA's that have worked on this app.
This app was upgraded from an old version of rails framework (6.1) and ruby language (2.7), the reason for the upgrade was to make the app compaitble to run on Mac M1 chips, which were not supported at the time. I've also revamped every single page to make it more modern, removed extra cluttered/unucessary pages and merged those pages functionality into the relevant page for seamless access. I've also fixed countless bugs and overhauled some of the existing features, such as the navbar content (now a dropdown), among other things.
[Previous Repo Link](https://github.com/amyshannon/capstoneApp)

# Tool-Assisted Grading (TAG)
TAG is a web-based application designed to assist professors and teaching assistants in evaluating and grading students. With this application, you can manage grading student an client survey survey's served by Qualtrics (and more features to come).

This application is built on Ruby on Rails web framework.

## Prerequisites
### You'll need these specific versions
* Ruby - v3.2.1 (curretly latest version)
* Node - v19.8.1 (currently latest version)

# Installating Software
## Windows or Linux/macOS
#### NOTE: Be sure to download and install the corresponding operating system supported files.
1. Download and install [Ruby](https://www.ruby-lang.org/en/downloads/releases/)
2. Download and install [Node](https://nodejs.org/en/download/)
3. Download and install [Postgress](https://www.postgresql.org/download/)

## Using the software
1. Create a workspace folder to download your application.
2. Navigate to your new workspace directory.
3. Clone the repository using the following command: ```git clone git@github.com:mrhosier42/tag.git```
4. Install Rails: open your terminal, navigate to your project folderand run the following command: ```gem install rails```
5. Install the necessary dependencies using the following command: ```yarn install```
6. Install Ruby gems using the following command: ```bundle install```
7. Create the database using the following command: ```rails db:create```
8. Run the database migrations using the following command: ```rails db:reset db:migrate```
9. Start the server: ```rails server```
10. Type ```localhost:3000``` into your browser.


## Navigation to survey's:
1. Sign up with a new account.
2. Create a new semester.
3. Input client and student survey data.
4. Select a sprint and semester.
5. View the page team you want to review.


