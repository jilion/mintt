ActionController::Renderers.add :csv do |records, options|
  filename = options[:filename] || 'data'
  if records.present?
    str = records.first.class.respond_to?(:to_csv) ? records.first.class.to_csv(records, options[:style]) : records.to_s
    send_data str, :type => Mime::CSV, :disposition => "attachment; filename=#{filename}.csv"
  end
end
