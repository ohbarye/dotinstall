do ->

  # Model

  class Task extends Backbone.Model
    defaults :
      title: 'do something!'
      completed: false

    validate: (attrs) ->
      if(_.isEmpty(attrs.title))
        return 'title must not be empty'

    initialize: ->
      @on('invalid', (model, error) ->
        $('#error').html(error)
      )

  task = new Task()

  # View

  class TaskView extends Backbone.View
    tagName: 'li'

    initialize: ->
      @model.on('destroy', @remove, @)
      @model.on('change', @render, @)

    events:
      'click .delete': 'destroy'
      'click .toggle': 'toggle'
    

    toggle: ->
      @model.set('completed', !@model.get('completed'))

    destroy: ->
      if (confirm('are you sure?'))
        @model.destroy()

    remove: ->
      @$el.remove()

    template: _.template($("#task-template").html())

    render: ->
      console.log(@model.attributes)
      template = @template(@model.attributes)
      @$el.html(template)
      return @

  # Collection

  class Tasks extends Backbone.Collection

    model: Task

  # Collection View

  class TasksView extends Backbone.View
    tagName: 'ul'
    initialize: ->
      @collection.on('add', @addNew, @)
      @collection.on('change', @updateCount, @)
      @collection.on('destroy', @updateCount, @)

    addNew: (task)->
      taskView = new TaskView({model: task})
      @$el.append(taskView.render().el)
      $('#title').val('').focus()
      @updateCount()

    updateCount: ->
      uncompletedTasks = @collection.filter((task) ->
        return !task.get('completed')
      )
      $('#count').html(uncompletedTasks.length)

    render: ->
      @collection.each((task) ->
        taskView = new TaskView({model: task})
        @$el.append(taskView.render().el)
      , @)
      @updateCount()
      return @

  class AddTaskView extends Backbone.View
    el: '#addTask'
    events:
      'submit': 'submit'

    submit: (e) ->
      e.preventDefault()
      task = new Task()
      if(task.set({title: $('#title').val()},{validate: true}))
        @collection.add(task)
        $('#error').empty()

  tasks = new Tasks([
    {title: 'task1', completed: true}
    {title: 'task2'}
    {title: 'task3'}
  ])

  tasksView = new TasksView({collection: tasks})
  addTaskView = new AddTaskView(collection: tasks)

  $('#tasks').html(tasksView.render().el)

