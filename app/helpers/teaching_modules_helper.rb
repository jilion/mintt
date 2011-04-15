module TeachingModulesHelper

  def module_title(document)
    if document.module_id.present?
      teaching_module = TeachingModule.year(document.published_at.year).where(:module_id => document.module_id).first
      return link_to(teaching_module.title, [:admin, teaching_module]) if teaching_module
    end
    "No module"
  end

end
