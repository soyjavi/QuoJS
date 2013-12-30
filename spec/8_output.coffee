describe "Output", ->

  el = undefined
  markup = """
    <header>
      <nav>
        <a href="#">One</a>
        <a href="#">Two</a>
        <a href="#">Three</a>
      </nav>
    </header>
    <article></article>
    <article></article>
    <footer></footer>
    """

  beforeEach ->
    document.body.innerHTML = """
      <section class="quo">#{markup}</section>
    """
    el = $$ "section"


  it "can set/get text to a given element", ->
    value = "hello"
    el.text value
    expect(el.text()).toEqual value


  it "can get html value to a given element", ->
    expect(el.html()).toEqual markup


  it "can set html value to a given element", ->
    new_markup = "<aside></aside>"
    el.html new_markup
    expect(el.html()).toEqual new_markup


  it "can remove the set of matched elements to a given element", ->
    el.remove()
    expect($$("section").length).toEqual 0


  it "can Remove all child nodes of the set of matched elements to a given element", ->
    el.empty()
    expect(el.html()).toEqual ""


  it "can append a html element to a given element", ->
    li = ["<li>1</li>", "<li>2</li>"]
    el.html li[0]
    el.append li[1]
    expect(el.html()).toEqual(li[0] + li[1])


  it "can prepend a html element to a given element", ->
    li = ["<li>1</li>", "<li>2</li>"]
    el.html li[0]
    el.prepend li[1]
    expect(el.html()).toEqual(li[1] + li[0])


  it "can replace each element in a given element", ->
    new_markup = """
      <header>
        <nav>
          <a href="#">One</a>
          <a href="#">Two</a>
          <a href="#">Three</a>
        </nav>
      </header>
      <article></article>
      <article></article>
      <aside></aside>
    """
    $$("section > footer").replaceWith "<aside></aside>"
    expect(el.html()).toEqual new_markup

