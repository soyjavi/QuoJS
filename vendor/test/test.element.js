
el = $$('input');
el.attr('placeholder', 'Dinamic placeholder setted');
el.val('Hello world');
console.log('The input value is ' + el.val());
el.val('');
el.data('date', '1980');
console.log('The data-date value is ' + el.data('date'));
$$('#box-show').show();
$$('#box-hide').hide();
console.error('#box-show offset is ', $$('#box-show').offset());
console.error('#box-hide offset is ', $$('#box-hide').offset());
$$('#element').addClass('success');


childs = $$('#father', 'article');
childs.last().addClass('success').html('Owned Son')
console.error("childs ->", childs);
