# README

This README would normally document whatever steps are necessary to get the
application up and running.

Deploy:
https://english-h2b.herokuapp.com/

Board:
https://app.zenhub.com/workspaces/english-web-5c8d29a18dcdbd6b613785d0/boards?repos=175638072

Things you may want to cover:

* Ruby version: 2.6.1
* Rails version: 5.2.2
* Nodejs
* Postgrest 9.4.10

* System dependencies

* Configuration

* Database creation
  + Write from Dictionary skill
     + Doing step by step:
      1. Create new branch: git checkout write-from-dictionary/database
      2. Modify in file: PATH/english/db/seed.db:
      
      - Add new lines:
         
          write_from_dic =  { <name of audio 1> => <content of audio 1>,
          
                         <name of audio 2> => <content of audio 2>
            
                           }
          
        # Example: 
        
        write_from_dic = { "1.wav" => "Ha is surfing web",
        
                           "2.wav" => "Cong is sleeping"
                           
                          } 
      3. Create folder audio in PATH/english/app/assets/audio/ and Copy all file audios to there.
      4. Push this branch to git 
     

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
