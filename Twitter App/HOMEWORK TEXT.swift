////
////  HOMEWORK TEXT.swift
////  Twitter App
////
////  Created by Cynthia Whitlatch on 10/30/15.
////  Copyright © 2015 Cynthia Whitlatch. All rights reserved.
////
//
//import Foundation

//Create your MVC groups
//Create your Tweet class and your TweetJSONParser class
//In addition to the text & id property, add properties for the username, and profileImageURL ( all string types)
//Parse the json file into tweets, make sure all properties on each tweet are being set. All parsing should be done in your TweetJSONParser class.
//Display those tweet objects in the table view, just the text for the tweet is fine today
//

//CODING CHALLENGE: Write a function that reverses an array
//Tuesday
//
//Use the Accounts framework to access the user's twitter account on their iOS device
//Use the Social framework to make a request to twitter for the users home timeline
//Use a ranged switch statement to make sure the status code of the response is good
//Reload the table view on the main thread (aka main queue) once you are done parsing the JSON data from the response
//Show the downloaded tweets on your table view



//CODING CHALLENGE: FIZZ BUZZ!! :
//Print the numbers 1..100
//For multiples of 3, print "Fizz" instead of the number
//For multiples of 5, print "Buzz" instead of the number
//For multiples of 3 and 5, print "FizzBuzz" instead of the number
//Wednesday
//
//Setup your cells with autolayout so you can see the entire tweets text. If you get any .... at the end that is probably twitters API being stupid
//Create a 2nd view controller that shows an individual tweet in detail
//Upon clicking a tweet, your interface should push (which means you need a navigation controller) to the 2nd view controller and display the tweet selected, but with a few caveats:
//If the tweet that was selected is a retweet, show the original tweet and the original user
//All of this information is available in the original JSON, you just have to go digging for it, and then add properties to your Tweet class accordingly.
//CODING CHALLENGE: Return the number of times that the string "hi" appears anywhere in the given string.
//


//Thursday
//
//Lazily download the user profile images for each tweet you display.
//In your single tweet view controller, upon clicking on the person's image (hint: change the image view to a button, buttons can have images) the app should push a 3rd view controller onto the stack
//This 3rd view controller will show that user's timeline (the api url is "https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name" but you will need to add a parameter to this url.
//Use a table view header view to mimic Twitter's layout of that screen (show their profile background image, their picture, their name, their location)
//Convert your table view cells to use a Nib, so you can share the same cell for both the home time line VC and the user Timeline VC


//CODING CHALLENGE: Given a string, return a version where all the "x" have been removed. Except an "x" at the very start or end should not be removed.
//DATA STRUCTURE THURSDAY: Implement a queue.


//Extra Challenges
//
//Harness the power of the since_id parameter on your api calls. The since_id gives you tweets that are more recent than the id you pass in as the since_id. Combine this, with pull to refresh, to let the user refresh their timelines with the latest tweets.
//Use the max_id parameter. This is similar to since_id, except it gives you tweets older than the id provided as the max_id. So as the user scrolls towards the bottom of the table view, use the max_id to pull down more tweets. You can basically achieve infinite scrolling with this.
//Implement a UITabBarController as the root VC of your app, and add a second tab, which is a view controller for displaying the current user's profile (check twitter's app for reference)
//Implement an image cache so you never download the same image twice
//Twitter's api allows you to download larger images if you request it. Try to get this to work so our images don't look so blurry on retina screens. You will have to go digging through Twitter's API docs to find how this works.