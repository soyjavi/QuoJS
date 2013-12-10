describe "Core", ->

  body = undefined

  beforeEach ->
    body = $$(document.body)
    document.body.innerHTML = """<section id="quo" class="quo"></section>"""


  it "is healthy", ->
    expect(Quo).toBeTruthy()
    expect($$).toBeTruthy()


  it "select body", ->
    expect(body).toBeTruthy()
    expect(body.length > 0).toBeTruthy()


  it "select by tag element", ->
    tag = $$ "section"
    expect(tag).toBeTruthy()
    expect(tag.length > 0).toBeTruthy()


  it "select by Id", ->
    id = $$ "#quo"
    expect(id).toBeTruthy()
    expect(id.length > 0).toBeTruthy()


  it "select by className", ->
    className = $$ ".quo"
    expect(className).toBeTruthy()
    expect(className.length > 0).toBeTruthy()


  it "if select doesn't exists array is empty.", ->
    el = $$ "article"
    expect(el.length is 0).toBeTruthy()
