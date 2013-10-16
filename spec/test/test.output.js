
$$('#box-delete').empty();
console.log('Delete text from output box');
var el = $$('#box-input');
el.text('First insert: text');
el.append('<article>Append a element</article>');
el.prepend('<article>Prepend a element</article>');
html_of_last_article = el.children('article:last-child').html();
el.children('article:last-child').html(html_of_last_article + '>> added a portion of html :)')
$$('#output').addClass('success');

$$('section').first().find('article:last-child').append(' >> cached!');
try {
  console.log('get the text of a non-existent node will return ' + typeof $$('#section-3>article').text());
} catch (e) {
  console.error(e);
}
try {
  console.log('get the html of a non-existent node will return ' + typeof $$('#section-3>article').html());
} catch (e) {
  console.error(e);
}

el = $$('#replace');
el.replaceWith('<a href="#">New link via <strong>replaceWith</strong></a>');

$$('#set-null').html(null);

