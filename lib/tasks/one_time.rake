namespace :one_time do

  desc "Empty all the tables"
  task :import_2010_modules => :environment do
    [
      "General Information", "About inventions and inventors", "Evaluate the Potential", "Intellectual Property",
      "Licensing", "Start-up", "From innovation to sales. A long way?", "Case Studies"
    ].each do |module_title|
      TeachingModule.create!({
        :title => module_title,
        :year => 2010
      })
      puts "All modules created for the 2010 program!"
      puts "If all goes well, current documents should be linked automatically to their respective modules"
      puts "since 'General Information' will keep the module_id 0 and its year (2010) is the same as the published_at year of the documents."
    end
  end

end
