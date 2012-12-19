module ProjectsHelper
  def project_for_template(project)
    {
      url: project_url(project),
      name: project.name,
      description: project.description
    }
  end
end
