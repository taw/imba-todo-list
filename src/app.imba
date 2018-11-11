tag TodoItem
  def ontap
    data:done = !data:done

  def render
    <self>
      <li .done=(data:done)>
        <span.checkboxIcon>
          if data:done
            "☑"
          else
            "☐"
        <span.description>
          data:description

tag TodoList
  def build
    @newTodo = ""

  def addTodo(event)
    event.prevent()
    if @newTodo:length > 0
      data.push({description: @newTodo, done: false})
      @newTodo = ""

  def anyDoneItems
    for item in data
      if item:done
        return true
    false

  def cleanupDone
    let stillTodo = data.filter do |item|
      !item:done
    data.splice(0, data:length, *stillTodo)
    console.log("HI", stillTodo)
    console.log("HI", data)

  def render
    <self.todoList>
      <h2>
        title
      <form.todo :submit.addTodo>
        <input[@newTodo] placeholder="What's next?">
        <button type="submit">
          "ADD"
      <ul>
        for item in data
          <TodoItem[item]>
      if anyDoneItems
        <button :tap.cleanupDone>
          "Cleanup DONE"

tag App
  prop catTodos
  prop robotTodos

  def build
    @catTodos = [
      { description: "Feed the cat", done: true },
      { description: "Take cat pics", done: true },
      { description: "Post cat pics online", done: false },
    ]
    @robotTodos = [
      { description: "Order DeathBot parts", done: false }
      { description: "Build DeathBot", done: false }
      { description: "Kill All Humans", done: false }
    ]

  def render
    # Just some starting data
    <self>
      <h1>
        "The amazing TODO list"
      <TodoList[@catTodos] title="Cat Todos">
      <TodoList[@robotTodos] title="Robot Todos">

Imba.mount <App>
