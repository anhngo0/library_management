# Mini-project: library management (Backend).
( This is the backend part written in Spring boot. You can find the front end part here: <a>https://github.com/anhngo0/library_management_FE.git</a> )

## Install & Run on Localhost
-  Clone this project.  
-  Open this project folder on your terminal.
-  To run the reset password function , please replace the spring:mail:properties:mail:username and spring:mail:properties:mail:password with your suitable email and password.
-  After running successfully, you can use account with username: NhatAn and password: NhatAn to login in manager role. / or username: MaiAnh and password: Graeme139 to login in librarian role
### Using Docker:
        - Prerequisite: Having docker installed on your computer
        - Steps:  Run command 'docker-compose up --build'
### Using Maven
        - Prerequisite: Having jdk-21 and maven installed on your computer
        - Steps: + Run command 'mvn clean install'
                 + Then run 'mvn spring-boot:run'
### Using IDLE like Intellij

## Web Features
- Authentication with Json web tokens (JWTs).
- Authorization with roles and permissions.
- Support pagination with spring hateoas.
- Support Spring boot REST API Documentation (Swagger API)

Web can do following functions:
### For users: 
       - Users can see library's information at common home page 
       - Users can see nominated books at common nominated books page
       - Users can see the information of how to become a member (someone who can
         borrow books, bring them to home then return them after a period of time.)
### For librarians:
       - Login / reset password in case of forgetting password
       - view books / add new books one by one or by excel file/ update book's information / delete book
       - view / create / update/ delete import tikcets
       - view / create / update / delete liquidation tickets
       - view / create / update / delete borrowed book tickets
       - mark the borrowed books as returned on the borrowed book tickets
       - view / create / update / delete member's profile information
       - view herself/himself profile information
## For managers:
       - can do all the things librarian can
       - view / create / update / delete accounts
       - accept or refuse created import ticket / liquidation ticket
       - view / create / update / delete librarian's profile information.
## Tech Stack Used
- Language: Java
- Framework: Spring 
- Database : Postgresql



