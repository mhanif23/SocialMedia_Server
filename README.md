# SocialMedia_Server
Final Project of Intermediate-class Generasi Gigih Batch 1.
Create Social Media API

# Requirment
1. Save username, email, and bio. I also put how to update bio there
2. Post some caption with attachment with maksimum caption limit is 1000 with hashtags.
3. See all post contain hashtag [User can only filter by one hastag at time]
4. See all trending hashtag in last 24h
5. Comment to post with hashtag
6. Attach file like jpg png gif mp4 and another file. [doc/pdf]

#Project Structure

|_ERD
| |_new.png 
| |_social_media.drawio 
|_connector   
| |_db_connector.rb 
|_controllers 
| |_commentController.rb
| |_hastagController.rb
| |_postController.rb
| |_userController.rb
|_models
| |_comment.rb
| |_hastag.rb
| |_post.rb
| |_user.rb
|_spec
| |_controllers
| |_models
| |_spec_helper.rb
| |_test_helper.rb
|_.gitignore
|_.rspec
|_Gemfile       
|_Gemfile.lock       
|_README.md
|_main.rb  
|_social_media.sql


#Instructions
#Prerequisite

1. install Ruby, for developing this app I use ruby 2.7.0
2. install bundler
3. then install all packet in the bundler

4. set up mysql
5. do the commant in the social_media.sql

6. set the env
export DB_HOST=<YOUR_HOST>          
export DB_NAME=social_media
export DB_USERNAME=<YOUR_USERNAME>
export DB_PASSWORD=<YOUR_PASSWORD>

7. rub main.rb 
8. for run test using rspec

#POSTMAN API
https://www.postman.com/collections/578df36252fc12490f9f
https://web.postman.co/workspace/My-Workspace~e525abbc-8062-4ac4-84a9-9841b92e2040/documentation/6168502-f1cca4b1-2871-440e-9388-4b03b3c803e7

#My GCP
http://34.84.166.206:4567
