describe "Element", ->

  el = undefined

  beforeEach ->
    document.body.innerHTML = """<input type="text" class="quo" data-quo="js" value="1980"/>"""
    el = $$ "input"

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


  it "get a value of a given element", ->
    value = "1980"
    expect(el.val()).toEqual value


  it "set a value of a given element", ->
    value = "1983"
    el.val value
    expect(el.val()).toEqual value


  it "can show a given element", ->
    el.show()
    expect(el.style "display").toEqual "block"


  it "can hide a given element", ->
    el.hide()
    expect(el.style "display").toEqual "none"


  it "get a offset of a given element", ->
    offset = el.offset()
    expect(offset.left?).toBeTruthy()
    expect(offset.top?).toBeTruthy()
    expect(offset.width?).toBeTruthy()
    expect(offset.height?).toBeTruthy()
