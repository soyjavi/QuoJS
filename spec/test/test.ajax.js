// AJAX
$$('#post-html').html('CALL POST: http://api.jquery.com/');
try {
    $$.post('http://api.jquery.com/', {s: 'getjson'}, function(response) {
        $$('#post-html').addClass('success');
    }, 'html');
} catch(error) {
    console.error(error);
}

$$('#ajax-panoramio').html('CALL AJAX: http://www.panoramio.com/map/get_panoramas.php?');
try {
    $$.ajax({
        url: 'http://www.panoramio.com/map/get_panoramas.php?set=public&from=0&to=3&minx=-180&miny=-90&maxx=180&maxy=90&size=medium&mapfilter=true',
        timeout: 10000,
        success: function(response) {
            if (response) {
                $$('#ajax-panoramio').addClass('success').html('AJAX PANORAMIO: ' + response.count + ' photos');
                console.log('CALL AJAX: ', response, response.count, response.photos.length);
            }
        }
    });
} catch(error) {
    console.error(error);
}


$$('#json-panoramio').html('CALL JSON: http://www.panoramio.com/map/get_panoramas.php?');
try {
    $$.get('http://www.panoramio.com/map/get_panoramas.php',
        {
            set: 'public',
            from: 0,
            to: 3,
            minx: -180,
            miny: -90,
            maxx: 180,
            maxy: 90,
            size: 'medium',
            mapfilter: true,
            callback: '?'
        },
        function(response) {
            if (response) {
                $$('#json-panoramio').addClass('success').html('JSON PANORAMIO: ' + response.count + ' photos');
                console.error('CALL JSON: ', response);
            }
        }
    );
} catch(error) {}

$$('#xml-yunait').html('CALL XML: http://www.yunait.com/rest/deals/near');
try {
    $$.ajaxSettings.dataType = 'xml';
    $$.get('http://www.yunait.com/rest/deals/near',
        {
            format: 'xml',
            key: '9152e54733f24f164d43c4652f6a98f451f72d40',
            lat: '43.26865',
            lng: '-2.946119',
            page: 0,
            order: 'importance'
        },
        function(response) {
            if (response) {
                $$('#xml-yunait').addClass('success').html('XML YUNAIT: Succeeded');
                console.log('CALL XML: ', response);
            }
        }
    );
} catch(error) {}

$$('#ajax-html-local').html('LOAD HTML(local): ...');
try {
    $$.ajax({
        url: 'quo-service-async.html',
        dataType: 'html',
        success: function(response) {
            if (response) {
                $$('#ajax-html-local').addClass('success').append('Succeeded');
                console.error('ajax-html-local: ' + response)
            }
        }
    });

} catch(error) {}

$$('#ajax-html-remote').html('LOAD HTML(remote): ...');
try {
    $$.ajax({
        url: 'http://examples.tapquo.com/examples/kitchen-sink/app/sections/remote.html',
        dataType: 'html',
        success: function(response) {
            if (response) {
                $$('#ajax-html-remote').addClass('success').append('Succeeded');
                console.error('ajax-html-remote: ' + response);
            }
        }
    });

} catch(error) {}