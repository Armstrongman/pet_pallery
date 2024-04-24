# Pet Pallery

- Pet Pallery is a mobile application that will be specifically designed for pet owners and will allow them to do various things on the app. They will be able to post about their animals and allow other people to see those images and videos of said animals. So, in essence, this app will basically be a social media platform specifically for pet owners, but that will not be its only intended purpose and function though. People will also be allowed to give away animals on an adoption tab in the app. This will then allow other people to request to become an adoptee of a certain animal they may be looking at. Users may then be able to get into contact with each other to discuss these matters privately. It can help solve the issue of cutting out the middleman of an animal shelter and can allow for people to discuss a transaction from owner to owner. These two functions of the app will are the most important features of the application.


## Project Requirements
- Total of 114 User Stories.
- 2 Have been taken out of scope.
- As of now (4/24/24), 99/112 have been completed
<details>
  <summary>Functional Requirements <i>(111/112)</i></summary>
  
  - _Login Page_
    - [x] As a user I would like to input my username or email so that I can access my account
    - [x] As a user I would like to input my password so that I can access my account
    - [x] As a system I would like to check username/email against credential database so that I can verify user
    - [x] As a System I would like to display a login error message if the username/email and/or password is incorrect so that access to the social media app is not accessible without an account
  - _Registration Page_
      - [x] As a user I would like to be able to register an account so that I can have my own personal account for the app.
      - [x] As a user I would like to enter a username for my account so that I can use it to login to my account after registration
      - [x] As a system I would like to ensure that the username has not already been taken and the field is not empty so that the user has a unique username
      - [x] As a user I would like to enter an Email Address for my account so that I can use it to login to my account after registration an account
      - [x] As a system I would like to ensure that the Email Address has not already been taken and the field is not empty so that the user has a unique and valid Email address
      - [x] As a user I would like to be able to enter a City of where I live so that I can have that information on my account
      - [x] As a user I would like to be able to select a State from the dropdown menu so that I can have that information on my account.
      - [x] As a user I would like to enter a password for my account so that I can use it to login to my account after registration
      - [ ] As a system I would like to ensure that the password is at least 8 characters and has 1 special character so that my users have a secure password
  - _Navigation_
      - [x] As a user I would like to be able to access the home page with the bottom navbar so that I can see my current home page.
      - [x] As a user I would like to be able to access the search page with the bottom navbar so that I can see the search page
      - [x] As a user I would like to be able to access the Adoption page with the bottom navbar so that I can see the adoption page
      - [x] As a user I would like to be able to access my user profile page with the bottom navbar so that I can see my profile's page
      - [x] As a system I would like to show the bottom navbar on multiple different pages so that users can have easy access to multiple pages on the app
  - _Home Pages_
      - [x] As a user I would like to be able to view all the comments of any post so that I can see what people are saying about that post
      - [ ] As a user I would like to tap on the heart icon under a post so that I can like that post
      - [x] As a user I would like to be able to tap on a user profile on the home page so that I can view that user's profile
      - [x] As a user I would like to be able to scroll down so that I can see more posts from people I follow
      - [ ] As a system I would like to display posts from accounts that the current user so that the user is able to see what their friends share
      - [x] As a system I would like to display every comment under a post in the comment section so that other users can see what other have to say
      - [x] As a user I would like to be able to comment on a user's post so that they can see what I have said about their post
      - [x] As a user I would like to be able to tap on a user profile who has commented under a post so that I can view that user's profile
  - _Search Page_
      - [x] As a user I would like to search through users via username so that I can look for certain users in the app
      - [x] As a user I would like to be able to tap on a user profile so that I can look at that user's profile
      - [x] As a system I would like to minimize search results as the user types so that the user searching gets more accurate results
      - [x] As a system I would like to display users based on the search so that the user can find the profile they are searching for
  - _Adoption Pages_
    - Main Adoption Page
      - [x] As a system I would like to display random adoptions so that users can apply to any adoption they want to
      - [x] As a system I would like to allow users to narrow down their search by selecting which type of animal/pet they are looking to adopt so that users can only see the type of animals they selected that they would want to adopt
      - [x] As a user I would like to be able to tap on "Apply For Adoption" on a specific adoption profile so that I can apply to adopt that animal
      - [x] As a user I would like to tap on the my "Check My Current Adoptions" button so that I can view all of the current pets I have up for adoption
    - Current Adoption Page
      - [x] As a System I would like to display all of the user's adoption profile they have made so that they can decide what to do with each profile
      - [x] As a user I would like to be able to tap on the "Delete" button on an adoption profile so that I can delete it from my current active adoptions and from the main adoption page
      - [x] As a user I would like to tap on the "Applicants" button on an adoption profile so that I can see all the users who have applied to adopt that animal
      - [x] As a user I would like to tap on the "Edit" button on an adoption profile so that I can edit the fields that are already on that profile
      - [x] As a user I would like to tap on the "Add an Adoption" button on an adoption profile so that I can add another pet that I want to put up for adoption
    - Applicants Page
      - [x] As a system I would like to display all of the users who have applied to adopt that pet so that the user can determine who would be a proper adoptee
      - [x] As a user I would like to be able to tap on an applicant so that I can view their profile page
    - Add Adoption Page
      - [x] As a user I would like to be able to go back to the previous page so that I can back out of making a new adoption profile
      - [ ] As a user I would like to be able to add a photo so that I can show other users what the pet looks like
      - [ ] As a system I would like to allow users to use photos from their phone so that they can have easy access to any photo of their pet on their phone
      - [x] As a user I would like to be able to type out the name of my pet so that I can show other users what the pet's name is
      - [x] As a system I would like to ensure that the name of the pet field has text in it so that the user can not submit a pet adoption profile with no name
      - [x] As a user I would like to be able to type out a description for my pet so that I can show other users a brief description of the pet
      - [x] As a system I would like to ensure that the description of the pet field has text in it so that the user can not submit a pet adoption profile with no description
      - [x] As a user I would like to be able to type out a Location so that I can show other users where this pet resides
      - [x] As a system I would like to ensure that the location field has text in it so that the user can not submit a pet adoption profile with no location
      - [x] As a user I would like to declare what type of animal the pet is through a dropdown box so that I can show other users what type of animal the pet is
      - [x] As a system I would like to ensure that an option has been selected	 so that the user can not submit a pet adoption profile without selecting what type of animal the pet is
      - [x] As a user I would like to submit the new adoption profile after filling all the fields so that other users can apply to adopt this animal
    - Edit Adoption Page
      - [x] As a user I would like to be able to go back to the previous page so that I can back out of editing profile
      - [ ] As a user I would like to be able to change the photo so that I can show other users a different photo of what the pet looks like
      - [ ] As a system I would like to allow users to use photos from their phone so that they can have easy access to any photo of their pet on their phone
      - [x] As a user I would like to be able to change the name of my pet so that I can show other users what the pet's new name is
      - [x] As a system I would like to ensure that the name of the pet field has text in it so that the user cannot update a pet adoption profile with no name
      - [x] As a user I would like to be able to change the description for my pet so that I can show other users a new brief description of the pet
      - [x] As a system I would like to ensure that the description of the pet field has text in it so that the user cannot update a pet adoption profile with no description
      - [x] As a user I would like to be able to change the Location so that I can show other users the updated location of where this pet resides
      - [x] As a system I would like to ensure that the location field has text in it so that the user cannot update a pet adoption profile with no location
      - [x] As a user I would like to change what type of animal the pet is through a dropdown box so that I can show other users what type of updated animal the pet is
      - [x] As a system I would like to ensure that an option has been selected so that the user cannot update a pet adoption profile without selecting what type of animal the pet is
      - [x] As a user I would like to update the adoption profile after making sure all the fields are not empty so that other users can see the new updates to this adoption profile
    - Apply For Adoption Page
      - [x] As a user I would like to be able to go back to the previous page so that I can back out of applying to adopt this pet
      - [x] As a User I would like to type out my name so that the user giving up the pet for adoption can see who I am
      - [x] As a user I would like to type out my phone number so that the user giving up the pet for adoption can see how to contact me
      - [x] As a system I would like to ensure that the name of the name field has text in it so that the user can not submit an application with no name
      - [x] As a system I would like to ensure that the name of the phone number field has text in it and is a proper phone number so that the user can not submit an application without a proper phone number
      - [x] As a user I would like to type out the reason why I want to adopt so that the user giving up the pet for adoption can determine if it is a good reason
      - [x] As a system I would like to ensure that the name of the reason field has text in it so that the user can not submit an application with no reason behind it
      - [x] As a user I would like to submit an application for the specific adoption profile so that the user giving up the pet for adoption know I am interested in getting the pet so that I can see their posts in my home page
  - _User Pages_
    - User Page
      - [x] As a user I would like to be able to follow the user so that I can see their posts in my home page
      - [x] As a user I would like to be able to tap on a specific pet profile so that I can see all the posts of that specific pet
      - [x] As a system I would like to display a message if the profile has no pet profiles so that other users can be notified when visiting this profile
    - Current User Page
      - [x] As a user I would like to be able to tap on Edit Profile so that I can change parts of my profile
      - [x] As a user I would like to make a new Pet profile so that I can share another one of my pets on the app
      - [x] As a user I would like to be able to tap on view a pet profile so that I can view all the posts that I have made to that pet profile
      - [x] As a user I would like to be able to tap on edit a pet profile so that I can update information about that pet if need be
      - [x] As a user I would like to be able to tap on add new post to a pet profile So that I can make new posts to the specific pet selected
    - Edit Profile Page
      - [x] As a user I would like to be able to go back to the previous page so that I can back out of editing my profile
      - [ ] As a user I would like to be able to add a photo so that I can update the profile picture of my profile
      - [ ] As a system I would like to allow users to use photos from their phone so that they can have easy access to any photo of their pet on their phone
      - [x] As a user I would like to be able to update my Username so that I can display a different username in the app
      - [x] As a system I would like to ensure that the username has not already been taken and the field is not empty so that the user has a unique username when updating it
      - [x] As a user I would like to be able to update City of where I live	so that I can update that information on my account
      - [x] As a user I would like to be able to update my State from the dropdown menu so that I can have that information on my account
      - [x] As a user I would like to save the changes I've made to my profile based off the new information I inputted so that the app can utilized the new information
  - _Pet Pages_
    - New Pet Page
      - [x] As a user I would like to be able to go back to the previous page so that I can back out of making a new pet profile
      - [ ] As a user I would like to be able to add a cover photo so that I can show other users what my pet looks like
      - [ ] As a system I would like to allow users to use photos from their phone So that they can have easy access to any photo of their pet on their phone
      - [x] As a user I would like to input the name of my pet so that it can be shown on my profile page under that specific pet profile
      - [x] As a system I would like to ensure that the name field is not empty so that other users can know the name of the pet is when viewing the user/pet profiles
      - [x] As a user I would like to declare what type of animal my pet is through a drop down box so that I can show other users what type of animal the pet is
      - [x] As a system I would like to ensure that an option has been selected so that the user can not make a new pet profile without selecting what type of animal the pet is
      - [x] As a user I would like to be able to create the profile after entering all information so that I can successfully add it to my profile
    - Edit Pet Page
      - [x] As a user I would like to be able to go back to the previous page so that I can back out of updating a pet profile
      - [ ] As a user I would like to be able to add a new cover photo so that I can show other users what my pet looks like using a different photo
      - [ ] As a system I would like to allow users to use photos from their phone so that they can have easy access to any photo of their pet on their phone
      - [x] As a user I would like to change the name of my pet so that it can be shown on my profile page under that specific pet profile
      - [x] As a system I would like to ensure that the name field is not empty so that other users can know the name of the pet is when viewing the user/pet profiles
      - [x] As a user I would like to update what type of animal my pet is through a drop down box so that I can show other users what type of animal the pet is
      - [x] As a system I would like to ensure that an option has been selected so that the user can not make a new pet profile without selecting what type of animal the pet is
      - [x] As a user I would like to be able to update the profile after entering all information so that I can successfully update the pet profile
    - Specific Pet Page
      - [x] As a System I would like to show all the posts of a specific pet profile selected so that users who want to see every post of a specific pet, can see them on this page 
  - New Post Page
    - [x] As a user I would like to be able to go back to the previous page so that I can back out of making a post
    - [x] As a user I would like to be able to add a photo or video for my post so that I can show off my pets
    - [x] As a system I would like to allow users to use photos or videos from their phone so that they can have easy access to any photo or video of their pet on their phone
    - [x] As a user I would like to be able to type out a description for the post so that other users can read the description of the post
    - [x] As a user I would like to upload my post after picking a photo or video and writing a description for my post	 so that other users who follow me or search me can see it
</details>

<details>
  <summary>Non Functional Requirements <i>(1/112)</i></summary>
  
  - Security
    - [x] As a system I would like to store passwords in my database  securely by using a strong encryption so that the length of the encrypted password meets the standard of 256 bytes
</details>
</details>


## Technologies Utilized During Developement
| Technologies | Versions | Justification For Use |
| :---: | :---: | --- |
| Flutter | Version 3.13.3 | Flutter is a great framework to use for mobile app development |
| Dart | Version 3.1.1 | Dart is the programming language that Flutter uses |
| VS Code | Version 1.83.0 | VS Code allows for developers to use emulators for mobile app development for testing purposes |
| Firebase Database | Version 10.2.7 | Firebase is ideal for mobile applications and provides real-time synchronization and offline support. |


## Newly Learned Technologies
### Flutter
- Flutter is an open-source UI toolkit developed by Google for building natively compiled applications for mobile, web, and desktop from a single codebase. It provides a rich set of pre-designed widgets for creating visually appealing and responsive user interfaces. Flutter's "hot reload" feature allows developers to quickly see changes in real-time, speeding up the development process. Its layered architecture enables high performance and customizable designs, making it popular for building cross-platform applications with fast development cycles.
- My reasoning for wanting to utilize this technology was because I wanted to build a mobile application which is something I had never done before the development of this application. After researching different mobile app developement frameworks the main two I saw were this one and React Native. With already knowing a little about React, I wanted to further challenge myself with learning a completely foreign framework for myself.
### Dart
- Dart is a programming language developed by Google, known for its simplicity and efficiency in building web, mobile, and server applications. It's strongly typed with optional type annotations and supports both object-oriented and functional programming paradigms. Dart's just-in-time (JIT) compilation enables rapid development and "hot reload" for fast iteration during coding. Additionally, Dart can be ahead-of-time (AOT) compiled for performance-optimized production deployment.
- The reason why I used Dart is because this is the programming language that Flutter utilizes in order to make full stack mobild applications. This again, was a new technology that I had to learn from the ground up in order to develop this application.
### Firebase
- Firebase is a platform developed by Google that offers a suite of tools and services for building and managing web and mobile applications. It provides features such as authentication, real-time database, cloud storage, hosting, and analytics, enabling developers to focus on creating high-quality user experiences without worrying about infrastructure. Firebase's real-time database allows for seamless data synchronization across devices, while its authentication service simplifies user management and access control. With Firebase's scalable infrastructure and comprehensive set of features, developers can rapidly develop, deploy, and scale their applications with ease.
- For smaller mobile applications, Firebase is easy to not only connect to an exisiting application but to also manage which is why I decided to use it as my backend. Firebase also provides a number of services:
  - Authentication for holding user information in your database
  - Firestore to hold an assortment of different data
  - Storage to hold files such as images, videos, and etc.


## Technical Approach
### Sitemap
![image](https://github.com/Armstrongman/pet_pallery/assets/82784312/e1be82c7-c40d-4c2c-a180-97ab6137cfcc)
- Wanted to ensure that my program had no dead ends. Sitemap provides indepth desgin to ensure this.

### Schema Design
![image](https://github.com/Armstrongman/pet_pallery/assets/82784312/06425722-a6ec-40ea-8257-7c69998a4c41)
- The schema present here is representative of how the collections are stored and connected to one another in Firebase Firestore. It is important to note that the database management system I will be using, Firebase, is a no SQL database. This means that the traditional means of connecting tables/collections together in a SQL database are different as opposed to a no SQL database. So, things such as foreign keys are not needed. Instead, references to other tables/collections will be made with ids that are randomly generated when an addition to a collection is made. References are stored as strings to connect tables together

### Physical Solution Design
![image](https://github.com/Armstrongman/pet_pallery/assets/82784312/50e4cb5a-cb0b-455a-b319-0468e0c89151)
- This image is for the physical solution design of this project. It is very simple in nature as it is a mobile application that is being displayed to an emulator that is only connecting to a backend database management system in Firebase. Firebase allows us to read and write to a cloud database in Firestore and lets us store and read from users through its authentication service as shown below. For this purpose, this mobile application will only be running on the Google Pixel 3 emulator, but this may be subject to change as the application goes through the development process. The way that the database connects with the application is through a webhook that is established during the development process of the application through the Firebase command line interface being ran through the project as is explained later in this document.
- If the application were deployed, this design would change to accomadate that

### Logical Solution Design
![Logical Solution Design](https://github.com/Armstrongman/pet_pallery/assets/82784312/a25e70ff-dca8-41b8-806e-97feb5754ed7)
- The logical solution design was made to show exactly how each of the different layers will interact with one another. Starting from the top, the presentation layer represents all of the different widgets and components that will be visible when the application is run on a mobile device. On certain components and widgets, data will be pulled from a backend database management system in Firebase using a webhook which will allow us to use both their firestore cloud database as well as their authentication service to store users and the storage of files as well. This can be seen at the bottom of the diagram. To connect this database to the application so that data within it can be shown in the presentation layer, there must be a service layer to handle this business. This helps with a good N-Layer architecture design. This layer will consists of models of each of the collections within our database as well as service classes to handle the act of putting the collections from the database to fit into our models. This sort of design is good and though out as it takes into account the separation of concerns that are needed in an app like this.

## Managing Risks and Challenges
### Challenges/Risks I had
- Lack of Knowledge in the three main technologies: Flutter, Dart, Firebase. Managed these through the use of creating proof of concepts (POCs) to ensure that I would be able to actually complete the requirements for the application that I gave myself.

## Project Phases
### Phase 1
Heavily backend focused and dependent. Connection to database and manipulating and showing data to and from database. Phase 1 will be completed once all user stories have been completed
### Phase 2
The look and feel of the App. How each page looks, not necessarily functions. Make app look more pleasing to the eye. Very frontend heavy focusing on both UI/UX of the application
### Phase 3
Deploy mobile application to app stores across multiple different types of devices (App Store & Google Play)
