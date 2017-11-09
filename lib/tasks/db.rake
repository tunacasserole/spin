namespace :db do

  desc 'Runs all seed files under seed folder'
  task seed: :environment do
    Spin::Util::Data::Seeder.run!
  end


end
