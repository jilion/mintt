namespace :one_time do

  desc "Empty all the tables"
  task :create_modules => :environment do
    [2010, 2011].each do |year|
      [
        "General Information", "About inventions and inventors", "Evaluate the Potential", "Intellectual Property",
        "Licensing", "Start-up", "From innovation to sales. A long way?", "Case Studies"
      ].each do |module_title|
        TeachingModule.create!({
          :title => module_title,
          :year => year
        })
        puts "All modules created for the #{year} program!"
        puts "If all goes well, current documents should be linked automatically to their respective modules"
        puts "since 'General Information' will keep the module_id 0 and its year (#{year}) is the same as the published_at year of the documents.\n"
      end
    end
  end

  desc "Set all teachers' years to 2010 & 2011"
  task :set_teachers_years => :environment do
    Teacher.update_all(:years => [2010, 2011])
  end

  desc "Set documents' MIME Types"
  task :set_documents_mime_types => :environment do
    Document.all.each do |document|
      document.update_attribute(:mime_type, MIME::Types.of(document.filename).first)
    end
  end

end
