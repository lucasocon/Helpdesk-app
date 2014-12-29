namespace(:db) do

  desc "Populates local database with raw data"
  task :populate => :environment do

    User.delete_all
    Company.delete_all


    3.times do

      account = AccountManager.new(
        company_name: Faker::Company.name,
        email: Faker::Internet.free_email,
        password: "123123123"
      )

      account.save

      company = Company.last

      (5..10).to_a.sample.times do
        user = FactoryGirl.create(:user, :confirmed)
        company.members << user

        if [true, false].sample && company.owners.count < 3
          company.owners << user
        end
      end 
    end


    puts "Done."
    
    puts " - Populated Companies:"
    for company in Company.all
      puts " - > #{company.name}"
    end
    puts " - Populated Users:"
    for user in User.all
      puts " - > #{user.email}"
    end

  end

end
