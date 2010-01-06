class User < ActiveRecord::Base

def self.save_users(params)
   user=User.find_by_username(params['username'])
   if user == nil
   user=User.new
   user.username=params['username']
   user.save
   end
   return user
 end


end
