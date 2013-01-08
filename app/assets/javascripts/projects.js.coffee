# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
class ProjectsPager
  constructor: (@page = 1) ->
    $(window).scroll(@check)
  
  check: =>
    if @nearBottom()
      @page++
      $(window).unbind('scroll', @check)
      $.getJSON($('#proj-dropdown').data('json-url'), page: @page, @render)

  nearBottom: =>
    $(window).scrollTop() > $(document).height() - $(window).height() - 100
    
  render: (projects) =>
    for project in projects
      # mustache templates
      $('#proj-dropdown').append SMT['projects/project_dropdown'](project)
    $(window).scroll(@check) if projects.length > 0
    
$ ->
  new ProjectsPager() if $('#proj-dropdown').length
