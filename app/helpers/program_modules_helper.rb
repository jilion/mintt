module ProgramModulesHelper
  
  def modules_for_select
    ProgramModule.all.map { |m| ["#{ProgramModule.all.index(m)} - #{m}", ProgramModule.all.index(m)] }
  end
  
  def module_title(module_id)
    module_id.present? ? "#{module_id} - #{ProgramModule.all[module_id]}" : "No module"
  end
  
end