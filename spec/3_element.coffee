describe "Style", ->

  el = undefined

  beforeEach ->
    document.body.innerHTML = """<section class="quo" data-quo="js"></section>"""
    el = $$ "section"

  it "can get a attribute of a given element", ->
    attribute = "class"
    expect(el.attr attribute).toEqual "quo"

  it "can set a attribute in a given element", ->
    attribute = "data-framework"
    value = "quojs"

    el.attr attribute, value
    expect(el.attr attribute).toEqual value

  it "can remove a attribute in a given element", ->
    attribute = "class"
    el.removeAttr attribute
    expect(el.attr attribute).toEqual null

  it "can get a data attribute in a given element", ->
    attribute = "quo"
    expect(el.data attribute).toEqual "js"

  it "can set a data attribute in a given element", ->
    attribute = "framework"
    value = "quojs"

    el.data attribute, value
    expect(el.data attribute).toEqual value

  it "can remove a data attribute in a given element", ->
    attribute = "quo"
    el.removeData attribute
    expect(el.attr attribute).toEqual null
