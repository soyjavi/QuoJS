
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

el = $$('#replace');
el.replaceWith('<a href="#">New link via <strong>replaceWith</strong></a>');

$$('#set-null').html(null);

