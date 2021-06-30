# My Bricks App Backend
![Image of different colored Lego Bricks in a pile](https://upload.wikimedia.org/wikipedia/commons/3/32/Lego_Color_Bricks.jpg)

## Purpose and Usage
This Api is designed to fetch and persist Lego sets and their parts (as well as themes and part categories) from the [Rebrickable Api](https://rebrickable.com/api/v3/docs/) for use with the [My Bricks App Frontend](https://github.com/DavidRMorphew/my-bricks-app-frontend).

You can use the seeds file to harvest Lego sets or set the app to download all of the Rebrickable Api (see the section on Seeding the Database).

With the frontend of the App, you can select Lego sets that you own, and have this backend persist that data and also run searches for sets that you could build given all of the parts that you own. 

You can select a broad search with color-substitutions or a strict search that only finds sets that have parts with the exact same colors you own.

The search feature (found in this [file](https://github.com/DavidRMorphew/my-bricks-app-backend/blob/main/app/models/lego_set.rb)) works by

* (1) Selecting only bricks and parts that are not minifigures, accessories, or non-Lego parts. 
* (2) Gathering all of the parts that you own from each set that you own and aggregating how many you have of each part. (For a color-substitution search, color is not used to distinguish the types of parts you own.) 
* (3) Checking each set in the database to see if you 
    - (a) own all of the parts needed to build it and 
    - (b) own enough of each type of part to build it.

## Installation

To install the program, open your terminal and run the following command:
```
git clone git@github.com:DavidRMorphew/my-bricks-app-backend.git
```
You will also need to acquire an Api Key from the [Rebrickable Api](https://rebrickable.com/register), add a `.env` file, and assign the value of the Api key as: `LEGO_API_KEY=<YOUR KEY HERE>`.

## Starting the API Server

Once you've installed the API, open the API's directory:
```
cd my-bricks-app-backend
```
Run:
```
bundle install
```
Then:
```
rails s -p 3001
```

## Seed Data

The current seed file can used to harvest a large number of Lego sets

## License
The app is open source under the terms of the [MIT License](https://github.com/DavidRMorphew/my-bricks-app-backend/blob/main/LICENSE.txt)