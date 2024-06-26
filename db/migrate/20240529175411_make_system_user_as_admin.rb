class MakeSystemUserAsAdmin < ActiveRecord::Migration[7.1]
  def up
    email = ENV['ADMIN_EMAIL']

    if email
      user = User.find_by(email: email)

      if user
        user.update(admin: true)
        puts "User #{email} is now an admin."
      else
        puts "No user found with email #{email}."
      end
    else
      puts "ENV['ADMIN_EMAIL'] is not set."
    end
  end

  def down
    email = ENV['ADMIN_EMAIL']

    if email
      user = User.find_by(email: email)

      if user
        user.update(admin: false)
        puts "User #{email} is no longer an admin."
      else
        puts "No user found with email #{email}."
      end
    else
      puts "ENV['ADMIN_EMAIL'] is not set."
    end
  end
end
