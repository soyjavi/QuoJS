describe "Output", ->

  el = undefined

  beforeEach ->
    document.body.innerHTML = """
      <section class="quo">
        <header></header>
      </section>"""
    el = $$ "section"


  it "can get the descendants of each element in the current instance", ->
    children = el.find "header"
    expect(children.length > 0).toBeTruthy()


  it "can get the parent of each element in the current instance", ->
    children = el.find "header"
    expect(children.parent()).toEqual el


  it "can get the children of each element in the current instance", ->
    children = el.children()
    header = $$ "section > header"
    expect(children).toEqual header

    el.append "<footer></footer>"
    children = el.children("header")
    expect(children).toEqual header


  it "can retrieve the DOM elements matched by the QuoJS object.", ->
    dom = el.get(0)
    expect(dom).toBeTruthy()
    dom = el.get(1)
    expect(dom).not.toBeTruthy()


  it "can reduce the set of matched elements to the first in the set.", ->
    el.append "<footer></footer>"
    expect(el.children().length).toEqual 2
    expect(el.children().first().length).toEqual 1


  it "can reduce the set of matched elements to the final one in the set.", ->
    el.append "<footer>quojs</footer>"
    last = el.children().last()
    expect(last.length).toEqual 1
    expect(last.text()).toEqual "quojs"
