$ = jQuery.sub()
Project = App.Project

$.fn.item = ->
  elementID   = $(@).data('id')
  elementID or= $(@).parents('[data-id]').data('id')
  Project.find(elementID)

class New extends Spine.Controller
  events:
    'submit form': 'submit'
    
  constructor: ->
    super
    @active @render
    
  render: ->
    @html @view('projects/new')
    
  submit: (e) ->
    e.preventDefault()
    project = Project.fromForm(e.target).save()
    @navigate '/projects', project.id if project

class Edit extends Spine.Controller
  events:
    'submit form': 'submit'
  
  constructor: ->
    super
    @active (params) ->
      @change(params.id)
      
  change: (id) ->
    @item = Page.find(id)
    @render()
    
  render: ->
    @html @view('projects/edit')(@item)
    
  submit: (e) ->
    e.preventDefault()
    @item.fromForm(e.target).save()
    @navigate '/projects'

class Show extends Spine.Controller
  events:
    'click [data-type=back]': 'back'
    'click [data-type=edit]': 'edit'

  constructor: ->
    super
    @active (params) ->
      @change(params.id)

  change: (id) ->
    @item = Project.find(id)
    @render()

  render: ->
    @html @view('projects/show')(@item)

  back: ->
    @navigate '/projects'
    
  edit: ->
    @navigate '/projects', @item.id, 'edit'

class Index extends Spine.Controller
  events:
    'click [data-type=edit]':    'edit'
    'click [data-type=destroy]': 'destroy'
    'click [data-type=show]':    'show'
    'click [data-type=new]':     'new'

  constructor: ->
    super
    Project.bind 'refresh change', @render
    Project.fetch()
    
  render: =>
    projects = Project.all()
    @html @view('projects/index')(projects: projects)
    
  edit: (e) ->
    item = $(e.target).item()
    @navigate '/projects', item.id, 'edit'
    
  destroy: (e) ->
    item = $(e.target).item()
    item.destroy() if confirm('Sure?')
    
  show: (e) ->
    item = $(e.target).item()
    @navigate '/projects', item.id
    
  new: ->
    @navigate '/projects/new'
    
class App.Projects extends Spine.Stack
  className: 'projects stack'
  
  controllers:
    index: Index
    edit:  Edit
    show:  Show
    new:   New
    
  routes:
    '/projects/new':      'new'
    '/projects/:id/edit': 'edit'
    '/projects/:id':      'show'
    '/projects':          'index'
    '':                'index'
    
  className: 'stack projects'